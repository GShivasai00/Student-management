<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Error - Student Management System</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body>
            <div class="container">
                <div class="error-container">
                    <div class="error-card">
                        <h1>Oops! Something went wrong</h1>

                        <c:if test="${not empty error}">
                            <div class="error-message">
                                <p>${error}</p>
                            </div>
                        </c:if>

                        <div class="error-actions">
                            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
                            <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
                        </div>

                        <div class="error-help">
                            <p>If this problem persists, please contact the system administrator.</p>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>