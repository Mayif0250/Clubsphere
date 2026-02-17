package com.clubsphere.servlets;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.clubsphere.util.DBUtil;

@WebServlet("/admin_dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("AdminDashboardServlet hit!");
        HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
		    response.sendRedirect("user_login_page.html");
		    return;
		}

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();

            String query = "SELECT club_name, category, member_count, status FROM clubs";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();

            List<Map<String, Object>> clubs = new ArrayList<>();

            while (rs.next()) {
                Map<String, Object> club = new HashMap<>();
                club.put("club_name", rs.getString("club_name"));
                club.put("category", rs.getString("category"));
                club.put("member_count", rs.getInt("member_count"));
                club.put("status", rs.getString("status"));
                clubs.add(club);
            }

            request.setAttribute("clubs", clubs);
            RequestDispatcher rd = request.getRequestDispatcher("admin_dashboard.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
