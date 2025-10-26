package com.studentmanagement.servlet;

import com.studentmanagement.dao.StudentDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Servlet for handling dashboard operations
 */
public class DashboardServlet extends HttpServlet {

    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get dashboard statistics
            Map<String, Object> dashboardData = getDashboardData();
            request.setAttribute("dashboardData", dashboardData);

            // Forward to dashboard JSP
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Dashboard error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading dashboard");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * Get dashboard statistics and data
     */
    private Map<String, Object> getDashboardData() {
        Map<String, Object> data = new HashMap<>();

        try {
            // Get student statistics
            int totalStudents = studentDAO.getTotalStudents();
            int activeStudents = studentDAO.getStudentsByStatus("active");
            int inactiveStudents = studentDAO.getStudentsByStatus("inactive");
            int graduatedStudents = studentDAO.getStudentsByStatus("graduated");

            data.put("totalStudents", totalStudents);
            data.put("activeStudents", activeStudents);
            data.put("inactiveStudents", inactiveStudents);
            data.put("graduatedStudents", graduatedStudents);

            // Calculate percentages
            if (totalStudents > 0) {
                data.put("activePercentage", Math.round((double) activeStudents / totalStudents * 100));
                data.put("inactivePercentage", Math.round((double) inactiveStudents / totalStudents * 100));
                data.put("graduatedPercentage", Math.round((double) graduatedStudents / totalStudents * 100));
            } else {
                data.put("activePercentage", 0);
                data.put("inactivePercentage", 0);
                data.put("graduatedPercentage", 0);
            }

            // Get recent students (last 5)
            data.put("recentStudents", studentDAO.getAllStudents().stream()
                    .limit(5)
                    .collect(java.util.stream.Collectors.toList()));

        } catch (Exception e) {
            System.err.println("Error getting dashboard data: " + e.getMessage());
            e.printStackTrace();

            // Set default values in case of error
            data.put("totalStudents", 0);
            data.put("activeStudents", 0);
            data.put("inactiveStudents", 0);
            data.put("graduatedStudents", 0);
            data.put("activePercentage", 0);
            data.put("inactivePercentage", 0);
            data.put("graduatedPercentage", 0);
            data.put("recentStudents", new java.util.ArrayList<>());
        }

        return data;
    }
}
