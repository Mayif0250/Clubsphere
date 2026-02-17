package com.clubsphere.servlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.clubsphere.util.DBUtil;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("✅ Login servlet hit!");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT id, first_name, role, rgukt_email FROM users WHERE rgukt_email = ? AND login_password = ?")) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");  // admin | leader | student
                int userId = rs.getInt("id");
                String name = rs.getString("first_name");

                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("userName", name);
                session.setAttribute("role", role);
                session.setAttribute("rgukt_email", email);

                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("admin_dashboard");
                    return;
                }

                if ("leader".equalsIgnoreCase(role)) {
                    // ✅ Fetch the club details for this leader
                    int clubId = -1;
                    String clubName = "";

                    try (PreparedStatement ps2 = conn.prepareStatement(
                            "SELECT c.id, c.club_name FROM clubs c " +
                            "JOIN club_leaders cl ON c.id = cl.club_id " +
                            "WHERE cl.user_id = ?")) {

                        ps2.setInt(1, userId);
                        ResultSet rs2 = ps2.executeQuery();
                        if (rs2.next()) {
                            clubId = rs2.getInt("id");
                            clubName = rs2.getString("club_name");
                        }
                    }

                    // ✅ Store club info in session for use by servlets like get-members
                    session.setAttribute("clubId", clubId);
                    session.setAttribute("clubName", clubName);

                    System.out.println("Leader Logged In → Club: " + clubName + " (ID: " + clubId + ")");
                    response.sendRedirect("leader_dashboard");
                    return;
                }

                // Default → student
                response.sendRedirect("homepage");

            } else {
                request.setAttribute("error", "Invalid email or password");
                response.sendRedirect("user_login_page.html");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.html");
        }
    }
}
