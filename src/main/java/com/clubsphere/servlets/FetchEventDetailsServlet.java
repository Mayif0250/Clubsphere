package com.clubsphere.servlets;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import org.json.*;

import com.clubsphere.util.DBUtil;

@WebServlet("/FetchEventDetailsServlet")
public class FetchEventDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        int eventId = Integer.parseInt(request.getParameter("eventId"));

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
        	conn = DBUtil.getConnection();

            String sql = "SELECT * FROM events WHERE id=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, eventId);
            rs = ps.executeQuery();

            if (rs.next()) {
                JSONObject event = new JSONObject();
                event.put("id", rs.getInt("id"));
                event.put("title", rs.getString("title"));
                event.put("description", rs.getString("description"));
                event.put("date", rs.getString("date"));
                event.put("venue", rs.getString("venue"));
                event.put("created_by", rs.getInt("created_by"));
                event.put("club_id", rs.getInt("club_id"));
                event.put("target_type", rs.getString("target_type"));
                event.put("created_at", rs.getString("created_at"));
                event.put("status", rs.getString("status"));

                out.print(event.toString());
            } else {
                out.print("{\"error\": \"Event not found\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"error\": \"" + e.getMessage() + "\"}");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
