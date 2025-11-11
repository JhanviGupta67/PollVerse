<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>All Polls - PollVerse</title>
    <style>
        body { font-family: 'Arial', sans-serif; background-color: #f8f9fa; color: #333; margin: 0; padding: 0; }
        .header { background-color: #007bff; color: white; padding: 15px 50px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .header a { color: white; text-decoration: none; margin-left: 20px; font-weight: 500; transition: opacity 0.3s; }
        .header a:hover { opacity: 0.8; }
        .welcome-message { font-size: 1.1em; }
        
        .main-content { padding: 40px 50px; max-width: 1000px; margin: 0 auto; }
        h1 { color: #007bff; border-bottom: 2px solid #007bff; padding-bottom: 10px; margin-bottom: 30px; }
        
        .poll-card { background: white; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 20px; padding: 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); transition: transform 0.2s; }
        .poll-card:hover { transform: translateY(-2px); box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .poll-question { font-size: 1.4em; font-weight: bold; margin-bottom: 10px; color: #343a40; }
        .poll-meta { font-size: 0.9em; color: #6c757d; margin-bottom: 15px; }
        .poll-meta span { margin-right: 15px; }
        
        .view-link { display: inline-block; padding: 8px 15px; background-color: #28a745; color: white; text-decoration: none; border-radius: 5px; transition: background-color 0.3s; }
        .view-link:hover { background-color: #218838; }

        .message { padding: 15px; margin-bottom: 20px; border-radius: 8px; text-align: center; font-weight: bold; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #fdd; color: #d33; border: 1px solid #d33; }
        
        .create-btn-container { text-align: right; margin-bottom: 20px; }
        .create-btn { padding: 10px 20px; background-color: #ffc107; color: #333; text-decoration: none; border-radius: 5px; font-weight: bold; transition: background-color 0.3s; }
        .create-btn:hover { background-color: #e0a800; }
    </style>
</head>
<body>
    <div class="header">
        <div class="welcome-message">
            <c:choose>
                <c:when test="${not empty username}">
                    Welcome, <strong>${username}</strong>!
                    <a href="${pageContext.request.contextPath}/user/logout">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/login">Login</a>
                    <a href="${pageContext.request.contextPath}/user/register">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <div class="main-content">
        <h1>Active Polls</h1>

        <c:if test="${not empty message}">
            <p class="message success">${message}</p>
        </c:if>
        <c:if test="${not empty error}">
            <p class="message error">${error}</p>
        </c:if>
        
        <c:if test="${not empty username}">
            <div class="create-btn-container">
                <a href="${pageContext.request.contextPath}/poll/create" class="create-btn">Create New Poll</a>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty polls}">
                <c:forEach var="poll" items="${polls}">
                    <div class="poll-card">
                        <div class="poll-question">${poll.question}</div>
                        <div class="poll-meta">
                            <span>Created by User ID: ${poll.userId}</span>
                            <span>Date: <fmt:formatDate value="${poll.createdAt}" pattern="MMM d, yyyy" /></span>
                        </div>
                        <a href="${pageContext.request.contextPath}/poll/view/${poll.id}" class="view-link">View Details & Vote</a>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>No polls available right now. Be the first to <a href="${pageContext.request.contextPath}/poll/create">create one</a>!</p>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
