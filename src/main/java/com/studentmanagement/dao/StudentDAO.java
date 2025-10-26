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

    public StudentDAO() {
        this.dbConnection = DatabaseConnection.getInstance();
    }

    /**
     * Create a new student
     */
    public boolean createStudent(Student student) {
        String sql = "INSERT INTO students (student_id, first_name, last_name, email, phone, date_of_birth, address, course, year_of_study, gpa, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, student.getStudentId());
            stmt.setString(2, student.getFirstName());
            stmt.setString(3, student.getLastName());
            stmt.setString(4, student.getEmail());
            stmt.setString(5, student.getPhone());
            stmt.setDate(6, Date.valueOf(student.getDateOfBirth()));
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
     * Update student
     */
    public boolean updateStudent(Student student) {
        String sql = "UPDATE students SET student_id = ?, first_name = ?, last_name = ?, email = ?, phone = ?, date_of_birth = ?, address = ?, course = ?, year_of_study = ?, gpa = ?, status = ?, updated_at = ? WHERE id = ?";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, student.getStudentId());
            stmt.setString(2, student.getFirstName());
            stmt.setString(3, student.getLastName());
            stmt.setString(4, student.getEmail());
            stmt.setString(5, student.getPhone());
            stmt.setDate(6, Date.valueOf(student.getDateOfBirth()));
            stmt.setString(7, student.getAddress());
            stmt.setString(8, student.getCourse());
            stmt.setInt(9, student.getYearOfStudy());
            stmt.setDouble(10, student.getGpa());
            stmt.setString(11, student.getStatus());
            stmt.setTimestamp(12, Timestamp.valueOf(LocalDateTime.now()));
            stmt.setInt(13, student.getId());

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
     * Search students by name or student ID
     */
    public List<Student> searchStudents(String searchTerm) {
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
     * Get students by course
     */
    public List<Student> getStudentsByCourse(String course) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE course = ? ORDER BY created_at DESC";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, course);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting students by course: " + e.getMessage());
            e.printStackTrace();
        }

        return students;
    }

    /**
     * Get students by year of study
     */
    public List<Student> getStudentsByYear(int year) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE year_of_study = ? ORDER BY created_at DESC";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, year);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting students by year: " + e.getMessage());
            e.printStackTrace();
        }

        return students;
    }

    /**
     * Get students by status
     */
    public List<Student> getStudentsByStatus(String status) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE status = ? ORDER BY created_at DESC";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting students by status: " + e.getMessage());
            e.printStackTrace();
        }

        return students;
    }

    /**
     * Get total number of students
     */
    public int getTotalStudents() {
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
     * Get students by GPA range
     */
    public List<Student> getStudentsByGPARange(double minGPA, double maxGPA) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE gpa BETWEEN ? AND ? ORDER BY gpa DESC";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDouble(1, minGPA);
            stmt.setDouble(2, maxGPA);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error getting students by GPA range: " + e.getMessage());
            e.printStackTrace();
        }

        return students;
    }

    /**
     * Check if student ID exists
     */
    public boolean studentIdExists(String studentId) {
        String sql = "SELECT COUNT(*) FROM students WHERE student_id = ?";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, studentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            System.err.println("Error checking student ID existence: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Check if email exists
     */
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM students WHERE email = ?";

        try (Connection conn = dbConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
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