<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Register - Student Management System</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body>
            <div class="container">
                <div class="auth-container">
                    <div class="auth-card">
                        <h2>Register</h2>

                        <c:if test="${not empty error}">
                            <div class="alert alert-error">${error}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/register" method="post" class="auth-form">
                            <div class="form-group">
                                <label for="username">Username:</label>
                                <input type="text" id="username" name="username" required value="${param.username}"
                                    placeholder="Choose a username">
                            </div>

                            <div class="form-group">
                                <label for="email">Email:</label>
                                <input type="email" id="email" name="email" required value="${param.email}"
                                    placeholder="Enter your email">
                            </div>

                            <div class="form-group">
                                <label for="password">Password:</label>
                                <input type="password" id="password" name="password" required
                                    placeholder="Enter your password (min 6 characters)">
                            </div>

                            <div class="form-group">
                                <label for="confirmPassword">Confirm Password:</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" required
                                    placeholder="Confirm your password">
                            </div>

                            <button type="submit" class="btn btn-primary btn-full">Register</button>
                        </form>

                        <div class="auth-links">
                            <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login
                                    here</a></p>
                            <p><a href="${pageContext.request.contextPath}/">Back to Home</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>