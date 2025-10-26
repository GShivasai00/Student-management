<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Add Student - Student Management System</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body>
            <div class="container">
                <header class="header">
                    <h1>Student Management System</h1>
                    <div class="user-info">
                        <span>Welcome, ${sessionScope.username}</span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary">Logout</a>
                    </div>
                </header>

                <nav class="nav">
                    <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/students" class="nav-link active">Students</a>
                </nav>

                <main class="main-content">
                    <div class="page-header">
                        <h2>Add New Student</h2>
                        <a href="${pageContext.request.contextPath}/students" class="btn btn-secondary">Back to
                            Students</a>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-error">${error}</div>
                    </c:if>

                    <div class="form-container">
                        <form action="${pageContext.request.contextPath}/students" method="post" class="student-form">
                            <input type="hidden" name="action" value="add">

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="studentId">Student ID *</label>
                                    <input type="text" id="studentId" name="studentId" required
                                        placeholder="e.g., STU001">
                                </div>
                                <div class="form-group">
                                    <label for="status">Status</label>
                                    <select id="status" name="status">
                                        <option value="active">Active</option>
                                        <option value="inactive">Inactive</option>
                                        <option value="graduated">Graduated</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="firstName">First Name *</label>
                                    <input type="text" id="firstName" name="firstName" required
                                        placeholder="Enter first name">
                                </div>
                                <div class="form-group">
                                    <label for="lastName">Last Name *</label>
                                    <input type="text" id="lastName" name="lastName" required
                                        placeholder="Enter last name">
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="email">Email *</label>
                                    <input type="email" id="email" name="email" required
                                        placeholder="Enter email address">
                                </div>
                                <div class="form-group">
                                    <label for="phone">Phone</label>
                                    <input type="tel" id="phone" name="phone" placeholder="Enter phone number">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="dateOfBirth">Date of Birth</label>
                                <input type="date" id="dateOfBirth" name="dateOfBirth">
                            </div>

                            <div class="form-group">
                                <label for="address">Address</label>
                                <textarea id="address" name="address" rows="3" placeholder="Enter address"></textarea>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="course">Course</label>
                                    <input type="text" id="course" name="course" placeholder="Enter course name">
                                </div>
                                <div class="form-group">
                                    <label for="yearOfStudy">Year of Study</label>
                                    <select id="yearOfStudy" name="yearOfStudy">
                                        <option value="">Select Year</option>
                                        <option value="1">1st Year</option>
                                        <option value="2">2nd Year</option>
                                        <option value="3">3rd Year</option>
                                        <option value="4">4th Year</option>
                                        <option value="5">5th Year</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="gpa">GPA</label>
                                <input type="number" id="gpa" name="gpa" step="0.01" min="0" max="4"
                                    placeholder="Enter GPA (0.00 - 4.00)">
                            </div>

                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">Add Student</button>
                                <a href="${pageContext.request.contextPath}/students"
                                    class="btn btn-secondary">Cancel</a>
                            </div>
                        </form>
                    </div>
                </main>
            </div>
        </body>

        </html>