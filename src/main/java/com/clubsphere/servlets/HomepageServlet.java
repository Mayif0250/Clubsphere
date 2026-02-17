package com.clubsphere.servlets;

import com.clubsphere.util.DBUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;


@WebServlet("/homepage")
public class HomepageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

		System.out.println("homepage servlet hit!");


		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
		    response.sendRedirect("user_login_page.html");
		    return;
		}

		String role = (String) session.getAttribute("role");
		if (role == null || role.equals("admin")) {
		    response.sendRedirect("user_login_page.html");
		    return;
		}

        String rgukt_email = (String) session.getAttribute("rgukt_email");
        ResultSet rs= null;
        PreparedStatement stmt=null;
        Connection conn=null;
        try{
        	conn = DBUtil.getConnection();
            String sql = "SELECT first_name, last_name, rgukt_email, branch, academic_year, section, interests, bio, profile_image " +
                         "FROM users WHERE rgukt_email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, rgukt_email);

             rs = stmt.executeQuery();
            if (rs.next()) {
                request.setAttribute("first_name", rs.getString("first_name"));
                request.setAttribute("last_name", rs.getString("last_name"));
                request.setAttribute("rgukt_email", rs.getString("rgukt_email"));
                request.setAttribute("branch", rs.getString("branch"));
                request.setAttribute("academic_year", rs.getString("academic_year"));
                request.setAttribute("section", rs.getString("section"));
                request.setAttribute("interests", rs.getString("interests"));
                request.setAttribute("bio", rs.getString("bio"));
                request.setAttribute("profile_image", rs.getString("profile_image"));

             //    Convert image blob to base64 if exists
                byte[] imgBytes = rs.getBytes("profile_image");
                if (imgBytes != null) {
                    String base64Image = java.util.Base64.getEncoder().encodeToString(imgBytes);
                    request.setAttribute("profileImage", base64Image);
                }
            }
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        }

        // Forward to homepage.jsp
        request.getRequestDispatcher("homepage.jsp").forward(request, response);
    }
}
