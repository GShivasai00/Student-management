package com.studentmanagement.servlet;

import com.studentmanagement.dao.UserDAO;
import com.studentmanagement.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Servlet for handling user login
 */
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to login page
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate input
        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        try {
            // Get user from database
            User user = userDAO.getUserByUsername(username);

            System.out.println("Login attempt - Username: " + username);
            System.out.println("User found: " + (user != null));
            if (user != null) {
                System.out.println("Stored password: " + user.getPassword());
                System.out.println("Input password: " + password);
            }

            if (user != null && verifyPassword(password, user.getPassword())) {
                // Login successful
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("username", user.getUsername());
                session.setAttribute("role", user.getRole());

                System.out.println("Login successful for user: " + username);
                // Redirect to dashboard
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                // Login failed
                System.out.println("Login failed for user: " + username);
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.err.println("Login error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An error occurred during login");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    /**
     * Verify password against stored hash
     */
    private boolean verifyPassword(String inputPassword, String storedPassword) {
        // For demo mode, use simple string comparison
        if (storedPassword.equals("admin123") || storedPassword.equals("user123")) {
            return inputPassword.equals(storedPassword);
        }

        // For demo mode users, also check plain text passwords
        if (inputPassword.equals("admin123") && storedPassword.equals("admin123")) {
            return true;
        }
        if (inputPassword.equals("user123") && storedPassword.equals("user123")) {
            return true;
        }

        try {
            String hashedInput = hashPassword(inputPassword);
            return hashedInput.equals(storedPassword);
        } catch (NoSuchAlgorithmException e) {
            System.err.println("Password verification error: " + e.getMessage());
            return false;
        }
    }

    /**
     * Hash password using SHA-256
     */
    private String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes());
        StringBuilder hexString = new StringBuilder();

        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }

        return hexString.toString();
    }
}
