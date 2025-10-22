🗳️ PollVerse

Overview:
PollVerse is a full-stack web application built using Spring MVC that allows users to create, manage, and participate in online polls.
It includes secure user authentication (login and signup), poll creation, voting functionality, and real-time result viewing.
The project follows a clean MVC layered architecture and runs on Apache Tomcat 9.

Tech Stack:
Frontend: JSP, HTML5, Tailwind CSS
Backend: Spring MVC, Spring JDBC
Database: MySQL
Build Tool: Maven
Server: Apache Tomcat 9
IDE: Eclipse


Core Features:
User Authentication: Login and signup functionality using Spring MVC forms
Create Polls: Authenticated users can create new polls with multiple options
Voting System: Users can vote once per poll and view live results
Poll Management: Creators can delete their own polls
Dashboard: Displays all active and past polls
Responsive UI: Built using Tailwind CSS for a clean and modern look


Project Structure:

PollVerse/
│
├── src/main/java/com/pollverse/controller/ → Handles web requests (Controllers)
├── src/main/java/com/pollverse/service/ → Business logic layer (Services)
├── src/main/java/com/pollverse/dao/ → Data access layer using Spring JDBC
├── src/main/java/com/pollverse/model/ → Entity / Model classes
│
├── src/main/webapp/WEB-INF/spring/ → Spring configuration files
│  ├── application-context.xml
│  └── spring-servlet.xml
│
├── src/main/webapp/WEB-INF/views/ → JSP pages for UI
├── src/main/webapp/index.jsp → Landing page
├── src/main/webapp/WEB-INF/web.xml → Deployment descriptor
│
├── test/ → Test classes (if any)
├── target/ → Compiled WAR and generated files
└── pom.xml → Maven configuration and dependencies


Database Details:

Database Used: MySQL
Database Name: pollversedb

Tables:

users – stores user credentials and profile info (username, email, password)

polls – stores poll details (question, options, creator, created_at)

votes – stores votes cast by users for specific poll options

Database connection: Configured in the Spring configuration file (application-context.xml) using Spring JDBC DataSource properties.

How to Run the Project:

Open the project in Eclipse IDE.
Configure Apache Tomcat 9 as the server.
Build the project using Maven → Run As → Maven Install.
A .war file will be generated inside the target folder.
Deploy the WAR file to Tomcat.
Start the server and open your browser at:
http://localhost:8080/PollVerse/

