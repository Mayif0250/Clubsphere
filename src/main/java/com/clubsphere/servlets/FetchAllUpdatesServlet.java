package com.clubsphere.servlets;

import com.clubsphere.util.DBUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/FetchAllUpdatesServlet")
public class FetchAllUpdatesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonResponse = new JSONObject();

        try (PrintWriter out = response.getWriter()) {

            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                jsonResponse.put("error", "User not logged in");
                out.print(jsonResponse);
                return;
            }

            int userId = (Integer) session.getAttribute("userId");
            String typeFilter = request.getParameter("type"); // "event" | "announcement" | null

            // 🔹 Build query dynamically based on type filter
            StringBuilder query = new StringBuilder();

            if (typeFilter == null || typeFilter.equals("all")) {
                // Both announcements and events
                query.append(
                    "SELECT a.id, a.title, a.message AS description, 'announcement' AS type, " +
                    "a.target_club_id AS club_id, a.created_at AS date_posted " +
                    "FROM announcements a " +
                    "WHERE (a.target_club_id IN (SELECT club_id FROM club_members WHERE user_id = ?) " +
                    "OR a.target_type = 'all') "
                );

                query.append("UNION ALL ");

                query.append(
                    "SELECT e.id, e.title, e.description, 'event' AS type, " +
                    "e.club_id, e.created_at AS date_posted " +
                    "FROM events e " +
                    "WHERE (e.club_id IN (SELECT club_id FROM club_members WHERE user_id = ?) " +
                    "OR e.target_type = 'all') AND e.status = 'approved' "
                );

                query.append("ORDER BY date_posted DESC");

            } else if (typeFilter.equals("announcement")) {
                query.append(
                    "SELECT a.id, a.title, a.message AS description, 'announcement' AS type, " +
                    "a.target_club_id AS club_id, a.created_at AS date_posted " +
                    "FROM announcements a " +
                    "WHERE (a.target_club_id IN (SELECT club_id FROM club_members WHERE user_id = ?) " +
                    "OR a.target_type = 'all') " +
                    "ORDER BY date_posted DESC"
                );
            } else if (typeFilter.equals("event")) {
                query.append(
                    "SELECT e.id, e.title, e.description, 'event' AS type, " +
                    "e.club_id, e.created_at AS date_posted " +
                    "FROM events e " +
                    "WHERE (e.club_id IN (SELECT club_id FROM club_members WHERE user_id = ?) " +
                    "OR e.target_type = 'all') AND e.status = 'approved' " +
                    "ORDER BY date_posted DESC"
                );
            }

            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(query.toString())) {

                // set userId(s)
                stmt.setInt(1, userId);
                if (typeFilter == null || typeFilter.equals("all")) {
                    stmt.setInt(2, userId);
                }

                ResultSet rs = stmt.executeQuery();
                JSONArray updatesArray = new JSONArray();

                while (rs.next()) {
                    int clubId = rs.getInt("club_id");
                    String clubName = "General";

                    // fetch club name
                    try (PreparedStatement ps2 = conn.prepareStatement("SELECT club_name FROM clubs WHERE id = ?")) {
                        ps2.setInt(1, clubId);
                        ResultSet rs2 = ps2.executeQuery();
                        if (rs2.next()) {
                            clubName = rs2.getString("club_name");
                        }
                    }

                    JSONObject obj = new JSONObject();
                    obj.put("id", rs.getInt("id"));
                    obj.put("title", rs.getString("title"));
                    obj.put("description", rs.getString("description"));
                    obj.put("type", rs.getString("type"));
                    obj.put("club", clubName);
                    obj.put("datePosted", rs.getTimestamp("date_posted") != null
                            ? rs.getTimestamp("date_posted").toString()
                            : "");

                    updatesArray.put(obj);
                }

                jsonResponse.put("updates", updatesArray);
                out.print(jsonResponse);
            }

        } catch (Exception e) {
            e.printStackTrace();
            try (PrintWriter out = response.getWriter()) {
                jsonResponse.put("error", "Server error: " + e.getMessage());
                out.print(jsonResponse);
            }
        }
    }
}
