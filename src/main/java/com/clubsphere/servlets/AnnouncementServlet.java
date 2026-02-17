package com.clubsphere.servlets;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import org.json.JSONObject;
import com.clubsphere.util.DBUtil;

@WebServlet("/AnnouncementServlet")
public class AnnouncementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String SENDER_EMAIL = "ro.clubsphere@gmail.com";
    private static final String SENDER_PASSWORD = "xmas ljco rvxa emcd"; // app password

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonResponse = new JSONObject();

        try (Connection conn = DBUtil.getConnection()) {
            // --- Parameters from frontend
            String title = request.getParameter("title");
            String message = request.getParameter("message");
            String targetType = request.getParameter("target_type");
            String targetClubId = request.getParameter("target_club_id");

            // --- Session info
            HttpSession session = request.getSession(false);
            String role = (String) session.getAttribute("role");
            Integer userId = (Integer) session.getAttribute("user_id");

            System.out.println("📢 AnnouncementServlet hit!");
            System.out.println("User Role: " + role);
            System.out.println("title=" + title + ", target_type=" + targetType + ", club_id=" + targetClubId);

            if (title == null || message == null || targetType == null) {
                response.setStatus(400);
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Missing parameters");
                response.getWriter().write(jsonResponse.toString());
                return;
            }

            // --- Insert announcement
            String insertSQL = "INSERT INTO announcements (title, message, target_type, target_club_id, created_by) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertSQL)) {
                ps.setString(1, title);
                ps.setString(2, message);
                ps.setString(3, targetType);

                if (targetClubId != null && !targetClubId.isEmpty()) {
                    ps.setInt(4, Integer.parseInt(targetClubId));
                } else {
                    ps.setNull(4, Types.INTEGER);
                }

                ps.setInt(5, userId != null ? userId : 1); // fallback to admin if null
                ps.executeUpdate();
            }

            // --- Send announcement emails
            sendAnnouncementEmails(conn, role, title, message, targetType, targetClubId);

            jsonResponse.put("status", "success");
            jsonResponse.put("message", "Announcement added and emails sent!");
            response.getWriter().write(jsonResponse.toString());

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", e.getMessage());
            response.setStatus(500);
            response.getWriter().write(jsonResponse.toString());
        }
    }

    /**
     * Sends announcement emails based on the sender’s role and target type.
     */
    private void sendAnnouncementEmails(Connection conn, String role, String title, String message, String targetType, String clubIdStr) {
        List<String> recipients = new ArrayList<>();
        String query = "";

        try {
            if ("admin".equalsIgnoreCase(role)) {
                if ("all".equalsIgnoreCase(targetType)) {
                    query = "SELECT rgukt_email FROM users";
                } else if ("leaders".equalsIgnoreCase(targetType)) {
                    query = "SELECT rgukt_email FROM users WHERE role='leader'";
                }
            } else if ("leader".equalsIgnoreCase(role) && "specific".equalsIgnoreCase(targetType)) {
                if (clubIdStr != null && !clubIdStr.isEmpty()) {
                    int clubId = Integer.parseInt(clubIdStr);
                    query = """
                        SELECT u.rgukt_email
                        FROM users u
                        JOIN club_members cm ON u.id = cm.user_id
                        WHERE cm.club_id = ?
                    """;
                    try (PreparedStatement ps = conn.prepareStatement(query)) {
                        ps.setInt(1, clubId);
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                            recipients.add(rs.getString("rgukt_email"));
                        }
                    }
                }
            }

            if (!recipients.isEmpty()) {
                System.out.println("📨 Sending to " + recipients.size() + " recipients...");
                sendEmailNotifications(recipients, title, message);
            } else {
                System.out.println("⚠️ No recipients found for this announcement.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("❌ Error sending announcement emails: " + e.getMessage());
        }
    }

    /**
     * Utility: sends emails to all recipients.
     */
    private void sendEmailNotifications(List<String> recipients, String title, String message) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
                }
            });

            for (String recipient : recipients) {
                Message email = new MimeMessage(session);
                email.setFrom(new InternetAddress(SENDER_EMAIL));
                email.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
                email.setSubject("📢 New Announcement: " + title);
                email.setText(message);

                Transport.send(email);
                System.out.println("✅ Email sent to: " + recipient);
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("❌ Error sending email notifications: " + e.getMessage());
        }
    }
}
