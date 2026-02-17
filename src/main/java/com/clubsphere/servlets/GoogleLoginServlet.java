package com.clubsphere.servlets;

import java.io.IOException;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/google-login")
public class GoogleLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // TODO: replace with your real client id and redirect URI
    private static final String CLIENT_ID = "YOUR_GOOGLE_CLIENT_ID";
    private static final String REDIRECT_URI = "http://localhost:8080/ClubSphere/google-callback";
    private static final String SCOPE = "openid email profile";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Create a random state and save in session for CSRF protection
        String state = java.util.UUID.randomUUID().toString();
        request.getSession().setAttribute("oauth_state", state);

        String authUrl = "https://accounts.google.com/o/oauth2/v2/auth"
                + "?client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8")
                + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                + "&response_type=code"
                + "&scope=" + URLEncoder.encode(SCOPE, "UTF-8")
                + "&access_type=offline"
                + "&prompt=select_account"
                + "&state=" + URLEncoder.encode(state, "UTF-8");

        response.sendRedirect(authUrl);
    }
}
