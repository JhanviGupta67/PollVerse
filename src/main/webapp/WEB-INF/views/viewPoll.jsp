<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>${poll.question} - PollVerse</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">

    <!-- Header -->
    <jsp:include page="header.jsp" />

    <div class="flex justify-center pt-20 px-4">
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
                        
                        <c:if test="${not empty poll.option1}">
                            <div class="flex items-center mb-4">
                                <input type="radio" id="option1" name="selectedOption" value="1" required class="w-5 h-5 text-blue-600">
                                <label for="option1" class="ml-3 text-gray-700 text-lg cursor-pointer">${poll.option1}</label>
                            </div>
                        </c:if>

                        <c:if test="${not empty poll.option2}">
                            <div class="flex items-center mb-4">
                                <input type="radio" id="option2" name="selectedOption" value="2" required class="w-5 h-5 text-blue-600">
                                <label for="option2" class="ml-3 text-gray-700 text-lg cursor-pointer">${poll.option2}</label>
                            </div>
                        </c:if>

                        <c:if test="${not empty poll.option3}">
                            <div class="flex items-center mb-4">
                                <input type="radio" id="option3" name="selectedOption" value="3" class="w-5 h-5 text-blue-600">
                                <label for="option3" class="ml-3 text-gray-700 text-lg cursor-pointer">${poll.option3}</label>
                            </div>
                        </c:if>

                        <c:if test="${not empty poll.option4}">
                            <div class="flex items-center mb-4">
                                <input type="radio" id="option4" name="selectedOption" value="4" class="w-5 h-5 text-blue-600">
                                <label for="option4" class="ml-3 text-gray-700 text-lg cursor-pointer">${poll.option4}</label>
                            </div>
                        </c:if>

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
            <div class="mt-6">
                <h2 class="text-xl font-bold text-gray-700 mb-4">Poll Results</h2>

                <c:if test="${not empty poll.option1}">
                    <c:set var="voteCount" value="${results[1]}" />
                    <c:if test="${empty voteCount}"><c:set var="voteCount" value="0"/></c:if>
                    <c:set var="percentage" value="${totalVotes > 0 ? (voteCount * 100) / totalVotes : 0}" />
                    <div class="mb-4">
                        <div class="text-gray-700 font-semibold mb-1">${poll.option1} (${voteCount} votes)</div>
                        <div class="w-full bg-gray-200 h-6 rounded-lg overflow-hidden">
                            <div class="bg-blue-600 h-6 text-white text-right pr-2 leading-6 transition-all" style="width: ${percentage}%; ">
                                <c:if test="${percentage > 5}">${percentage}%</c:if>
                            </div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty poll.option2}">
                    <c:set var="voteCount" value="${results[2]}" />
                    <c:if test="${empty voteCount}"><c:set var="voteCount" value="0"/></c:if>
                    <c:set var="percentage" value="${totalVotes > 0 ? (voteCount * 100) / totalVotes : 0}" />
                    <div class="mb-4">
                        <div class="text-gray-700 font-semibold mb-1">${poll.option2} (${voteCount} votes)</div>
                        <div class="w-full bg-gray-200 h-6 rounded-lg overflow-hidden">
                            <div class="bg-blue-600 h-6 text-white text-right pr-2 leading-6 transition-all" style="width: ${percentage}%; ">
                                <c:if test="${percentage > 5}">${percentage}%</c:if>
                            </div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty poll.option3}">
                    <c:set var="voteCount" value="${results[3]}" />
                    <c:if test="${empty voteCount}"><c:set var="voteCount" value="0"/></c:if>
                    <c:set var="percentage" value="${totalVotes > 0 ? (voteCount * 100) / totalVotes : 0}" />
                    <div class="mb-4">
                        <div class="text-gray-700 font-semibold mb-1">${poll.option3} (${voteCount} votes)</div>
                        <div class="w-full bg-gray-200 h-6 rounded-lg overflow-hidden">
                            <div class="bg-blue-600 h-6 text-white text-right pr-2 leading-6 transition-all" style="width: ${percentage}%; ">
                                <c:if test="${percentage > 5}">${percentage}%</c:if>
                            </div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty poll.option4}">
                    <c:set var="voteCount" value="${results[4]}" />
                    <c:if test="${empty voteCount}"><c:set var="voteCount" value="0"/></c:if>
                    <c:set var="percentage" value="${totalVotes > 0 ? (voteCount * 100) / totalVotes : 0}" />
                    <div class="mb-4">
                        <div class="text-gray-700 font-semibold mb-1">${poll.option4} (${voteCount} votes)</div>
                        <div class="w-full bg-gray-200 h-6 rounded-lg overflow-hidden">
                            <div class="bg-blue-600 h-6 text-white text-right pr-2 leading-6 transition-all" style="width: ${percentage}%; ">
                                <c:if test="${percentage > 5}">${percentage}%</c:if>
                            </div>
                        </div>
                    </div>
                </c:if>

                <div class="text-center font-bold text-gray-600 mt-4">
                    Total Votes Cast: ${totalVotes}
                </div>
            </div>

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
    </div>

</body>
</html>
