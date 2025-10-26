<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Students - Student Management System</title>
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
                            <h2>Student Management</h2>
                            <a href="${pageContext.request.contextPath}/students?action=add" class="btn btn-primary">Add
                                New Student</a>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-error">${error}</div>
                        </c:if>

                        <c:if test="${not empty success}">
                            <div class="alert alert-success">${success}</div>
                        </c:if>

                        <!-- Search Form -->
                        <div class="search-section">
                            <form action="${pageContext.request.contextPath}/students" method="get" class="search-form">
                                <input type="hidden" name="action" value="search">
                                <div class="search-group">
                                    <input type="text" name="searchTerm"
                                        placeholder="Search by name, student ID, or email..." value="${searchTerm}"
                                        class="search-input">
                                    <button type="submit" class="btn btn-primary">Search</button>
                                    <a href="${pageContext.request.contextPath}/students"
                                        class="btn btn-secondary">Clear</a>
                                </div>
                            </form>
                        </div>

                        <!-- Students Table -->
                        <div class="table-section">
                            <c:choose>
                                <c:when test="${not empty students}">
                                    <div class="table-container">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Student ID</th>
                                                    <th>Name</th>
                                                    <th>Email</th>
                                                    <th>Phone</th>
                                                    <th>Course</th>
                                                    <th>Year</th>
                                                    <th>GPA</th>
                                                    <th>Status</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="student" items="${students}">
                                                    <tr>
                                                        <td>${student.studentId}</td>
                                                        <td>${student.fullName}</td>
                                                        <td>${student.email}</td>
                                                        <td>${student.phone}</td>
                                                        <td>${student.course}</td>
                                                        <td>${student.yearOfStudy}</td>
                                                        <td>
                                                            <c:if test="${student.gpa > 0}">
                                                                <fmt:formatNumber value="${student.gpa}"
                                                                    pattern="0.00" />
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <span
                                                                class="status status-${student.status}">${student.status}</span>
                                                        </td>
                                                        <td class="actions">
                                                            <a href="${pageContext.request.contextPath}/students?action=edit&id=${student.id}"
                                                                class="btn btn-sm btn-primary">Edit</a>
                                                            <a href="${pageContext.request.contextPath}/students?action=delete&id=${student.id}"
                                                                class="btn btn-sm btn-danger"
                                                                onclick="return confirm('Are you sure you want to delete this student?')">Delete</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div class="table-info">
                                        <p>Showing ${students.size()} student(s)</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-data">
                                        <p>No students found.</p>
                                        <c:if test="${not empty searchTerm}">
                                            <p>Try adjusting your search criteria.</p>
                                        </c:if>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </main>
                </div>
            </body>

            </html>