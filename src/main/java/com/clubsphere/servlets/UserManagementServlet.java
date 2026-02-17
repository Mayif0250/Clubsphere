package com.clubsphere.servlets;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.clubsphere.util.DBUtil;

@WebServlet("/user-management")
public class UserManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, Object>> users = new ArrayList<>();

        String query = """
            SELECT id, Student_ID, first_name, last_name, rgukt_email, 
                   phone_number, branch, section, academic_year, role, registration_date
            FROM users
        """;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> u = new HashMap<>();
                u.put("id", rs.getInt("id"));
                u.put("student_id", rs.getString("Student_ID"));
                u.put("first_name", rs.getString("first_name"));
                u.put("last_name", rs.getString("last_name"));
                u.put("email", rs.getString("rgukt_email"));
                u.put("phone", rs.getString("phone_number"));
                u.put("branch", rs.getString("branch"));
                u.put("section", rs.getString("section"));
                u.put("academic_year", rs.getString("academic_year"));
                u.put("role", rs.getString("role"));
                u.put("registered", rs.getTimestamp("registration_date"));
                users.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("users", users);
        request.getRequestDispatcher("user_management.jsp").forward(request, response);
    }
}
