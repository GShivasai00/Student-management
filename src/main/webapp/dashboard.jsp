<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Dashboard - Student Management System</title>
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
                        <a href="${pageContext.request.contextPath}/dashboard" class="nav-link active">Dashboard</a>
                        <a href="${pageContext.request.contextPath}/students" class="nav-link">Students</a>
                    </nav>

                    <main class="main-content">
                        <h2>Dashboard</h2>

                        <c:if test="${not empty error}">
                            <div class="alert alert-error">${error}</div>
                        </c:if>

                        <c:if test="${not empty success}">
                            <div class="alert alert-success">${success}</div>
                        </c:if>

                        <!-- Statistics Cards -->
                        <div class="stats-grid">
                            <div class="stat-card">
                                <h3>Total Students</h3>
                                <div class="stat-number">${dashboardData.totalStudents}</div>
                            </div>
                            <div class="stat-card">
                                <h3>Active Students</h3>
                                <div class="stat-number">${dashboardData.activeStudents}</div>
                                <div class="stat-percentage">${dashboardData.activePercentage}%</div>
                            </div>
                            <div class="stat-card">
                                <h3>Inactive Students</h3>
                                <div class="stat-number">${dashboardData.inactiveStudents}</div>
                                <div class="stat-percentage">${dashboardData.inactivePercentage}%</div>
                            </div>
                            <div class="stat-card">
                                <h3>Graduated Students</h3>
                                <div class="stat-number">${dashboardData.graduatedStudents}</div>
                                <div class="stat-percentage">${dashboardData.graduatedPercentage}%</div>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="quick-actions">
                            <h3>Quick Actions</h3>
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/students?action=add"
                                    class="btn btn-primary">Add New Student</a>
                                <a href="${pageContext.request.contextPath}/students" class="btn btn-secondary">View All
                                    Students</a>
                            </div>
                        </div>

                        <!-- Recent Students -->
                        <div class="recent-students">
                            <h3>Recent Students</h3>
                            <c:choose>
                                <c:when test="${not empty dashboardData.recentStudents}">
                                    <div class="table-container">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Student ID</th>
                                                    <th>Name</th>
                                                    <th>Email</th>
                                                    <th>Course</th>
                                                    <th>Status</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="student" items="${dashboardData.recentStudents}">
                                                    <tr>
                                                        <td>${student.studentId}</td>
                                                        <td>${student.fullName}</td>
                                                        <td>${student.email}</td>
                                                        <td>${student.course}</td>
                                                        <td>
                                                            <span
                                                                class="status status-${student.status}">${student.status}</span>
                                                        </td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/students?action=edit&id=${student.id}"
                                                                class="btn btn-sm btn-primary">Edit</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <p class="no-data">No students found.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </main>
                </div>
            </body>

            </html>