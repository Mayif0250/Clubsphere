package com.clubsphere.servlets;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import com.clubsphere.util.DBUtil;
import com.clubsphere.util.EmailUtil;

@WebServlet("/CreateEventServlet")
@MultipartConfig
public class CreateEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String date = request.getParameter("date");
        String venue = request.getParameter("venue");
        String createdByStr = request.getParameter("created_by");
        String clubIdStr = request.getParameter("club_id");
        String role = request.getParameter("role");  // "admin" or "leader"

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();

            int createdBy = 0;
            if (createdByStr != null && !createdByStr.isEmpty() && !"null".equals(createdByStr)) {
                createdBy = Integer.parseInt(createdByStr);
            }

            // clubId may be null
            Integer clubId = null;
            if (clubIdStr != null && !clubIdStr.isEmpty() && !"null".equals(clubIdStr)) {
                clubId = Integer.parseInt(clubIdStr);
            }

            // 👇 Determine target type
            String targetType = (role != null && role.equalsIgnoreCase("admin")) ? "all" : "club";

            // 1️⃣ Insert Event — handle both cases
            String sql;
            if (clubId != null) {
                sql = "INSERT INTO events (title, description, date, venue, target_type, created_by, club_id, status) VALUES (?, ?, ?, ?, ?, ?, ?, 'approved')";
            } else {
                sql = "INSERT INTO events (title, description, date, venue, target_type, created_by, status) VALUES (?, ?, ?, ?, ?, ?, 'approved')";
            }

            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, date);
            ps.setString(4, venue);
            ps.setString(5, targetType);
            ps.setInt(6, createdBy);

            if (clubId != null) {
                ps.setInt(7, clubId);
            }

            int rows = ps.executeUpdate();

            if (rows == 0) {
                out.print("{\"success\": false, \"message\": \"Failed to create event.\"}");
                return;
            }

            // 2️⃣ Get event id
            rs = ps.getGeneratedKeys();
            int eventId = 0;
            if (rs.next()) {
                eventId = rs.getInt(1);
            }

            // 3️⃣ Fetch target emails
            List<String> emailList = new ArrayList<>();

            if (role != null && role.equalsIgnoreCase("admin")) {
                // Admin → all users
                try (PreparedStatement psUsers = conn.prepareStatement("SELECT rgukt_email FROM users")) {
                    ResultSet rsUsers = psUsers.executeQuery();
                    while (rsUsers.next()) {
                        emailList.add(rsUsers.getString("rgukt_email"));
                    }
                }
            } else if (clubId != null) {
                // Club Leader → only members of their club
                try (PreparedStatement psMembers = conn.prepareStatement(
                        "SELECT u.rgukt_email FROM users u JOIN club_members cm ON u.id = cm.user_id WHERE cm.club_id = ?")) {
                    psMembers.setInt(1, clubId);
                    ResultSet rsMembers = psMembers.executeQuery();
                    while (rsMembers.next()) {
                        emailList.add(rsMembers.getString("rgukt_email"));
                    }
                }
            }

            // 4️⃣ Send Email Notifications
            if (!emailList.isEmpty()) {
            	 String subject = "📅 New Event: " + title;
                 String htmlBody = """
                     <html>
                     <head>
                         <style>
                             body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; color: #333; padding: 20px; }
                             .card { background: #fff; border-radius: 10px; padding: 25px; box-shadow: 0 3px 15px rgba(0,0,0,0.1); }
                             h2 { color: #0066cc; }
                             .btn { display: inline-block; margin-top: 15px; background: #0066cc; color: #fff;
                                    padding: 10px 18px; border-radius: 6px; text-decoration: none; }
                             .footer { margin-top: 30px; font-size: 12px; color: #777; text-align: center; }
                         </style>
                     </head>
                     <body>
                         <div class='card'>
                             <h2>🎉 %s</h2>
                             <p><b>📅 Date:</b> %s</p>
                             <p><b>📍 Venue:</b> %s</p>
                             <p><b>📝 Description:</b><br>%s</p>
                             <a class='btn' href='%s' target='_blank'>View Event</a>
                         </div>
                         <div class='footer'>
                             <p>— Team ClubSphere | RGUKT Ongole</p>
                         </div>
                     </body>
                     </html>
                 """.formatted(
                     title,
                     date,
                     venue,
                     description,
                     "http://localhost:8080/ClubSphere/event_template.jsp?eventId=" + eventId
                 );
                for (String email : emailList) {
                    try {
                        EmailUtil.sendEmail(email, subject, htmlBody, true);
                    } catch (Exception ex) {
                        System.out.println("⚠️ Failed to send to " + email + ": " + ex.getMessage());
                    }
                }
            }

            out.print("{\"success\": true, \"message\": \"Event created and notifications sent!\"}");

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
