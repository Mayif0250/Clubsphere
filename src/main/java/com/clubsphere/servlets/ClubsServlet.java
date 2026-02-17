package com.clubsphere.servlets;

import com.clubsphere.util.DBUtil;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/clubs")
public class ClubsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("ClubsServlet hit!");

        // 1️⃣ Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("rgukt_email") == null) {
            response.sendRedirect("user_login_page.html");
            return;
        }

        List<Map<String, String>> clubs = new ArrayList<>();

        // 2️⃣ Connect to database and fetch all clubs
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT club_id, club_name, description FROM clubs";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, String> club = new HashMap<>();
                club.put("id", rs.getString("club_id"));
                club.put("name", rs.getString("club_name"));
                club.put("description", rs.getString("description"));
                clubs.add(club);
            }

            // Debug log
            System.out.println("Fetched clubs count: " + clubs.size());
            for (Map<String, String> c : clubs) {
                System.out.println(c.get("id") + " - " + c.get("name"));
            }

        } catch (Exception e) {  
            e.printStackTrace();
            request.setAttribute("error", "Error loading clubs: " + e.getMessage());
        }

        
        request.getRequestDispatcher("clubs.jsp").forward(request, response);
    }
}
