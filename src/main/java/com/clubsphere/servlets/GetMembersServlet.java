package com.clubsphere.servlets;

import com.clubsphere.util.DBUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/get-members")
public class GetMembersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("✅ GetMembersServlet hit");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONArray membersArray = new JSONArray();

        Integer clubId = null;
        String clubIdParam = request.getParameter("club_id");

        if (clubIdParam != null && !clubIdParam.isEmpty()) {
            clubId = Integer.parseInt(clubIdParam);
        } else {
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("clubId") != null) {
                clubId = (Integer) session.getAttribute("clubId");
            }
        }

        try (PrintWriter out = response.getWriter()) {

            if (clubId == null) {
                out.print("{\"error\":\"Missing club_id parameter or session attribute\"}");
                return;
            }

            System.out.println("✅ Fetching members for club_id = " + clubId);

            String query = """
                SELECT cm.id AS member_id, u.id AS user_id, u.first_name, u.last_name, 
                       u.rgukt_email, u.branch, u.section, u.academic_year, u.role, cm.joined_at
                FROM club_members cm
                JOIN users u ON cm.user_id = u.id
                WHERE cm.club_id = ?
                ORDER BY cm.joined_at ASC
            """;

            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement ps = conn.prepareStatement(query)) {

                ps.setInt(1, clubId);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    JSONObject member = new JSONObject();

                    String firstName = rs.getString("first_name");
                    String lastName = rs.getString("last_name");
                    String email = rs.getString("rgukt_email");

                    member.put("memberId", rs.getInt("member_id"));
                    member.put("name", (firstName != null ? firstName : "") + " " + (lastName != null ? lastName : ""));
                    member.put("email", email != null ? email : "N/A");
                    member.put("branch", rs.getString("branch"));
                    member.put("section", rs.getString("section"));
                    member.put("academic_year", rs.getString("academic_year"));
                    member.put("role", rs.getString("role"));

                    Timestamp joinedAt = rs.getTimestamp("joined_at");
                    member.put("joinedDate", (joinedAt != null)
                            ? joinedAt.toLocalDateTime().toLocalDate().toString()
                            : "");

                    // Safely compute initials
                    String initials = "U";
                    if (firstName != null && !firstName.isEmpty()) {
                        initials = firstName.substring(0, 1).toUpperCase();
                    }
                    member.put("avatar", initials);

                    membersArray.put(member);
                }

                out.print(membersArray.toString());
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().print("{\"error\":\"Database error occurred: " + e.getMessage() + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("{\"error\":\"Unexpected error: " + e.getMessage() + "\"}");
        }
    }
}
