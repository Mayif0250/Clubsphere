package com.clubsphere.servlets;

import com.clubsphere.util.DBUtil;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import org.json.JSONObject;

@WebServlet("/update-approval")
@MultipartConfig
public class UpdateApprovalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String requestIdStr = request.getParameter("requestId");
        String actionType = request.getParameter("actionType");

        System.out.println("🟢 Received requestId=" + requestIdStr + ", actionType=" + actionType);

        if (requestIdStr == null || actionType == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Missing parameters\"}");
            return;
        }

        int requestId = Integer.parseInt(requestIdStr);

        String updateQuery = "UPDATE club_requests SET status = ? WHERE id = ?";
        String selectQuery = "SELECT user_id, club_id FROM club_requests WHERE id = ?";
        String insertMemberQuery = "INSERT INTO club_members (user_id, club_id) VALUES (?, ?)";

        try (Connection conn = DBUtil.getConnection()) {

            conn.setAutoCommit(false); // start transaction

            // 1️⃣ Update the request status
            try (PreparedStatement ps = conn.prepareStatement(updateQuery)) {
                ps.setString(1, actionType.equalsIgnoreCase("approve") ? "Approved" : "Rejected");
                ps.setInt(2, requestId);
                ps.executeUpdate();
            }

            // 2️⃣ If approved, insert into club_members
            if (actionType.equalsIgnoreCase("approve")) {
                int userId = -1, clubId = -1;

                try (PreparedStatement ps = conn.prepareStatement(selectQuery)) {
                    ps.setInt(1, requestId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            userId = rs.getInt("user_id");
                            clubId = rs.getInt("club_id");
                        }
                    }
                }

                if (userId != -1 && clubId != -1) {
                    // check if already in members table (avoid duplicates)
                    String checkQuery = "SELECT COUNT(*) FROM club_members WHERE user_id = ? AND club_id = ?";
                    try (PreparedStatement checkPs = conn.prepareStatement(checkQuery)) {
                        checkPs.setInt(1, userId);
                        checkPs.setInt(2, clubId);
                        try (ResultSet rs = checkPs.executeQuery()) {
                            rs.next();
                            if (rs.getInt(1) == 0) {
                                try (PreparedStatement ps = conn.prepareStatement(insertMemberQuery)) {
                                    ps.setInt(1, userId);
                                    ps.setInt(2, clubId);
                                    ps.executeUpdate();
                                }
                                System.out.println("✅ Added user " + userId + " to club " + clubId);
                            } else {
                                System.out.println("⚠️ User already a member of club");
                            }
                        }
                    }
                }
            }

            conn.commit();
            response.getWriter().write("{\"message\":\"Request " + actionType + " successful\"}");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Server error\"}");
        }
    }
}
