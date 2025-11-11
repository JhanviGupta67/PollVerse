<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PollVerse Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#007bff',
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gradient-to-br from-blue-50 via-white to-indigo-50 min-h-screen">
    <!-- Include reusable header -->
    <jsp:include page="header.jsp" />

    <main class="container mx-auto px-4 py-8 lg:py-12 max-w-7xl">
        <!-- Hero Section -->
        <section class="text-center mb-12 lg:mb-16">
            <h1 class="text-4xl lg:text-5xl font-bold text-gray-900 mb-4">
                Welcome to PollVerse Dashboard
            </h1>
            <p class="text-xl text-gray-600 max-w-2xl mx-auto">
                Create, manage, and analyze your polls with ease. Dive into engaging community interactions and insightful results.
            </p>
            <div class="mt-8 flex justify-center space-x-4">
                <a href="${pageContext.request.contextPath}/poll/create" class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-lg font-semibold transition duration-300 inline-flex items-center">
                    <i class="fas fa-plus mr-2"></i>Create New Poll
                </a>
               
            </div>
        </section>

        <!-- Why PollVerse? Benefits Grid -->
        <section class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
            <div class="bg-white rounded-xl p-6 shadow-lg border border-gray-100 text-center">
                <i class="fas fa-lightbulb text-4xl text-yellow-500 mb-4"></i>
                <h3 class="text-xl font-bold text-gray-900 mb-2">Easy to Use</h3>
                <p class="text-gray-600">Create polls in minutes with our simple interface. No tech skills required.</p>
            </div>

            <div class="bg-white rounded-xl p-6 shadow-lg border border-gray-100 text-center">
                <i class="fas fa-users text-4xl text-green-500 mb-4"></i>
                <h3 class="text-xl font-bold text-gray-900 mb-2">Engage Community</h3>
                <p class="text-gray-600">Share polls with friends and see real-time responses from your audience.</p>
            </div>

            <div class="bg-white rounded-xl p-6 shadow-lg border border-gray-100 text-center">
                <i class="fas fa-chart-bar text-4xl text-blue-500 mb-4"></i>
                <h3 class="text-xl font-bold text-gray-900 mb-2">Get Insights</h3>
                <p class="text-gray-600">View results and trends to make informed decisions based on feedback.</p>
            </div>
        </section>

        <!-- Unique Action Cards Grid -->
        <section class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-12">
            <a href="${pageContext.request.contextPath}/poll/list" class="group card bg-gradient-to-br from-green-400 to-emerald-500 text-white rounded-xl p-6 shadow-lg hover:shadow-xl transform hover:-translate-y-2 transition duration-300 flex flex-col items-center text-center relative overflow-hidden">
                <div class="absolute inset-0 bg-white/10 blur opacity-0 group-hover:opacity-100 transition duration-300"></div>
                <i class="fas fa-chart-line text-4xl mb-4 relative z-10"></i>
                <h2 class="text-xl font-bold mb-2 relative z-10">Explore Active Polls</h2>
                <p class="text-sm mb-4 relative z-10">Browse and participate in ongoing polls</p>
                <span class="text-xs opacity-90 relative z-10"><c:out value="${empty activePollsCount ? '0' : activePollsCount}" /> Live Now</span>
            </a>

            <a href="${pageContext.request.contextPath}/poll/mypolls" class="group card bg-gradient-to-br from-orange-400 to-orange-500 text-white rounded-xl p-6 shadow-lg hover:shadow-xl transform hover:-translate-y-2 transition duration-300 flex flex-col items-center text-center relative overflow-hidden">
                <div class="absolute inset-0 bg-white/10 blur opacity-0 group-hover:opacity-100 transition duration-300"></div>
                <i class="fas fa-list text-4xl mb-4 relative z-10"></i>
                <h2 class="text-xl font-bold mb-2 relative z-10">Manage Your Polls</h2>
                <p class="text-sm mb-4 relative z-10">Edit, view, or delete your created polls</p>
                <span class="text-xs opacity-90 relative z-10">Personal Collection</span>
            </a>
        </section>

        <!-- Simple Recent Polls Section (Optional - remove if no data) -->
        <c:if test="${not empty recentPolls}">
            <section class="mb-12">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-2xl font-bold text-gray-900">Recent Polls</h2>
                    <a href="${pageContext.request.contextPath}/poll/recent" class="text-blue-600 hover:text-blue-800 font-semibold text-sm">View All →</a>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <c:forEach var="poll" items="${recentPolls}" varStatus="status">
                        <div class="bg-white rounded-xl p-6 shadow-lg border border-gray-100 hover:shadow-xl transition duration-300">
                            <h3 class="text-lg font-semibold text-gray-900 mb-2">${poll.title}</h3>
                            <p class="text-sm text-gray-600 mb-4">${poll.description}</p>
                            <div class="flex justify-between items-center">
                                <span class="text-xs text-gray-500">${poll.voteCount} votes</span>
                                <a href="${pageContext.request.contextPath}/poll/view?id=${poll.id}" class="text-blue-600 hover:text-blue-800 font-semibold text-sm">Vote Now</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </section>
        </c:if>
    </main>

    <!-- Footer -->
    <footer class="bg-white border-t border-gray-200 mt-16">
        <div class="container mx-auto px-4 py-8 text-center text-gray-600">
            <p>&copy; 2025 PollVerse. All rights reserved</p>
        </div>
    </footer>
</body>
</html>