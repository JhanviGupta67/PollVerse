<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp" />


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Active Polls - PollVerse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen">


    <!-- Main Content -->
    <main class="max-w-7xl mx-auto px-6 py-12">
        <h1 class="text-3xl font-bold text-blue-600 text-center mb-12">Active Polls</h1>

        <!-- Success/Error Messages -->
        <c:if test="${not empty message}">
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-6 text-center font-semibold">
                ${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6 text-center font-semibold">
                ${error}
            </div>
        </c:if>

<!-- Create Poll Button on the Right -->
<c:if test="${not empty username}">
    <div class="flex justify-end mb-12">
        <a href="${pageContext.request.contextPath}/poll/create"
           class="relative inline-flex items-center justify-center px-8 py-3 overflow-hidden font-bold text-gray-900 rounded-full group bg-gradient-to-r from-yellow-400 to-yellow-500 shadow-lg hover:shadow-xl transform transition-all duration-500 hover:-translate-y-1">
            
            <!-- Background glow effect -->
            <span class="absolute inset-0 w-full h-full bg-gradient-to-r from-yellow-400 to-yellow-500 opacity-75 rounded-full blur-md group-hover:opacity-100 transition duration-300"></span>
            
            <!-- Icon + Text -->
            <span class="relative flex items-center space-x-2">
                <i class="fas fa-plus-circle text-2xl"></i>
                <span class="text-lg">Create New Poll</span>
            </span>
        </a>
    </div>
</c:if>



        <!-- Poll Cards -->
        <c:choose>
            <c:when test="${not empty polls}">
                <div class="grid gap-6 sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
                    <c:forEach var="poll" items="${polls}">
                        <div class="bg-white rounded-xl shadow-lg p-6 flex flex-col justify-between transform transition hover:-translate-y-2 hover:shadow-2xl">
                            <div>
                                <div class="text-xl font-bold text-gray-800 mb-2">${poll.question}</div>
                                <div class="text-sm text-gray-500 mb-4">
                                    <span>Created by: User ${poll.userId}</span><br>
                                    <span>Date: <fmt:formatDate value="${poll.createdAt}" pattern="MMM d, yyyy hh:mm a" /></span>
                                </div>
                            </div>
                            <a href="${pageContext.request.contextPath}/poll/view/${poll.id}" class="mt-auto inline-block bg-green-500 hover:bg-green-600 text-white font-semibold py-2 px-4 rounded text-center transition">View Details & Vote</a>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p class="text-center text-gray-500 text-lg">No polls available right now. Be the first to <a href="${pageContext.request.contextPath}/poll/create" class="text-blue-600 font-semibold hover:underline">create one</a>!</p>
            </c:otherwise>
        </c:choose>
    </main>

</body>
</html>
