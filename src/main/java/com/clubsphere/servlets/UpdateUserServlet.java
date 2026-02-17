package com.clubsphere.servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import com.google.gson.*;
import com.clubsphere.dao.UserDAO;
import com.clubsphere.models.User;

@WebServlet("/update-user")
public class UpdateUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Parse incoming JSON
            BufferedReader reader = request.getReader();
            Gson gson = new Gson();
            User user = gson.fromJson(reader, User.class);

            UserDAO dao = new UserDAO();
            boolean success = dao.updateUser(user);

            JsonObject json = new JsonObject();
            if (success) {
                json.addProperty("status", "success");
            } else {
                json.addProperty("status", "error");
            }

            response.getWriter().write(json.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"status\":\"error\"}");
        }
    }
}
