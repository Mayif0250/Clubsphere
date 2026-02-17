<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Map" %>
<%
	@SuppressWarnings("unchecked")
    List<Map<String, String>> clubs = (List<Map<String, String>>) request.getAttribute("clubs");
    String rgukt_email = (String) session.getAttribute("rgukt_email");
%>

<!DOCTYPE html>
<html>
<head>
    <title>All Clubs | ClubSphere</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f3f5f7; }
        .container { width: 80%; margin: 50px auto; }
        .club-card {
            background: white; padding: 20px; margin-bottom: 15px;
            border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        button {
            background-color: #0066cc; color: white; border: none;
            padding: 10px 15px; border-radius: 5px; cursor: pointer;
        }
        button:hover { background-color: #004c99; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Available Clubs</h2>
        <%
            if (clubs != null && !clubs.isEmpty()) {
                for (Map<String, String> club : clubs) {
        %>
            <div class="club-card">
                <h3><%= club.get("name") %></h3>
                <p><%= club.get("description") %></p>
                <form action="join-club" method="post">
                    <input type="hidden" name="club_id" value="<%= club.get("id") %>">
                    <input type="hidden" name="rgukt_email" value="<%= rgukt_email %>">
                    <button type="submit">Join Club</button>
                </form>
            </div>
        <%
                }
            } else {
        %>
            <p>No clubs found.</p>
        <%
            }
        %>
    </div>
</body>
</html>
