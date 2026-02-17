package com.clubsphere.servlets;

import com.clubsphere.dao.UserDAO;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.*;

@WebServlet("/get-club-leaders")
public class GetClubLeadersServlet extends HttpServlet {
 static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        System.out.println("✅ GetClubLeadersServlet hit!");

        UserDAO dao = new UserDAO();
        List<Map<String, String>> leaders = dao.getClubLeaders();

        JSONArray jsonArray = new JSONArray();
        for (Map<String, String> leader : leaders) {
            JSONObject obj = new JSONObject(leader);
            jsonArray.put(obj);
        }

        System.out.println("Leaders found: " + leaders.size());
        response.getWriter().write(jsonArray.toString());
    }
}
