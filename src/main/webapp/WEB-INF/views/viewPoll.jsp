<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>${poll.question} - PollVerse</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex justify-center items-start pt-10">

<div class="bg-white rounded-xl shadow-lg w-full max-w-3xl p-8">

    <!-- Messages -->
    <c:if test="${not empty error}">
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6 text-center font-semibold">
            ${error}
        </div>
    </c:if>

    <c:if test="${not empty message}">
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-6 text-center font-semibold">
            ${message}
        </div>
    </c:if>

    <!-- Poll Question -->
    <h1 class="text-2xl font-bold text-blue-600 border-b-2 border-gray-200 pb-3 mb-6">${poll.question}</h1>

    <!-- Meta Info -->
    <div class="text-gray-500 text-sm mb-6">
        <span>Created by User ID: ${poll.userId}</span>
        <span class="ml-6">Date: <fmt:formatDate value="${poll.createdAt}" pattern="MMM d, yyyy" /></span>
    </div>

    <!-- Scenario 1: Not Logged In -->
    <c:if test="${!isLoggedIn}">
        <div class="border-2 border-yellow-300 bg-yellow-50 text-yellow-800 p-5 rounded mb-6 text-center font-semibold">
            You must <a href="${pageContext.request.contextPath}/user/login" class="underline">log in</a> to vote.
        </div>
    </c:if>

    <!-- Scenario 2: Logged in & Not Voted -->
    <c:if test="${isLoggedIn && !hasVoted}">
        <div class="border border-gray-300 p-6 rounded-lg mb-6">
            <h3 class="text-lg font-semibold mb-4 text-gray-700">Cast Your Vote</h3>
            <form action="${pageContext.request.contextPath}/poll/vote/${poll.id}" method="POST">
                <c:forEach begin="1" end="4" var="optionNumber">
                    <c:set var="optionPropertyName" value="option${optionNumber}" />
                    <c:set var="optionText" value="${poll[optionPropertyName]}" />
                    <c:if test="${not empty optionText}">
                        <div class="flex items-center mb-4">
                            <input type="radio" id="option${optionNumber}" name="selectedOption" value="${optionNumber}" required class="w-5 h-5 text-blue-600">
                            <label for="option${optionNumber}" class="ml-3 text-gray-700 text-lg cursor-pointer">${optionText}</label>
                        </div>
                    </c:if>
                </c:forEach>
                <button type="submit" class="w-full bg-blue-600 text-white font-bold py-3 rounded hover:bg-blue-700 transition-colors">
                    Submit Vote
                </button>
            </form>
        </div>
    </c:if>

    <!-- Scenario 3: Logged in & Has Voted -->
    <c:if test="${isLoggedIn && hasVoted}">
        <div class="bg-green-50 border border-green-400 text-green-700 px-4 py-3 rounded mb-6 text-center font-semibold">
            Thank you! Your vote has been recorded.
        </div>
    </c:if>

    <!-- Results Section -->
    <c:if test="${hasVoted || !isLoggedIn}">
        <div class="mt-6">
            <h2 class="text-xl font-bold text-gray-700 mb-4">Poll Results</h2>

            <c:forEach begin="1" end="4" var="optionNumber">
                <c:set var="optionPropertyName" value="option${optionNumber}" />
                <c:set var="optionText" value="${poll[optionPropertyName]}" />
                <c:if test="${not empty optionText}">
                    <c:set var="voteCount" value="${results[optionNumber]}" />
                    <c:if test="${empty voteCount}"><c:set var="voteCount" value="0" /></c:if>
                    
                    <c:set var="percentage" value="0" />
                    <c:if test="${totalVotes > 0}">
                        <c:set var="percentage" value="${(voteCount * 100) / totalVotes}" />
                    </c:if>

                    <div class="mb-4">
                        <div class="text-gray-700 font-semibold mb-1">${optionText} (${voteCount} votes)</div>
                        <div class="w-full bg-gray-200 h-6 rounded-lg overflow-hidden">
                            <div class="bg-blue-600 h-6 text-white text-right pr-2 leading-6 transition-all"
                                 style="width: <fmt:formatNumber value='${percentage}' type='number' maxFractionDigits='1'/>%;">
                                <c:if test="${percentage > 5}">
                                    <fmt:formatNumber value="${percentage}" type="number" maxFractionDigits="1"/>%
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>

            <div class="text-center font-bold text-gray-600 mt-4">
                Total Votes Cast: ${totalVotes}
            </div>
        </div>
    </c:if>

    <!-- Actions -->
    <div class="flex justify-between mt-8">
        <a href="${pageContext.request.contextPath}/poll/list" class="bg-gray-500 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded transition-colors">
            ← Back to All Polls
        </a>

        <c:if test="${isLoggedIn && sessionScope.userId == poll.userId}">
            <a href="${pageContext.request.contextPath}/poll/delete/${poll.id}" 
               onclick="return confirm('Are you sure you want to delete this poll? This action cannot be undone.');"
               class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded transition-colors">
               Delete Poll
            </a>
        </c:if>
    </div>

</div>

</body>
</html>
