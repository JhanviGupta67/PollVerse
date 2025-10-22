<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
<title>Welcome to PollVerse</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
/* Reset and Base Styles */
* {
margin: 0;
padding: 0;
box-sizing: border-box;
}

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        /* Vibrant background gradient */
        background: linear-gradient(135deg, #1f4068 0%, #162447 100%);
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        color: #e4e4e4; /* Light text for dark background */
    }

    .welcome-container {
        background: rgba(255, 255, 255, 0.95); /* Slightly translucent white background */
        padding: 60px 40px;
        border-radius: 20px;
        max-width: 600px;
        width: 90%;
        text-align: center;
        /* Enhanced shadow for depth */
        box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        transition: transform 0.4s ease-in-out;
        color: #333; /* Dark text inside the box */
        border: 1px solid rgba(255, 255, 255, 0.5);
    }

    .welcome-container:hover {
        transform: scale(1.02);
    }

    h1 {
        font-size: 3em;
        color: #1f4068;
        margin-bottom: 15px;
        text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
    }

    .tagline {
        font-size: 1.2em;
        color: #555;
        margin-bottom: 35px;
        line-height: 1.6;
        font-weight: 500;
    }

    .btn-group {
        margin-top: 30px;
    }

    .btn {
        display: inline-block;
        padding: 15px 35px;
        margin: 10px;
        font-size: 1.2em;
        font-weight: bold;
        color: #fff;
        text-decoration: none;
        border-radius: 50px;
        border: none;
        cursor: pointer;
        text-transform: uppercase;
        letter-spacing: 1px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        transition: all 0.3s ease;
    }

    .btn-register {
        background: #e43f5a; /* Strong, contrasting call-to-action color */
    }

    .btn-register:hover {
        background: #c9364b;
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(0,0,0,0.25);
    }

    .btn-login {
        background: #4060ff; /* Secondary action color */
    }

    .btn-login:hover {
        background: #3653d6;
        transform: translateY(-2px);
    }

    .footer-text {
        margin-top: 30px;
        font-size: 0.9em;
        color: #888;
    }

    @media (max-width: 600px) {
        .welcome-container {
            padding: 40px 20px;
            border-radius: 10px;
        }

        h1 {
            font-size: 2.2em;
        }

        .tagline {
            font-size: 1em;
        }

        .btn {
            font-size: 1em;
            padding: 12px 25px;
            display: block; /* Stack buttons on mobile */
            width: 100%;
        }
    }
</style>

</head>
<body>
<div class="welcome-container">
<h1>Welcome to PollVerse!</h1>
<p class="tagline">
Your Voice, Instant Results. The fastest way to create, share, and vote on secure, four-option polls.
</p>

    <div class="btn-group">         <a href="${pageContext.request.contextPath}/register" class="btn btn-register">             Start Polling (Register)         </a>         <a href="${pageContext.request.contextPath}/login" class="btn btn-login">             I Already Have an Account         </a>     </div>      <p class="footer-text">         Join thousands of users sharing their opinions and insights instantly.     </p> </div> 

</body>
</html>