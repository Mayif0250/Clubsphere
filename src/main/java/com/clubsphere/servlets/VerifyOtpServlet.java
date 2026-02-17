package com.clubsphere.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;


@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		System.out.println("verify otp servlet hit!");
		
		HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("rgukt_email") == null) {
            response.sendRedirect("user_login_page.html");
            return;
        }
		
        String otpEntered = request.getParameter("otp");

        String otpStored = (String) session.getAttribute("otp");

        if (otpStored != null && otpStored.equals(otpEntered)) {
            response.sendRedirect("reset_password.html");
        } else {
        	System.out.println("Stored OTP: " + otpStored);
        	System.out.println("Entered OTP: " + otpEntered);

        	response.sendRedirect("error.html");
        }
    }
}
