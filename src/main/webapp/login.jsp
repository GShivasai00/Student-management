<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Login - Student Management System</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body>
            <div class="container">
                <div class="auth-container">
                    <div class="auth-card">
                        <h2>Login</h2>

                        <c:if test="${not empty error}">
                            <div class="alert alert-error">${error}</div>
                        </c:if>

                        <c:if test="${not empty success}">
                            <div class="alert alert-success">${success}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/login" method="post" class="auth-form">
                            <div class="form-group">
                                <label for="username">Username:</label>
                                <input type="text" id="username" name="username" required value="${param.username}"
                                    placeholder="Enter your username">
                            </div>

                            <div class="form-group">
                                <label for="password">Password:</label>
                                <input type="password" id="password" name="password" required
                                    placeholder="Enter your password">
                            </div>

                            <button type="submit" class="btn btn-primary btn-full">Login</button>
                        </form>

                        <div class="auth-links">
                            <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register
                                    here</a></p>
                            <p><a href="${pageContext.request.contextPath}/">Back to Home</a></p>
                        </div>

                        <div class="demo-credentials">
                            <h4>Demo Credentials:</h4>
                            <p><strong>Username:</strong> admin</p>
                            <p><strong>Password:</strong> admin123</p>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>