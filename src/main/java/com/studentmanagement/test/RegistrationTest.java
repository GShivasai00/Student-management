package com.studentmanagement.test;

import com.studentmanagement.dao.UserDAO;
import com.studentmanagement.model.User;
import com.studentmanagement.util.DatabaseConnection;

/**
 * Test registration functionality
 */
public class RegistrationTest {
    public static void main(String[] args) {
        System.out.println("Testing Registration Functionality...");
        System.out.println("=====================================");
        
        // Test database connection
        System.out.println("1. Testing database connection...");
        DatabaseConnection dbConnection = DatabaseConnection.getInstance();
        
        if (!dbConnection.testConnection()) {
            System.out.println("❌ Database connection failed!");
            System.out.println("Please fix database connection before testing registration.");
            return;
        }
        
        System.out.println("✅ Database connection successful!");
        
        // Test UserDAO
        System.out.println("\n2. Testing UserDAO...");
        UserDAO userDAO = new UserDAO();
        
        // Test username existence check
        System.out.println("3. Testing username existence check...");
        boolean usernameExists = userDAO.usernameExists("admin");
        System.out.println("Username 'admin' exists: " + usernameExists);
        
        // Test email existence check
        System.out.println("4. Testing email existence check...");
        boolean emailExists = userDAO.emailExists("admin@studentmanagement.com");
        System.out.println("Email 'admin@studentmanagement.com' exists: " + emailExists);
        
        // Test user creation
        System.out.println("\n5. Testing user creation...");
        try {
            User testUser = new User("testuser", "test@example.com", "hashedpassword");
            boolean created = userDAO.createUser(testUser);
            
            if (created) {
                System.out.println("✅ Test user created successfully!");
                
                // Clean up - delete test user
                System.out.println("6. Cleaning up test user...");
                User createdUser = userDAO.getUserByUsername("testuser");
                if (createdUser != null) {
                    userDAO.deleteUser(createdUser.getId());
                    System.out.println("✅ Test user deleted successfully!");
                }
            } else {
                System.out.println("❌ Failed to create test user!");
            }
        } catch (Exception e) {
            System.out.println("❌ Error creating test user: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("\n=====================================");
        System.out.println("Registration test completed!");
        System.out.println("If all tests passed, registration should work in your application.");
    }
}
