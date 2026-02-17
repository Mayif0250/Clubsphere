package com.clubsphere.servlets;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.clubsphere.util.DBUtil;

@WebServlet("/leader_dashboard")
public class LeaderDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer clubId = (Integer) session.getAttribute("clubId");

        if (clubId == null) {
            response.sendRedirect("user_login_page.html");
            return;
        }

        try (Connection conn = DBUtil.getConnection()){
            // Fetch club details
            PreparedStatement ps1 = conn.prepareStatement("SELECT club_name, category FROM clubs WHERE id=?");
            ps1.setInt(1, clubId);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                request.setAttribute("clubName", rs1.getString("club_name"));
                request.setAttribute("category", rs1.getString("category"));
            }

//            
//            // Members count
//            PreparedStatement ps2 = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE club_id=?");
//            ps2.setInt(1, clubId);
//            ResultSet rs2 = ps2.executeQuery();
//            if (rs2.next()) request.setAttribute("memberCount", rs2.getInt(1));
//
//            // Events count
//            PreparedStatement ps3 = conn.prepareStatement("SELECT COUNT(*) FROM events WHERE club_id=?");
//            ps3.setInt(1, clubId);
//            ResultSet rs3 = ps3.executeQuery();
//            if (rs3.next()) request.setAttribute("eventCount", rs3.getInt(1));
//
//            // Pending join requests
//            PreparedStatement ps4 = conn.prepareStatement("SELECT COUNT(*) FROM club_requests WHERE club_id=? AND status='Pending'");
//            ps4.setInt(1, clubId);
//            ResultSet rs4 = ps4.executeQuery();
//            if (rs4.next()) request.setAttribute("pendingRequests", rs4.getInt(1));
//
//            // Fetch recent members list
//            PreparedStatement ps5 = conn.prepareStatement("SELECT first_name, last_name, rgukt_email, role, registration_date FROM users WHERE club_id=? LIMIT 5");
//            ps5.setInt(1, clubId);
//            ResultSet rs5 = ps5.executeQuery();
//
//            List<Map<String, Object>> members = new ArrayList<>();
//            while (rs5.next()) {
//                Map<String, Object> m = new HashMap<>();
//                m.put("name", rs5.getString("first_name") + " " + rs5.getString("last_name"));
//                m.put("email", rs5.getString("rgukt_email"));
//                m.put("role", rs5.getString("role"));
//                m.put("joined", rs5.getDate("registration_date"));
//                members.add(m);
//            }
//            request.setAttribute("members", members);

            RequestDispatcher rd = request.getRequestDispatcher("leader_dashboard.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
    }
}
