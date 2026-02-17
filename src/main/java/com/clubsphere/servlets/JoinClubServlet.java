package com.clubsphere.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.clubsphere.util.DBUtil;

@WebServlet("/join-club")
public class JoinClubServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int clubId = Integer.parseInt(request.getParameter("clubId"));
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("user_login_page.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO club_requests (user_id, club_id, status) VALUES (?, ?, 'Pending')");
            ps.setInt(1, userId);
            ps.setInt(2, clubId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("Clublist.jsp");
    }
}
