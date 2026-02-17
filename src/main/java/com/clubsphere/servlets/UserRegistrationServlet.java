package com.clubsphere.servlets;

import java.io.IOException;
//import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.clubsphere.util.DBUtil;


@WebServlet("/register")
public class UserRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type
        response.setContentType("text/html");
       // PrintWriter out = response.getWriter();

        // Collect data from the form
        String fullName = request.getParameter("fullname");
        String rguktEmail = request.getParameter("rguktemail");
        String password = request.getParameter("loginpassword");

        // JDBC connection details
//        String jdbcURL = "jdbc:mysql://localhost:3306/practice";
//        String dbUser = "root";
//        String dbPassword = "root123"; // <- Replace this

        Connection conn=null;
        PreparedStatement stmt=null;
        
        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to database
            conn = DBUtil.getConnection();

            // Insert query
            String sql = "INSERT INTO users (Student_ID, rgukt_email, login_password) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, rguktEmail);
            stmt.setString(3, password);

            // Execute update
            int rows = stmt.executeUpdate();
            if (rows > 0) {
            	response.sendRedirect("Registration_Success_page.html");
            } else {
            	response.sendRedirect("Registration_failed.html");
            }

            stmt.close();
            conn.close();

        } catch (Exception e) {
        	e.printStackTrace();
            response.sendRedirect("Registration_failed.html");
        }
    }
}
