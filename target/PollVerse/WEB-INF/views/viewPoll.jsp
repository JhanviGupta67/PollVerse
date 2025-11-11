<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>${poll.question} - PollVerse</title>
    <style>
        body { font-family: 'Arial', sans-serif; background-color: #f4f4f9; color: #333; margin: 0; padding: 20px; display: flex; justify-content: center; }
        .container { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1); width: 100%; max-width: 800px; }
        h1 { color: #007bff; border-bottom: 2px solid #f0f0f0; padding-bottom: 15px; margin-bottom: 30px; }
        
        /* Messages */
        .message { padding: 15px; margin-bottom: 25px; border-radius: 8px; text-align: center; font-weight: bold; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #fdd; color: #d33; border: 1px solid #d33; }

        /* Meta Data */
        .poll-meta { font-size: 0.9em; color: #6c757d; margin-bottom: 20px; }
        .poll-meta span { margin-right: 20px; }

        /* Voting Form */
        .voting-section { border: 1px solid #ccc; padding: 25px; border-radius: 8px; margin-bottom: 30px; }
        .voting-section h3 { margin-top: 0; color: #343a40; }
        .option-item { margin-bottom: 15px; display: flex; align-items: center; }
        .option-item label { font-size: 1.1em; margin-left: 10px; cursor: pointer; }
        input[type="radio"] { transform: scale(1.3); }

        /* Results */
        .results-section { margin-top: 30px; }
        .result-bar-container { background-color: #eee; border-radius: 4px; margin-bottom: 10px; height: 30px; display: flex; overflow: hidden; }
        .result-bar { height: 100%; background-color: #007bff; text-align: right; color: white; line-height: 30px; padding-right: 10px; box-sizing: border-box; transition: width 0.5s ease; }
        .result-label { font-weight: bold; margin-bottom: 5px; color: #343a40; }
        
        .total-votes { text-align: center; margin-top: 20px; font-weight: bold; color: #555; }

        /* Actions */
        .actions-group { display: flex; justify-content: space-between; margin-top: 25px; }
        .btn { padding: 10px 20px; border: none; border-radius: 6px; cursor: pointer; text-decoration: none; font-weight: bold; transition: background-color 0.3s; }
        .btn-submit { background-color: #28a745; color: white; }
        .btn-submit:hover { background-color: #218838; }
        .btn-delete { background-color: #dc3545; color: white; }
        .btn-delete:hover { background-color: #c82333; }
        .btn-back { background-color: #6c757d; color: white; }
        .btn-back:hover { background-color: #5a6268; }
        
        .login-prompt { padding: 20px; border: 1px dashed #ffc107; background-color: #fffbe6; text-align: center; border-radius: 8px; font-weight: bold; margin-bottom: 30px; }
        .login-prompt a { color: #ffc107; text-decoration: none; }
    </style>
</head>
<body>
    <div class="container">
        <c:if test="${not empty error}">
            <p class="message error">${error}</p>
        </c:if>
        <c:if test="${not empty message}">
            <p class="message success">${message}</p>
        </c:if>

        <h1>${poll.question}</h1>
        
        <div class="poll-meta">
            <span>Created by User ID: ${poll.userId}</span>
            <span>Date: <fmt:formatDate value="${poll.createdAt}" pattern="MMM d, yyyy" /></span>
        </div>

        <c:choose>
            <%-- SCENARIO 1: User is NOT Logged In --%>
            <c:when test="${!isLoggedIn}">
                <div class="login-prompt">
                    You must <a href="${pageContext.request.contextPath}/user/login">log in</a> to cast your vote.
                </div>
            </c:when>

            <%-- SCENARIO 2: User IS Logged In AND Has NOT Voted --%>
            <c:when test="${isLoggedIn && !hasVoted}">
                <div class="voting-section">
                    <h3>Cast Your Vote</h3>
                    <form action="${pageContext.request.contextPath}/poll/vote/${poll.id}" method="POST">
                        
                        <%-- FIX: Replaced EL list literal with c:forEach loop for robustness --%>
                        <c:forEach begin="1" end="4" var="optionNumber">
                            <c:set var="optionPropertyName" value="option${optionNumber}"/>
                            <c:set var="optionText" value="${poll[optionPropertyName]}"/>
                            
                            <c:if test="${not empty optionText}">
                                <div class="option-item">
                                    <input type="radio" id="option${optionNumber}" name="selectedOption" 
                                           value="${optionNumber}" required>
                                    <label for="option${optionNumber}">${optionText}</label>
                                </div>
                            </c:if>
                        </c:forEach>
                        
                        <button type="submit" class="btn btn-submit">Submit Vote</button>
                    </form>
                </div>
            </c:when>
            
            <%-- SCENARIO 3: User IS Logged In AND HAS Voted (Show Results) --%>
            <c:when test="${isLoggedIn && hasVoted}">
                <div class="message success">Thank you! Your vote has been recorded.</div>
            </c:when>
            
        </c:choose>

        <%-- SCENARIO 4: Display Results (Shown if voted, or if poll owner, or always if you want non-voters to see results) --%>
        <c:if test="${hasVoted || !isLoggedIn}">
            <div class="results-section">
                <h2>Poll Results</h2>
                
                <%-- FIX: Replaced EL list literal with c:forEach loop for robustness --%>
                <c:forEach begin="1" end="4" var="optionNumber">
                    <c:set var="optionPropertyName" value="option${optionNumber}"/>
                    <c:set var="optionText" value="${poll[optionPropertyName]}"/>
                    
                    <c:if test="${not empty optionText}">
                        <c:set var="voteCount" value="${results[optionNumber]}"/>
                        <c:if test="${empty voteCount}"><c:set var="voteCount" value="0"/></c:if>
                        
                        <div class="result-label">${optionText} (${voteCount} votes)</div>
                        
                        <c:set var="percentage" value="${(voteCount / totalVotes) * 100}"/>
                        <c:if test="${totalVotes == 0}"><c:set var="percentage" value="0"/></c:if>

                        <div class="result-bar-container">
                            <div class="result-bar" style="width: <fmt:formatNumber value="${percentage}" maxFractionDigits="0"/>%;">
                                <c:if test="${percentage > 5}"><fmt:formatNumber value="${percentage}" maxFractionDigits="1"/>%</c:if>
                            </div>
                            <c:if test="${percentage <= 5}">
                                <span style="margin-left: 5px; line-height: 30px;"><fmt:formatNumber value="${percentage}" maxFractionDigits="1"/>%</span>
                            </c:if>
                        </div>
                    </c:if>
                </c:forEach>
                
                <div class="total-votes">Total Votes Cast: ${totalVotes}</div>
            </div>
        </c:if>
        
        <div class="actions-group">
            <a href="${pageContext.request.contextPath}/poll/list" class="btn btn-back">← Back to All Polls</a>
            
            <%-- Display Delete Button only if the logged-in user is the poll owner --%>
            <c:if test="${isLoggedIn && sessionScope.userId == poll.userId}">
                <a href="${pageContext.request.contextPath}/poll/delete/${poll.id}" 
                   class="btn btn-delete" 
                   onclick="return confirm('Are you sure you want to delete this poll? This action cannot be undone.');">
                   Delete Poll
                </a>
            </c:if>
        </div>
    </div>
</body>
</html>