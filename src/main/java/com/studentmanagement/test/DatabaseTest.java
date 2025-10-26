package com.studentmanagement.test;

import com.studentmanagement.util.DatabaseConnection;

/**
 * Simple test to verify database connection
 */
public class DatabaseTest {
    public static void main(String[] args) {
        System.out.println("Testing database connection...");
        
        DatabaseConnection dbConnection = DatabaseConnection.getInstance();
        
        if (dbConnection.testConnection()) {
            System.out.println("✅ Database connection successful!");
        } else {
            System.out.println("❌ Database connection failed!");
        }
    }
}
