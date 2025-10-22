<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - PollVerse</title>

    <!-- ✅ Tailwind CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-blue-50 via-indigo-50 to-white min-h-screen flex items-center justify-center">

    <div class="w-full max-w-md bg-white/90 backdrop-blur-md rounded-2xl shadow-xl p-8">
        <h2 class="text-3xl font-bold text-center text-indigo-600 mb-6">Join PollVerse</h2>

        <!-- Error message -->
        <c:if test="${not empty error}">
            <p class="bg-red-100 border border-red-400 text-red-700 px-4 py-2 rounded-lg text-center mb-4">
                ${error}
            </p>
        </c:if>

        <!-- Form -->
        <form:form action="${pageContext.request.contextPath}/user/register" 
                   method="POST" 
                   modelAttribute="user"
                   class="space-y-5">

            <!-- Username -->
            <div>
                <label for="username" class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                <form:input path="username" id="username" required="true"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:outline-none"/>
            </div>

            <!-- Email -->
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                <form:input path="email" id="email" type="email" required="true"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:outline-none"/>
            </div>

            <!-- Password -->
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                <form:password path="password" id="password" required="true"
                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:outline-none"/>
            </div>

            <!-- Submit -->
            <button type="submit"
                class="w-full bg-indigo-600 text-white font-semibold py-2.5 rounded-lg shadow hover:bg-indigo-700 transition duration-300">
                Create Account
            </button>
        </form:form>

        <!-- Login link -->
        <p class="text-center text-gray-600 text-sm mt-6">
            Already have an account?
            <a href="${pageContext.request.contextPath}/user/login"
               class="text-indigo-600 font-medium hover:underline">
               Login here
            </a>
        </p>
    </div>

</body>
</html>
