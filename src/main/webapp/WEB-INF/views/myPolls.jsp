<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Polls - PollVerse</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen p-10">

<div class="max-w-5xl mx-auto">

    <h1 class="text-3xl font-bold text-blue-600 mb-6 border-b-2 pb-3">My Polls</h1>

    <!-- If no polls exist -->
    <c:if test="${empty myPolls}">
        <div class="text-center bg-yellow-50 border border-yellow-300 text-yellow-700 p-6 rounded mb-6">
            You haven't created any polls yet! 
            <a href="${pageContext.request.contextPath}/poll/create" class="underline font-semibold">Create one now</a>.
        </div>
    </c:if>

    <!-- Loop through user's polls -->
    <c:forEach var="poll" items="${myPolls}">
        <div class="bg-white rounded-xl shadow-md p-6 mb-6">
            <div class="flex justify-between items-start">
                <!-- Poll Details -->
                <div>
                    <h2 class="text-xl font-bold text-gray-800 mb-2">${poll.question}</h2>
                    <div class="text-gray-500 text-sm mb-2">
                        Created: <fmt:formatDate value="${poll.createdAt}" pattern="MMM d, yyyy" />
                    </div>
                </div>

                <!-- Actions -->
                <div class="flex space-x-3">
                    <a href="${pageContext.request.contextPath}/poll/mypolls/view/${poll.id}" 
                       class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded transition-colors">
                        View
                    </a>
                    <a href="${pageContext.request.contextPath}/poll/delete/${poll.id}" 
                       onclick="return confirm('Are you sure you want to delete this poll? This action cannot be undone.');"
                       class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded transition-colors">
                        Delete
                    </a>
                </div>
            </div>

            <!-- Show poll options -->
            <div class="mt-4 grid grid-cols-1 sm:grid-cols-2 gap-2">
                <c:if test="${not empty poll.option1}">
                    <div class="bg-gray-100 rounded-md p-2 text-gray-700">${poll.option1}</div>
                </c:if>
                <c:if test="${not empty poll.option2}">
                    <div class="bg-gray-100 rounded-md p-2 text-gray-700">${poll.option2}</div>
                </c:if>
                <c:if test="${not empty poll.option3}">
                    <div class="bg-gray-100 rounded-md p-2 text-gray-700">${poll.option3}</div>
                </c:if>
                <c:if test="${not empty poll.option4}">
                    <div class="bg-gray-100 rounded-md p-2 text-gray-700">${poll.option4}</div>
                </c:if>
            </div>
        </div>
    </c:forEach>
</div>

</body>
</html>
