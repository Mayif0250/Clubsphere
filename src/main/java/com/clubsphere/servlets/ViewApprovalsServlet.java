package com.clubsphere.servlets;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.clubsphere.util.DBUtil;

@WebServlet("/view-approvals")
public class ViewApprovalsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, Object>> approvals = new ArrayList<>();

        String query = """
            SELECT cr.id AS request_id, 
                   u.first_name, u.last_name, u.rgukt_email, 
                   c.club_name, c.category, 
                   cr.status, cr.requested_at
            FROM club_requests cr
            JOIN users u ON cr.user_id = u.id
            JOIN clubs c ON cr.club_id = c.id
            WHERE cr.status = 'Pending'
            ORDER BY cr.requested_at DESC
        """;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("request_id", rs.getInt("request_id"));
                map.put("first_name", rs.getString("first_name"));
                map.put("last_name", rs.getString("last_name"));
                map.put("rgukt_email", rs.getString("rgukt_email"));
                map.put("club_name", rs.getString("club_name"));
                map.put("category", rs.getString("category"));
                map.put("status", rs.getString("status"));
                map.put("requested_at", rs.getTimestamp("requested_at"));
                approvals.add(map);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("approvals", approvals);
        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }
}
