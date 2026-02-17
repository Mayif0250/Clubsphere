package com.clubsphere.servlets;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.clubsphere.util.DBUtil;

@WebServlet("/club-management")
public class ClubManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	List<Map<String, Object>> clubs = new ArrayList<>();

        String query = """
            SELECT club_name, category, member_count, status FROM clubs
        """;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

        	while (rs.next()) {
                Map<String, Object> club = new HashMap<>();
                club.put("club_name", rs.getString("club_name"));
                club.put("category", rs.getString("category"));
                club.put("member_count", rs.getInt("member_count"));
                club.put("status", rs.getString("status"));
                clubs.add(club);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("clubs", clubs);
        RequestDispatcher rd = request.getRequestDispatcher("club_management.jsp");
        rd.forward(request, response);
    }
}
