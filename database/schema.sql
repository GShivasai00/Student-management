-- Student Management System Database Schema
-- Run this script to create the database and tables

CREATE DATABASE IF NOT EXISTS student_management;
USE student_management;

-- Users table for authentication
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Students table
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    date_of_birth DATE,
    address TEXT,
    course VARCHAR(100),
    year_of_study INT,
    gpa DECIMAL(3,2),
    status ENUM('active', 'inactive', 'graduated') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert default admin user (password: admin123)
INSERT INTO users (username, email, password, role) VALUES 
('admin', 'admin@studentmanagement.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'admin')
ON DUPLICATE KEY UPDATE username=username;

-- Insert sample students
INSERT INTO students (student_id, first_name, last_name, email, phone, date_of_birth, address, course, year_of_study, gpa, status) VALUES
('STU001', 'John', 'Doe', 'john.doe@email.com', '1234567890', '2000-01-15', '123 Main St, City', 'Computer Science', 3, 3.75, 'active'),
('STU002', 'Jane', 'Smith', 'jane.smith@email.com', '0987654321', '1999-05-20', '456 Oak Ave, Town', 'Mathematics', 4, 3.90, 'active'),
('STU003', 'Mike', 'Johnson', 'mike.johnson@email.com', '1122334455', '2001-03-10', '789 Pine Rd, Village', 'Physics', 2, 3.25, 'active'),
('STU004', 'Sarah', 'Wilson', 'sarah.wilson@email.com', '5566778899', '1998-12-05', '321 Elm St, City', 'Chemistry', 4, 3.80, 'graduated'),
('STU005', 'David', 'Brown', 'david.brown@email.com', '9988776655', '2000-08-18', '654 Maple Dr, Town', 'Biology', 3, 3.45, 'active');
