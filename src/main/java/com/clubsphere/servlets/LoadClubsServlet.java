package com.clubsphere.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.sql.*;
import org.json.JSONArray;
import org.json.JSONObject;
import com.clubsphere.util.DBUtil;

@WebServlet("/LoadClubsServlet")
public class LoadClubsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONArray clubsArray = new JSONArray();

        try (Connection conn = DBUtil.getConnection()) {
            String query = "SELECT c.id, c.club_name, c.category, c.status, " +
                           "COALESCE(u.name, '—') AS leader_name, " +
                           "(SELECT COUNT(*) FROM club_members m WHERE m.club_id = c.id) AS member_count " +
                           "FROM clubs c LEFT JOIN users u ON c.leader_id = u.id";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                JSONObject club = new JSONObject();
                club.put("id", rs.getInt("id"));
                club.put("club_name", rs.getString("club_name"));
                club.put("category", rs.getString("category"));
                club.put("status", rs.getString("status"));
                club.put("leader_name", rs.getString("leader_name"));
                club.put("member_count", rs.getInt("member_count"));
                clubsArray.put(club);
            }

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("clubs", clubsArray);

            response.getWriter().write(jsonResponse.toString());

        } catch (Exception e) {
            e.printStackTrace();
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            response.setStatus(500);
            response.getWriter().write(error.toString());
        }
    }
}
