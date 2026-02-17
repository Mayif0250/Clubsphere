package com.clubsphere.servlets;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import org.json.*;

import com.clubsphere.util.DBUtil;

@WebServlet("/FetchEventsServlet")
public class FetchEventsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
        	conn = DBUtil.getConnection();

            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM events WHERE status='approved' ORDER BY created_at DESC");

            JSONArray eventsArray = new JSONArray();

            while (rs.next()) {
                JSONObject event = new JSONObject();
                event.put("id", rs.getInt("id"));
                event.put("title", rs.getString("title"));
                event.put("description", rs.getString("description"));
                event.put("date", rs.getString("date"));
                event.put("venue", rs.getString("venue"));
                event.put("target_type", rs.getString("target_type"));
                eventsArray.put(event);
            }

            JSONObject result = new JSONObject();
            result.put("events", eventsArray);
            out.print(result.toString());

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"error\": \"" + e.getMessage() + "\"}");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
