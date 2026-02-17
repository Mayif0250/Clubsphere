package com.clubsphere.servlets;

import com.clubsphere.dao.ClubDAO;
import com.google.gson.Gson;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.*;

@WebServlet("/get-clubs")
public class GetClubsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ClubDAO dao = new ClubDAO();
        List<Map<String, Object>> clubs = dao.getAllClubs();

        String json = new Gson().toJson(clubs);
        response.getWriter().write(json);
    }
}
