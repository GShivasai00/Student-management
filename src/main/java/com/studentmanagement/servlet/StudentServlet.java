package com.studentmanagement.servlet;

import com.studentmanagement.dao.StudentDAO;
import com.studentmanagement.model.Student;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

/**
 * Servlet for handling student CRUD operations
 */
public class StudentServlet extends HttpServlet {

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

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    listStudents(request, response);
                    break;
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteStudent(request, response);
                    break;
                case "search":
                    searchStudents(request, response);
                    break;
                default:
                    listStudents(request, response);
                    break;
            }
        } catch (Exception e) {
            System.err.println("Student servlet error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addStudent(request, response);
                    break;
                case "update":
                    updateStudent(request, response);
                    break;
                default:
                    listStudents(request, response);
                    break;
            }
        } catch (Exception e) {
            System.err.println("Student servlet error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * List all students
     */
    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);
        request.getRequestDispatcher("/students.jsp").forward(request, response);
    }

    /**
     * Show add student form
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/add-student.jsp").forward(request, response);
    }

    /**
     * Show edit student form
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                Student student = studentDAO.getStudentById(id);
                if (student != null) {
                    request.setAttribute("student", student);
                    request.getRequestDispatcher("/edit-student.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Student not found");
                    listStudents(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid student ID");
                listStudents(request, response);
            }
        } else {
            request.setAttribute("error", "Student ID is required");
            listStudents(request, response);
        }
    }

    /**
     * Add new student
     */
    private void addStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentId = request.getParameter("studentId");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        String address = request.getParameter("address");
        String course = request.getParameter("course");
        String yearOfStudyStr = request.getParameter("yearOfStudy");
        String gpaStr = request.getParameter("gpa");
        String status = request.getParameter("status");

        // Validate required fields
        if (studentId == null || studentId.trim().isEmpty() ||
                firstName == null || firstName.trim().isEmpty() ||
                lastName == null || lastName.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Student ID, First Name, Last Name, and Email are required");
            showAddForm(request, response);
            return;
        }

        try {
            Student student = new Student(studentId, firstName, lastName, email);
            student.setPhone(phone);
            student.setAddress(address);
            student.setCourse(course);
            student.setStatus(status != null ? status : "active");

            if (dateOfBirthStr != null && !dateOfBirthStr.trim().isEmpty()) {
                student.setDateOfBirth(LocalDate.parse(dateOfBirthStr));
            }

            if (yearOfStudyStr != null && !yearOfStudyStr.trim().isEmpty()) {
                student.setYearOfStudy(Integer.parseInt(yearOfStudyStr));
            }

            if (gpaStr != null && !gpaStr.trim().isEmpty()) {
                student.setGpa(Double.parseDouble(gpaStr));
            }

            if (studentDAO.createStudent(student)) {
                request.setAttribute("success", "Student added successfully");
                listStudents(request, response);
            } else {
                request.setAttribute("error", "Failed to add student");
                showAddForm(request, response);
            }

        } catch (Exception e) {
            System.err.println("Add student error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Invalid data format");
            showAddForm(request, response);
        }
    }

    /**
     * Update student
     */
    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            request.setAttribute("error", "Student ID is required");
            listStudents(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Student student = studentDAO.getStudentById(id);

            if (student == null) {
                request.setAttribute("error", "Student not found");
                listStudents(request, response);
                return;
            }

            // Update student fields
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String dateOfBirthStr = request.getParameter("dateOfBirth");
            String address = request.getParameter("address");
            String course = request.getParameter("course");
            String yearOfStudyStr = request.getParameter("yearOfStudy");
            String gpaStr = request.getParameter("gpa");
            String status = request.getParameter("status");

            if (firstName != null)
                student.setFirstName(firstName);
            if (lastName != null)
                student.setLastName(lastName);
            if (email != null)
                student.setEmail(email);
            if (phone != null)
                student.setPhone(phone);
            if (address != null)
                student.setAddress(address);
            if (course != null)
                student.setCourse(course);
            if (status != null)
                student.setStatus(status);

            if (dateOfBirthStr != null && !dateOfBirthStr.trim().isEmpty()) {
                student.setDateOfBirth(LocalDate.parse(dateOfBirthStr));
            }

            if (yearOfStudyStr != null && !yearOfStudyStr.trim().isEmpty()) {
                student.setYearOfStudy(Integer.parseInt(yearOfStudyStr));
            }

            if (gpaStr != null && !gpaStr.trim().isEmpty()) {
                student.setGpa(Double.parseDouble(gpaStr));
            }

            if (studentDAO.updateStudent(student)) {
                request.setAttribute("success", "Student updated successfully");
                listStudents(request, response);
            } else {
                request.setAttribute("error", "Failed to update student");
                showEditForm(request, response);
            }

        } catch (Exception e) {
            System.err.println("Update student error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Invalid data format");
            showEditForm(request, response);
        }
    }

    /**
     * Delete student
     */
    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                if (studentDAO.deleteStudent(id)) {
                    request.setAttribute("success", "Student deleted successfully");
                } else {
                    request.setAttribute("error", "Failed to delete student");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid student ID");
            }
        } else {
            request.setAttribute("error", "Student ID is required");
        }

        listStudents(request, response);
    }

    /**
     * Search students
     */
    private void searchStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchTerm = request.getParameter("searchTerm");
        List<Student> students;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            students = studentDAO.searchStudents(searchTerm);
            request.setAttribute("searchTerm", searchTerm);
        } else {
            students = studentDAO.getAllStudents();
        }

        request.setAttribute("students", students);
        request.getRequestDispatcher("/students.jsp").forward(request, response);
    }
}
