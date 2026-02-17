package com.clubsphere.servlets;

import com.clubsphere.util.DBUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("rgukt_email") == null) {
            // Not logged in
            response.sendRedirect("user_login_page.html");
        } else {
            // Logged in → show ChangePassword.html
            request.getRequestDispatcher("reset_password.html").forward(request, response);
        }
    }
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        


        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("rgukt_email") == null) {
            response.sendRedirect("user_login_page.html");
            return;
        }

        String email = (String) session.getAttribute("rgukt_email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            out.print("New passwords do not match.");
            return;
        }
        Connection conn=null;
        try{
        	conn = DBUtil.getConnection();
            // 2. Update password
            String sqlUpdate = "UPDATE users SET login_password=? WHERE rgukt_email=?";
            try (PreparedStatement ps = conn.prepareStatement(sqlUpdate)) {
                ps.setString(1, newPassword);
                ps.setString(2, email);
                int rows = ps.executeUpdate();
                if (rows > 0) {
                    out.print("Password changed successfully.");
                } else {
                    out.print("Failed to change password.");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("Error: " + e.getMessage());
        }finally {
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("user_login_page.html");
    }
}
