<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login - PollVerse</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .container { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); width: 100%; max-width: 400px; }
        h2 { text-align: center; color: #333; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #555; }
        input[type="text"], input[type="password"] { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px; box-sizing: border-box; }
        button { width: 100%; padding: 12px; background-color: #28a745; color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; transition: background-color 0.3s; }
        button:hover { background-color: #1e7e34; }
        .message { padding: 10px; margin-bottom: 20px; border-radius: 6px; text-align: center; }
        .error { background-color: #fdd; color: #d33; border: 1px solid #d33; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .register-link { text-align: center; margin-top: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>PollVerse Login</h2>
        
        <!-- Display Error/Success Messages -->
        <c:if test="${not empty error}">
            <p class="message error">${error}</p>
        </c:if>
        <c:if test="${not empty message}">
            <p class="message success">${message}</p>
        </c:if>

        <form:form action="${pageContext.request.contextPath}/user/login" method="POST" modelAttribute="user">
            
            <div class="form-group">
                <label for="username">Username:</label>
                <form:input path="username" id="username" required="true" />
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <form:password path="password" id="password" required="true" />
            </div>
            
            <button type="submit">Login</button>
        </form:form>
        
        <div class="register-link">
            Don't have an account? <a href="${pageContext.request.contextPath}/user/register">Register now</a>
        </div>
    </div>
</body>
</html>
