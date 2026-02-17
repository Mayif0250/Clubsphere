package com.clubsphere.servlets;

import com.clubsphere.util.DBUtil;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/get-approvals")
public class GetApprovalsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONArray approvalsArray = new JSONArray();

        String query =
            "SELECT " +
            "  cr.id AS request_id, " +
            "  c.club_name, " +
            "  CONCAT(u.first_name, ' ', u.last_name) AS requested_by, " +
            "  cr.status, " +
            "  cr.requested_at " +  // ✅ correct column name
            "FROM club_requests cr " +
            "JOIN clubs c ON cr.club_id = c.id " +
            "JOIN users u ON cr.user_id = u.id " +
            "WHERE cr.status = 'Pending' " +
            "ORDER BY cr.requested_at DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                JSONObject obj = new JSONObject();
                obj.put("request_id", rs.getInt("request_id"));
                obj.put("club_name", rs.getString("club_name"));
                obj.put("requested_by", rs.getString("requested_by"));
                obj.put("status", rs.getString("status"));
                obj.put("requested_at", rs.getString("requested_at")); // ✅ match column name
                approvalsArray.put(obj);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject err = new JSONObject();
            err.put("error", "Database error: " + e.getMessage());
            response.getWriter().write(err.toString());
            return;
        }

        response.getWriter().write(approvalsArray.toString());
    }
}
