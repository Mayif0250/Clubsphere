package com.clubsphere.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

		
		System.out.println("forgotpass servlet hit!");
        String email = request.getParameter("email");

        // Generate OTP
        String otp = String.valueOf(new Random().nextInt(900000) + 100000);

        // Save OTP in session
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("rgukt_email", email);

        // Send OTP via mail
        try {
            String from = "ro.clubsphere@gmail.com";  // change
            String pass = "xmas ljco rvxa emcd";    // Gmail App Password

            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.trust", "smtp.gmail.com"); // important

            Session mailSession = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(from, pass);
                }
            });
            mailSession.setDebug(true); // see logs in Tomcat console


            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(from));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("ClubSphere Password Reset OTP");
            message.setText("Your OTP is: " + otp);

            Transport.send(message);

            response.sendRedirect("verifyotp_page.html");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error sending OTP: " + e.getMessage());
        }
    }
}
