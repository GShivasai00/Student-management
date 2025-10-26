<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Student Management System</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body>
            <div class="container">
                <header class="header">
                    <h1>Student Management System</h1>
                    <p>A platform for managing student records, including adding, updating, viewing, and deleting
                        student details.</p>
                </header>

                <main class="main-content">
                    <div class="welcome-section">
                        <h2>Welcome to Student Management System</h2>
                        <p>Please login to access the system or register for a new account.</p>

                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Login</a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-secondary">Register</a>
                        </div>
                    </div>

                    <div class="features-section">
                        <h3>System Features</h3>
                        <div class="features-grid">
                            <div class="feature-card">
                                <h4>Student Management</h4>
                                <p>Add, edit, view, and delete student records</p>
                            </div>
                            <div class="feature-card">
                                <h4>Dashboard & Reports</h4>
                                <p>View statistics and generate reports</p>
                            </div>
                            <div class="feature-card">
                                <h4>Search & Filter</h4>
                                <p>Find students quickly with search functionality</p>
                            </div>
                            <div class="feature-card">
                                <h4>User Authentication</h4>
                                <p>Secure login and registration system</p>
                            </div>
                        </div>
                    </div>
                </main>

                <footer class="footer">
                    <p>&copy; 2024 Student Management System. All rights reserved.</p>
                </footer>
            </div>
        </body>

        </html>