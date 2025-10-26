package com.studentmanagement.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database connection utility class
 * Provides methods to establish and manage database connections
 */
public class DatabaseConnection {

    // MySQL Server Settings (for your existing MySQL installation)
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_management?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = ""; // Enter your MySQL root password here

    private static DatabaseConnection instance;
    private Connection connection;

    private DatabaseConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            System.out.println("✅ Database connected successfully!");
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("❌ Database connection failed: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Get singleton instance of DatabaseConnection
     * 
     * @return DatabaseConnection instance
     */
    public static DatabaseConnection getInstance() {
        if (instance == null) {
            synchronized (DatabaseConnection.class) {
                if (instance == null) {
                    instance = new DatabaseConnection();
                }
            }
        }
        return instance;
    }

    /**
     * Get database connection
     * 
     * @return Connection object
     */
    public Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            }
        } catch (SQLException e) {
            System.err.println("Failed to get database connection: " + e.getMessage());
            e.printStackTrace();
        }
        return connection;
    }

    /**
     * Close database connection
     */
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            System.err.println("Failed to close database connection: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Test database connection
     * 
     * @return true if connection is successful, false otherwise
     */
    public boolean testConnection() {
        try {
            Connection conn = getConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ Database connection test successful!");
                return true;
            }
        } catch (SQLException e) {
            System.err.println("❌ Database connection test failed: " + e.getMessage());
        }
        return false;
    }
}