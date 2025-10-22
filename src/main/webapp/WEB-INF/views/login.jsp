<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - PollVerse</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        // Custom color palette matching the registration page
                        'poll-primary': {
                            50: '#F0F9FF',
                            100: '#E0F2FE',
                            200: '#BAE6FD',
                            500: '#0EA5E9', // Sky Blue
                            600: '#0284C7',
                            700: '#0369A1',
                        },
                        'poll-accent': {
                            500: '#8B5CF6', // Violet
                        }
                    },
                    boxShadow: {
                        'brand': '0 10px 30px -5px rgba(14, 165, 233, 0.4)', 
                    }
                }
            }
        }
    </script>
</head>
<body class="min-h-screen flex items-center justify-center p-4 
             bg-gradient-to-br from-gray-200 to-indigo-100">

    <div class="w-full max-w-lg bg-white p-10 shadow-2xl rounded-3xl border border-gray-100 transform transition duration-500 hover:scale-[1.01] animate-in slide-in-from-top-10">
        
          <div class="text-center mb-8">
            <h2 class="text-4xl font-extrabold text-poll-primary-600 tracking-tight">
                Welcome <span class="text-poll-accent-500">Back</span>
            </h2>
            <p class="text-gray-500 text-lg mt-1">Sign in to your PollVerse account</p>
        </div>

        <c:if test="${not empty error}">
            <div class="bg-red-50 border border-red-300 text-red-700 px-4 py-3 rounded-xl flex items-center mb-6 shadow-sm">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-3 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                </svg>
                <span class="font-medium">${error}</span>
            </div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="bg-green-50 border border-green-300 text-green-700 px-4 py-3 rounded-xl flex items-center mb-6 shadow-sm">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-3 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span class="font-medium">${message}</span>
            </div>
        </c:if>

        <form:form action="${pageContext.request.contextPath}/login" 
                   method="POST" 
                   modelAttribute="user"
                   class="space-y-6">
            
            <div>
                <label for="username" class="block text-sm font-semibold text-gray-700 mb-1">Username:</label>
                <form:input path="username" id="username" required="true"
                    class="w-full px-5 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-poll-primary-500 focus:border-poll-primary-500 transition duration-200 shadow-inner placeholder-gray-400"
                    placeholder="Enter your username"/>
            </div>
            
            <div>
                <label for="password" class="block text-sm font-semibold text-gray-700 mb-1">Password:</label>
                <div class="relative">
                    <form:password path="password" id="password" required="true"
                        class="w-full px-5 py-3 border border-gray-300 rounded-xl focus:ring-3 focus:ring-poll-primary-500 focus:border-poll-primary-500 transition duration-200 shadow-inner pr-12"
                        placeholder="Enter your password"/> 
                    
                    <button type="button" id="togglePassword" class="absolute inset-y-0 right-0 flex items-center pr-3 focus:outline-none">
                        <svg id="eyeOff" class="h-5 w-5 text-gray-400 hover:text-gray-600 transition" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.879m8.234-2.228A6.8 6.8 0 0112 5c-4.478 0-8.268 2.943-9.543 7a10.03 10.03 0 00.99 2.064M21 12c-1.275 4.057-5.065 7-9.543 7a9.97 9.97 0 01-1.563-.879m8.234-2.228A6.8 6.8 0 0012 5c-4.478 0-8.268 2.943-9.543 7m17.15-2.228l-3.23-3.23M15 9l3.23-3.23M2 2l20 20" />
                        </svg>
                        <svg id="eyeOn" class="h-5 w-5 text-gray-400 hover:text-gray-600 transition hidden" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                        </svg>
                    </button>
                </div>
            </div>
            
            <button type="submit"
                class="w-full bg-gradient-to-r from-poll-primary-600 to-poll-accent-500 text-white font-bold text-lg py-3 rounded-xl shadow-brand hover:shadow-lg transform hover:-translate-y-0.5 transition duration-300 ease-in-out mt-8">
                Login
            </button>
        </form:form>
        
        <p class="text-center text-gray-600 text-base mt-6">
            Don't have an account? 
            <a href="${pageContext.request.contextPath}/register"
               class="text-poll-primary-600 font-bold hover:text-poll-primary-700 hover:underline transition duration-200 ml-1">
               Register now
            </a>
        </p>

        <div class="mt-8 pt-4 border-t border-gray-100 flex justify-center">
            <p class="text-xs text-gray-400">© PollVerse</p>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const passwordInput = document.getElementById('password');
            const toggleButton = document.getElementById('togglePassword');
            const eyeOffIcon = document.getElementById('eyeOff');
            const eyeOnIcon = document.getElementById('eyeOn');

            // Set initial state: type is 'password', show eyeOff icon
            passwordInput.setAttribute('type', 'password');
            eyeOffIcon.classList.remove('hidden');
            eyeOnIcon.classList.add('hidden');

            toggleButton.addEventListener('click', function () {
                // Toggle the type attribute
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);

                // Toggle the eye icons
                eyeOffIcon.classList.toggle('hidden');
                eyeOnIcon.classList.toggle('hidden');
            });
        });
    </script>
</body>
</html>