<!-- header.jsp -->
<header class="bg-blue-600 text-white shadow-lg py-4 px-6 sm:px-8">
    <div class="container mx-auto flex flex-col lg:flex-row justify-between items-center gap-4 lg:gap-0">
        
        <!-- Left Side: Logo and Welcome (for logged-in users) -->
        <div class="flex flex-col sm:flex-row items-center space-y-2 sm:space-y-0 sm:space-x-4">
            <!-- Logo / App Name -->
            <div class="flex-shrink-0 text-2xl font-bold">
                <a href="${pageContext.request.contextPath}/home" class="hover:text-gray-200 transition-colors duration-200">PollVerse</a>
            </div>
            
           
        </div>

        <!-- Right Side: Navigation Links including Home, Polls, and User Actions -->
        <nav class="flex flex-col lg:flex-row lg:items-center lg:space-x-8 space-y-3 lg:space-y-0 w-full lg:w-auto text-center lg:text-right text-lg font-medium">
            <a href="${pageContext.request.contextPath}/home" class="hover:text-gray-200 transition-colors duration-200 py-1">Home</a>
           
            
            <c:choose>
                <c:when test="${not empty sessionScope.username}">
                    <a href="${pageContext.request.contextPath}/logout" class="hover:text-gray-200 transition-colors duration-200 text-sm sm:text-base font-medium px-3 py-1 border border-white/20 rounded-md hover:bg-white/10">Logout</a>
                </c:when>
               
            </c:choose>
        </nav>
    </div>
</header>