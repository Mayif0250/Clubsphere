package com.clubsphere.servlets;

import com.clubsphere.dao.UserDAO;
import com.clubsphere.models.User;
import com.google.gson.Gson;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.Map;

@WebServlet("/add-user")
public class AddUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            // Read JSON body
            BufferedReader reader = request.getReader();
            User newUser = gson.fromJson(reader, User.class);

            boolean success = userDAO.addUser(newUser);

            if (success) {
                out.print(gson.toJson(Map.of("status", "success", "user", newUser)));
            } else {
                out.print(gson.toJson(Map.of("status", "error", "message", "Failed to add user")));
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print(gson.toJson(Map.of("status", "error", "message", "Exception: " + e.getMessage())));
        }
    }
}
