<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create New Poll - PollVerse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3B82F6',
                        secondary: '#F59E0B',
                        accent: '#10B981'
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gradient-to-br from-blue-50 via-indigo-50 to-purple-50 min-h-screen px-4 pb-8">

    <!-- Fixed Header (no layout shift) -->
    <div class="fixed top-0 inset-x-0 z-50 bg-white/80 backdrop-blur-md shadow-md">
        <jsp:include page="header.jsp" />
    </div>

    <!-- Page content offset for fixed header -->
    <div class="pt-24">
        <div class="bg-white/80 backdrop-blur-sm rounded-3xl shadow-2xl p-8 w-full max-w-xl mx-auto border border-white/20">
            <div class="text-center mb-8">
                <div class="mx-auto w-16 h-16 bg-gradient-to-r from-primary to-blue-600 rounded-full flex items-center justify-center mb-4 shadow-lg">
                    <i class="fas fa-chart-bar text-white text-2xl"></i>
                </div>
                <h2 class="text-3xl font-bold text-gray-800 mb-2">Create Your Poll</h2>
                <p class="text-gray-600">Share your ideas and let others vote!</p>
            </div>

            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl mb-6 text-sm font-medium flex items-center space-x-2">
                    <i class="fas fa-exclamation-triangle text-red-500"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- Poll Form -->
            <form:form action="${pageContext.request.contextPath}/poll/create" method="POST" modelAttribute="poll" class="space-y-6">
                
                <!-- Poll Question -->
                <div>
                    <label for="question" class="block font-semibold text-gray-700 mb-3 flex items-center space-x-2">
                        <i class="fas fa-question-circle text-primary"></i>
                        <span>Poll Question</span>
                    </label>
                    <form:textarea path="question" id="question" rows="3" placeholder="e.g., What's your favorite color?" required="true" 
                        class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:ring-4 focus:ring-primary/20 focus:border-primary transition-all duration-300 resize-none"></form:textarea>
                </div>

                <!-- Options -->
                <div class="border-2 border-gray-100 rounded-2xl p-5 space-y-4 bg-gray-50/50">
                    <label class="block font-semibold text-gray-700 mb-3 flex items-center space-x-2">
                        <i class="fas a-list text-secondary"></i>
                        <span>Options (At least 2 required)</span>
                    </label>

                    <div class="space-y-3">
                        <div class="flex items-center space-x-3">
                            <div class="w-8 h-8 bg-gray-300 rounded-full flex items-center justify-center text-gray-500 font-bold text-sm">1</div>
                            <form:input path="option1" id="option1" required="true" placeholder="Option 1"
                                class="flex-1 px-4 py-3 border-2 border-gray-200 rounded-xl focus:ring-4 focus:ring-secondary/20 focus:border-secondary transition-all duration-300" />
                        </div>

                        <div class="flex items-center space-x-3">
                            <div class="w-8 h-8 bg-gray-300 rounded-full flex items-center justify-center text-gray-500 font-bold text-sm">2</div>
                            <form:input path="option2" id="option2" required="true" placeholder="Option 2"
                                class="flex-1 px-4 py-3 border-2 border-gray-200 rounded-xl focus:ring-4 focus:ring-secondary/20 focus:border-secondary transition-all duration-300" />
                        </div>

                        <div class="flex items-center space-x-3">
                            <div class="w-8 h-8 bg-gray-300 rounded-full flex items-center justify-center text-gray-500 font-bold text-sm">3</div>
                            <form:input path="option3" id="option3" placeholder="Option 3"
                                class="flex-1 px-4 py-3 border-2 border-gray-200 rounded-xl focus:ring-4 focus:ring-accent/20 focus:border-accent transition-all duration-300" />
                        </div>

                        <div class="flex items-center space-x-3">
                            <div class="w-8 h-8 bg-gray-300 rounded-full flex items-center justify-center text-gray-500 font-bold text-sm">4</div>
                            <form:input path="option4" id="option4" placeholder="Option 4"
                                class="flex-1 px-4 py-3 border-2 border-gray-200 rounded-xl focus:ring-4 focus:ring-accent/20 focus:border-accent transition-all duration-300" />
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="w-full bg-gradient-to-r from-secondary to-yellow-500 hover:from-yellow-500 hover:to-secondary text-white font-bold py-4 rounded-2xl shadow-xl transform transition-all duration-300 hover:shadow-2xl hover:scale-[1.02] flex items-center justify-center space-x-3">
                    <i class="fas fa-rocket text-xl"></i>
                    <span class="text-lg">Launch Poll!</span>
                </button>

            </form:form>

            <!-- Back Link -->
            <a href="${pageContext.request.contextPath}/poll/list" class="block text-center mt-6 text-primary hover:text-primary/80 font-semibold transition-colors duration-200 flex items-center justify-center space-x-2 mx-auto">
                <i class="fas fa-arrow-left"></i>
                <span>Back to Polls</span>
            </a>
        </div>
    </div>

</body>
</html>
