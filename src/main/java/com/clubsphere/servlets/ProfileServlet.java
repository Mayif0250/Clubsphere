package com.clubsphere.servlets;

import com.clubsphere.util.DBUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/profile")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5MB
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		System.out.println("profilepage servlet hit!");

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

        String email = (String) session.getAttribute("rgukt_email");
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        try{
        	conn = DBUtil.getConnection();
            String sql = "SELECT Student_ID, first_name, last_name, phone_number, branch, academic_year, section, interests, bio, profile_image FROM users WHERE rgukt_email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            if (rs.next()) {
            	request.setAttribute("Student_ID", rs.getString("Student_ID"));
            	request.setAttribute("first_name", rs.getString("first_name"));
                request.setAttribute("last_name", rs.getString("last_name"));
                request.setAttribute("phone_number", rs.getString("phone_number"));
                request.setAttribute("branch", rs.getString("branch"));
                request.setAttribute("academic_year", rs.getString("academic_year"));
                request.setAttribute("section", rs.getString("section"));
                request.setAttribute("interests", rs.getString("interests"));
                request.setAttribute("bio", rs.getString("bio"));

                byte[] imgBytes = rs.getBytes("profile_image");
                if (imgBytes != null) {
                    String base64Image = java.util.Base64.getEncoder().encodeToString(imgBytes);
                    request.setAttribute("profileImage", base64Image);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
        	try { if (conn != null) conn.close(); } catch (Exception e) {}
        	try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        }

        request.getRequestDispatcher("profile_page.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("rgukt_email") == null) {
            response.sendRedirect("user_login_page.html");
            return;
        }

        String rgukt_email = (String) session.getAttribute("rgukt_email");
        String Student_ID = request.getParameter("Student_ID");
        String phone_number = request.getParameter("phone_number");
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");
        String branch = request.getParameter("branch");
        String academic_year = request.getParameter("academic_year");
        String section = request.getParameter("section");
        String interests = request.getParameter("interests");
        String bio = request.getParameter("bio");

        Part profileImagePart = request.getPart("profile_image");
        InputStream imageStream = null;
        if (profileImagePart != null && profileImagePart.getSize() > 0) {
            imageStream = profileImagePart.getInputStream();
        }
        
        Connection conn=null;
        PreparedStatement stmt=null;
        try{
        	conn = DBUtil.getConnection();
            String sql;
            if (imageStream != null) {
                sql = "UPDATE users SET Student_ID=?, first_name=?, last_name=?, phone_number=?, branch=?, academic_year=?, section=?, interests=?, bio=?, profile_image=? WHERE rgukt_email=?";
            } else {
                sql = "UPDATE users SET Student_ID=?, first_name=?, last_name=?, phone_number=?, branch=?, academic_year=?, section=?, interests=?, bio=? WHERE rgukt_email=?";
            }



            stmt = conn.prepareStatement(sql);
            stmt.setString(1, Student_ID);
            stmt.setString(2, first_name);
            stmt.setString(3, last_name);
            stmt.setString(4, phone_number);
            stmt.setString(5, branch);
            stmt.setString(6, academic_year);
            stmt.setString(7, section);
            stmt.setString(8, interests);
            stmt.setString(9, bio); //            stmt.setString(10, rgukt_email);
            if (imageStream != null) {
                stmt.setBlob(10, imageStream);
                stmt.setString(11, rgukt_email);
            } else {
                stmt.setString(10, rgukt_email);
            }

            stmt.executeUpdate();
            
            response.sendRedirect("profile");
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
        	try { if (conn != null) conn.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        }

    }
}
