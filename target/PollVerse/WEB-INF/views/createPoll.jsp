<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Create New Poll - PollVerse</title>
    <style>
        body { font-family: 'Arial', sans-serif; background-color: #f4f4f9; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
        .container { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1); width: 100%; max-width: 600px; }
        h2 { text-align: center; color: #007bff; margin-bottom: 30px; border-bottom: 2px solid #f0f0f0; padding-bottom: 10px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #555; }
        input[type="text"] { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px; box-sizing: border-box; font-size: 16px; }
        textarea { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px; box-sizing: border-box; font-size: 16px; resize: vertical; }
        
        .option-group { margin-top: 15px; border: 1px dashed #ccc; padding: 15px; border-radius: 8px; }
        .option-group label { font-weight: normal; color: #333; }

        button { width: 100%; padding: 15px; background-color: #ffc107; color: #333; border: none; border-radius: 6px; cursor: pointer; font-size: 18px; font-weight: bold; transition: background-color 0.3s; margin-top: 20px; }
        button:hover { background-color: #e0a800; }

        .message { padding: 15px; margin-bottom: 20px; border-radius: 8px; text-align: center; font-weight: bold; }
        .error { background-color: #fdd; color: #d33; border: 1px solid #d33; }
        
        .back-link { display: block; text-align: center; margin-top: 25px; color: #007bff; text-decoration: none; font-weight: 500; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Create a New Poll</h2>
        
        <!-- Display Error Message -->
        <c:if test="${not empty error}">
            <p class="message error">${error}</p>
        </c:if>

        <form:form action="${pageContext.request.contextPath}/poll/create" method="POST" modelAttribute="poll">
            
            <div class="form-group">
                <label for="question">Poll Question:</label>
                <form:textarea path="question" id="question" rows="3" placeholder="What should people vote on?" required="true" />
            </div>
            
            <div class="option-group">
                <p style="font-weight: bold;">Options (Provide at least two):</p>
                <div class="form-group">
                    <label for="option1">Option 1:</label>
                    <form:input path="option1" id="option1" required="true" />
                </div>
                
                <div class="form-group">
                    <label for="option2">Option 2:</label>
                    <form:input path="option2" id="option2" required="true" />
                </div>

                <div class="form-group">
                    <label for="option3">Option 3 (Optional):</label>
                    <form:input path="option3" id="option3" />
                </div>

                <div class="form-group">
                    <label for="option4">Option 4 (Optional):</label>
                    <form:input path="option4" id="option4" />
                </div>
            </div>
            
            <button type="submit">Publish Poll</button>
        </form:form>
        
        <a href="${pageContext.request.contextPath}/poll/list" class="back-link">← Back to All Polls</a>
    </div>
</body>
</html>
