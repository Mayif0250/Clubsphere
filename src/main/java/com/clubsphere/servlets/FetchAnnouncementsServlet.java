package com.clubsphere.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.sql.*;
import org.json.JSONArray;
import org.json.JSONObject;
import com.clubsphere.util.DBUtil;

@WebServlet("/FetchAnnouncementsServlet")
public class FetchAnnouncementsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONArray announcementsArray = new JSONArray();

        try (Connection conn = DBUtil.getConnection()) {
            String query = "SELECT id, title, message, created_at FROM announcements ORDER BY created_at DESC";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                JSONObject ann = new JSONObject();
                ann.put("id", rs.getInt("id"));
                ann.put("title", rs.getString("title"));
                ann.put("message", rs.getString("message"));
                ann.put("created_at", rs.getTimestamp("created_at").toString());
                announcementsArray.put(ann);
            }

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("announcements", announcementsArray);

            response.getWriter().write(jsonResponse.toString());

        } catch (Exception e) {
            e.printStackTrace();
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            response.setStatus(500);
            response.getWriter().write(error.toString());
        }
    }
}
