package com.clubsphere.servlets;

import com.clubsphere.dao.UserDAO;
import com.clubsphere.models.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.*;
import com.google.gson.Gson;

@WebServlet("/get-all-users")
public class GetAllUsersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		System.out.println("GetAllUsersServlet Hit");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        UserDAO dao = new UserDAO();
        List<User> users = dao.getAllUsers();

        String json = new Gson().toJson(users);
        response.getWriter().write(json);
    }
}
