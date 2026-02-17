package com.clubsphere.servlets;

import com.clubsphere.util.DBUtil;
import org.json.JSONObject;

import java.io.*;
import java.net.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/google-callback")
public class GoogleCallbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // TODO: replace with your real credentials
    private static final String CLIENT_ID = "YOUR_GOOGLE_CLIENT_ID";
    private static final String CLIENT_SECRET = "YOUR_GOOGLE_CLIENT_SECRET";
    private static final String REDIRECT_URI = "http://localhost:8080/ClubSphere/google-callback";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String state = request.getParameter("state");
        HttpSession session = request.getSession();
        String sessionState = (String) session.getAttribute("oauth_state");

        // Basic state check
        if (sessionState == null || !sessionState.equals(state)) {
            response.sendRedirect("user_login_page.html?error=invalid_state");
            return;
        }

        if (code == null || code.isEmpty()) {
            response.sendRedirect("user_login_page.html?error=no_code");
            return;
        }

        try {
            // 1) Exchange code for tokens
            String tokenResponse = exchangeCodeForTokens(code);
            JSONObject tokenJson = new JSONObject(tokenResponse);
            String accessToken = tokenJson.optString("access_token", null);
            if (accessToken == null) {
                response.sendRedirect("user_login_page.html?error=token_failed");
                return;
            }

            // 2) Fetch user info
            String userInfo = fetchUserInfo(accessToken);
            JSONObject userJson = new JSONObject(userInfo);

            String email = userJson.optString("email", null);
            String name = userJson.optString("name", "");
            String picture = userJson.optString("picture", "");

            if (email == null) {
                response.sendRedirect("user_login_page.html?error=no_email");
                return;
            }

            // 3) Lookup user in DB and login or create
            try (Connection conn = DBUtil.getConnection()) {

                Integer userId = null;
                String role = "student";
                String firstName = name;
                // Attempt to find existing user by rgukt_email (same column used in your LoginServlet)
                try (PreparedStatement ps = conn.prepareStatement(
                        "SELECT id, first_name, role FROM users WHERE rgukt_email = ?")) {
                    ps.setString(1, email);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            userId = rs.getInt("id");
                            firstName = rs.getString("first_name");
                            role = rs.getString("role");
                        }
                    }
                }

                // If user not found — create a minimal student record
                if (userId == null) {
                    // Derive a first name if possible (take first token)
                    String derivedFirst = name == null || name.trim().isEmpty() ? "User" : name.split(" ")[0];

                    // Use a random password placeholder (so login_password won't be null)
                    String randomPass = java.util.UUID.randomUUID().toString();

                    String insertSql = "INSERT INTO users (first_name, rgukt_email, login_password, role) VALUES (?, ?, ?, ?)";
                    try (PreparedStatement ins = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                        ins.setString(1, derivedFirst);
                        ins.setString(2, email);
                        ins.setString(3, randomPass);
                        ins.setString(4, "student");
                        int affected = ins.executeUpdate();
                        if (affected == 0) {
                            throw new SQLException("Creating user failed, no rows affected.");
                        }
                        try (ResultSet gen = ins.getGeneratedKeys()) {
                            if (gen.next()) {
                                userId = gen.getInt(1);
                                firstName = derivedFirst;
                                role = "student";
                            } else {
                                throw new SQLException("Creating user failed, no ID obtained.");
                            }
                        }
                    }
                }

                // 4) Set session attributes same as LoginServlet
                session.setAttribute("userId", userId);
                session.setAttribute("userName", firstName);
                session.setAttribute("role", role);
                session.setAttribute("rgukt_email", email);

                // If leader, fetch club details and store in session (same logic as LoginServlet)
                if ("leader".equalsIgnoreCase(role)) {
                    int clubId = -1;
                    String clubName = "";
                    try (PreparedStatement ps2 = conn.prepareStatement(
                            "SELECT c.id, c.club_name FROM clubs c " +
                            "JOIN club_leaders cl ON c.id = cl.club_id " +
                            "WHERE cl.user_id = ?")) {

                        ps2.setInt(1, userId);
                        try (ResultSet rs2 = ps2.executeQuery()) {
                            if (rs2.next()) {
                                clubId = rs2.getInt("id");
                                clubName = rs2.getString("club_name");
                            }
                        }
                    }

                    session.setAttribute("clubId", clubId);
                    session.setAttribute("clubName", clubName);
                    // Redirect leaders same as LoginServlet
                    response.sendRedirect("leader_dashboard");
                    return;
                }

                // If admin
                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("admin_dashboard");
                    return;
                }

                // Default student landing page
                response.sendRedirect("homepage");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.html");
        }
    }

    private String exchangeCodeForTokens(String code) throws IOException {
        URL url = new URL("https://oauth2.googleapis.com/token");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        String params = "code=" + URLEncoder.encode(code, "UTF-8")
                + "&client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8")
                + "&client_secret=" + URLEncoder.encode(CLIENT_SECRET, "UTF-8")
                + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                + "&grant_type=authorization_code";

        try (OutputStream os = conn.getOutputStream()) {
            os.write(params.getBytes("UTF-8"));
        }

        int status = conn.getResponseCode();
        InputStream is = (status >= 200 && status < 300) ? conn.getInputStream() : conn.getErrorStream();

        try (BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"))) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) sb.append(line);
            return sb.toString();
        }
    }

    private String fetchUserInfo(String accessToken) throws IOException {
        URL url = new URL("https://www.googleapis.com/oauth2/v3/userinfo");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

        int status = conn.getResponseCode();
        InputStream is = (status >= 200 && status < 300) ? conn.getInputStream() : conn.getErrorStream();

        try (BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"))) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) sb.append(line);
            return sb.toString();
        }
    }
}
