package com.studentmanagement.dao;

import com.studentmanagement.model.Student;
import com.studentmanagement.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Student operations
 */
public class StudentDAO {

    private DatabaseConnection dbConnection;
    private boolean demoMode = false;

    public StudentDAO() {
        this.dbConnection = DatabaseConnection.getInstance();
        // Check if database connection works, if not enable demo mode
        if (!dbConnection.testConnection()) {
            this.demoMode = true;
            System.out.println("Database not available - Running in DEMO MODE");
        }
    }

    /**
     * Create a new student
     */
    public boolean createStudent(Student student) {
        if (demoMode) {
            System.out.println("DEMO MODE: Student created - " + student.getFullName());
            return true;
        }

        String sql = "INSERT INTO students (student_id, first_name, last_name, email, phone, date_of_birth, address, course, year_of_study, gpa, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, student.getStudentId());
            stmt.setString(2, student.getFirstName());
            stmt.setString(3, student.getLastName());
            stmt.setString(4, student.getEmail());
            stmt.setString(5, student.getPhone());
            stmt.setDate(6, student.getDateOfBirth() != null ? Date.valueOf(student.getDateOfBirth()) : null);
            stmt.setString(7, student.getAddress());
            stmt.setString(8, student.getCourse());
            stmt.setInt(9, student.getYearOfStudy());
            stmt.setDouble(10, student.getGpa());
            stmt.setString(11, student.getStatus());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error creating student: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get student by ID
     */
    public Student getStudentById(int id) {
        if (demoMode) {
            return getDemoStudent(id);
        }

        String sql = "SELECT * FROM students WHERE id = ?";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToStudent(rs);
            }

        } catch (SQLException e) {
            System.err.println("Error getting student by ID: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Get student by student ID
     */
    public Student getStudentByStudentId(String studentId) {
        if (demoMode) {
            return getDemoStudent(1);
        }

        String sql = "SELECT * FROM students WHERE student_id = ?";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, studentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToStudent(rs);
            }

        } catch (SQLException e) {
            System.err.println("Error getting student by student ID: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Get all students
     */
    public List<Student> getAllStudents() {
        if (demoMode) {
            return getDemoStudents();
        }

        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students ORDER BY created_at DESC";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting all students: " + e.getMessage());
            e.printStackTrace();
        }

        return students;
    }

    /**
     * Search students by name or student ID
     */
    public List<Student> searchStudents(String searchTerm) {
        if (demoMode) {
            List<Student> allStudents = getDemoStudents();
            List<Student> filteredStudents = new ArrayList<>();
            String searchLower = searchTerm.toLowerCase();

            for (Student student : allStudents) {
                if (student.getFirstName().toLowerCase().contains(searchLower) ||
                        student.getLastName().toLowerCase().contains(searchLower) ||
                        student.getStudentId().toLowerCase().contains(searchLower) ||
                        student.getEmail().toLowerCase().contains(searchLower)) {
                    filteredStudents.add(student);
                }
            }
            return filteredStudents;
        }

        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE first_name LIKE ? OR last_name LIKE ? OR student_id LIKE ? OR email LIKE ? ORDER BY created_at DESC";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error searching students: " + e.getMessage());
            e.printStackTrace();
        }

        return students;
    }

    /**
     * Update student
     */
    public boolean updateStudent(Student student) {
        if (demoMode) {
            System.out.println("DEMO MODE: Student updated - " + student.getFullName());
            return true;
        }

        String sql = "UPDATE students SET first_name = ?, last_name = ?, email = ?, phone = ?, date_of_birth = ?, address = ?, course = ?, year_of_study = ?, gpa = ?, status = ? WHERE id = ?";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, student.getFirstName());
            stmt.setString(2, student.getLastName());
            stmt.setString(3, student.getEmail());
            stmt.setString(4, student.getPhone());
            stmt.setDate(5, student.getDateOfBirth() != null ? Date.valueOf(student.getDateOfBirth()) : null);
            stmt.setString(6, student.getAddress());
            stmt.setString(7, student.getCourse());
            stmt.setInt(8, student.getYearOfStudy());
            stmt.setDouble(9, student.getGpa());
            stmt.setString(10, student.getStatus());
            stmt.setInt(11, student.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error updating student: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete student
     */
    public boolean deleteStudent(int id) {
        if (demoMode) {
            System.out.println("DEMO MODE: Student deleted - ID: " + id);
            return true;
        }

        String sql = "DELETE FROM students WHERE id = ?";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting student: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get student statistics
     */
    public int getTotalStudents() {
        if (demoMode) {
            return 5; // Demo data
        }

        String sql = "SELECT COUNT(*) FROM students";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Error getting total students: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * Get students by status
     */
    public int getStudentsByStatus(String status) {
        if (demoMode) {
            switch (status) {
                case "active":
                    return 3;
                case "inactive":
                    return 1;
                case "graduated":
                    return 1;
                default:
                    return 0;
            }
        }

        String sql = "SELECT COUNT(*) FROM students WHERE status = ?";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Error getting students by status: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * Get demo students for testing
     */
    private List<Student> getDemoStudents() {
        List<Student> students = new ArrayList<>();

        Student s1 = new Student("STU001", "John", "Doe", "john.doe@email.com");
        s1.setId(1);
        s1.setPhone("1234567890");
        s1.setCourse("Computer Science");
        s1.setYearOfStudy(3);
        s1.setGpa(3.75);
        s1.setStatus("active");
        students.add(s1);

        Student s2 = new Student("STU002", "Jane", "Smith", "jane.smith@email.com");
        s2.setId(2);
        s2.setPhone("0987654321");
        s2.setCourse("Mathematics");
        s2.setYearOfStudy(4);
        s2.setGpa(3.90);
        s2.setStatus("active");
        students.add(s2);

        Student s3 = new Student("STU003", "Mike", "Johnson", "mike.johnson@email.com");
        s3.setId(3);
        s3.setPhone("1122334455");
        s3.setCourse("Physics");
        s3.setYearOfStudy(2);
        s3.setGpa(3.25);
        s3.setStatus("active");
        students.add(s3);

        Student s4 = new Student("STU004", "Sarah", "Wilson", "sarah.wilson@email.com");
        s4.setId(4);
        s4.setPhone("5566778899");
        s4.setCourse("Chemistry");
        s4.setYearOfStudy(4);
        s4.setGpa(3.80);
        s4.setStatus("graduated");
        students.add(s4);

        Student s5 = new Student("STU005", "David", "Brown", "david.brown@email.com");
        s5.setId(5);
        s5.setPhone("9988776655");
        s5.setCourse("Biology");
        s5.setYearOfStudy(3);
        s5.setGpa(3.45);
        s5.setStatus("inactive");
        students.add(s5);

        return students;
    }

    /**
     * Get demo student by ID
     */
    private Student getDemoStudent(int id) {
        List<Student> students = getDemoStudents();
        for (Student student : students) {
            if (student.getId() == id) {
                return student;
            }
        }
        return null;
    }

    /**
     * Map ResultSet to Student object
     */
    private Student mapResultSetToStudent(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setId(rs.getInt("id"));
        student.setStudentId(rs.getString("student_id"));
        student.setFirstName(rs.getString("first_name"));
        student.setLastName(rs.getString("last_name"));
        student.setEmail(rs.getString("email"));
        student.setPhone(rs.getString("phone"));

        Date dateOfBirth = rs.getDate("date_of_birth");
        if (dateOfBirth != null) {
            student.setDateOfBirth(dateOfBirth.toLocalDate());
        }

        student.setAddress(rs.getString("address"));
        student.setCourse(rs.getString("course"));
        student.setYearOfStudy(rs.getInt("year_of_study"));
        student.setGpa(rs.getDouble("gpa"));
        student.setStatus(rs.getString("status"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            student.setCreatedAt(createdAt.toLocalDateTime());
        }

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            student.setUpdatedAt(updatedAt.toLocalDateTime());
        }

        return student;
    }
}