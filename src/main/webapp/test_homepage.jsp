<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String Student_ID = (String) session.getAttribute("Student_ID");
    if (Student_ID == null) {
        response.sendRedirect("test_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Test Homepage</title>
</head>
<body>
    <h2>Welcome, <%= Student_ID %>!</h2>
    <p>This is a test homepage after successful login.</p>
    <a href="TestLogoutServlet">Logout</a>
</body>
</html>