# Student Management System

A comprehensive web application for managing student records built with Java Servlets, JSP, and MySQL.

## Features

- **Home Page**: Welcome page with system overview
- **Authentication**: Login and registration system with session management
- **CRUD Operations**: Complete Create, Read, Update, Delete functionality for students
- **Dashboard**: Statistics and reports with visual data representation
- **Search & Filter**: Advanced search functionality for finding students
- **Responsive Design**: Modern, clean UI that works on all devices

## Technology Stack

- **Backend**: Java Servlets
- **Frontend**: JSP (JavaServer Pages), HTML5, CSS3
- **Database**: MySQL
- **Build Tool**: Maven
- **Server**: Apache Tomcat

## Prerequisites

- Java 11 or higher
- Apache Tomcat 9.0 or higher
- MySQL 8.0 or higher
- Maven 3.6 or higher

## Installation & Setup

### 1. Database Setup

1. Install MySQL and start the service
2. Create a new database:
   ```sql
   CREATE DATABASE student_management;
   ```
3. Run the SQL script to create tables and insert sample data:
   ```bash
   mysql -u root -p student_management < database/schema.sql
   ```

### 2. Configuration

1. Update the database connection settings in `src/main/java/com/studentmanagement/util/DatabaseConnection.java`:
   ```java
   private static final String DB_PASSWORD = "your_mysql_password";
   ```

### 3. Build and Deploy

1. Clone or download the project
2. Navigate to the project directory
3. Build the project:
   ```bash
   mvn clean package
   ```
4. Deploy the generated WAR file to your Tomcat server:
   - Copy `target/student-management-system.war` to `$TOMCAT_HOME/webapps/`
   - Start Tomcat server

### 4. Access the Application

1. Open your web browser
2. Navigate to: `http://localhost:8080/student-management-system/`
3. Use the demo credentials to login:
   - **Username**: admin
   - **Password**: admin123

## Project Structure

```
student-management-system/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── studentmanagement/
│       │           ├── dao/           # Data Access Objects
│       │           ├── model/         # Entity classes
│       │           ├── servlet/        # Servlet controllers
│       │           └── util/          # Utility classes
│       └── webapp/
│           ├── css/                   # Stylesheets
│           ├── WEB-INF/
│           │   └── web.xml            # Web application configuration
│           └── *.jsp                  # JSP pages
├── database/
│   └── schema.sql                     # Database schema
├── pom.xml                           # Maven configuration
└── README.md                         # This file
```

## Usage Guide

### 1. Authentication
- **Login**: Use existing credentials or register a new account
- **Registration**: Create a new user account with username, email, and password
- **Session Management**: Automatic logout after 30 minutes of inactivity

### 2. Student Management
- **Add Student**: Click "Add New Student" to create a new student record
- **View Students**: Browse all students in a paginated table
- **Edit Student**: Click "Edit" to modify student information
- **Delete Student**: Click "Delete" to remove a student (with confirmation)
- **Search**: Use the search bar to find students by name, ID, or email

### 3. Dashboard
- **Statistics**: View total students, active/inactive counts, and percentages
- **Quick Actions**: Access common functions directly from the dashboard
- **Recent Students**: See the latest added students

## Database Schema

### Users Table
- `id`: Primary key
- `username`: Unique username
- `email`: Unique email address
- `password`: Hashed password
- `role`: User role (admin/user)
- `created_at`, `updated_at`: Timestamps

### Students Table
- `id`: Primary key
- `student_id`: Unique student identifier
- `first_name`, `last_name`: Student name
- `email`: Student email
- `phone`: Contact number
- `date_of_birth`: Birth date
- `address`: Student address
- `course`: Course of study
- `year_of_study`: Academic year
- `gpa`: Grade point average
- `status`: Student status (active/inactive/graduated)
- `created_at`, `updated_at`: Timestamps

## Security Features

- Password hashing using SHA-256
- Session-based authentication
- Input validation and sanitization
- SQL injection prevention with prepared statements
- XSS protection

## Browser Support

- Chrome 70+
- Firefox 65+
- Safari 12+
- Edge 79+

## Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Verify MySQL is running
   - Check database credentials in DatabaseConnection.java
   - Ensure the database exists

2. **Build Errors**
   - Verify Java 11+ is installed
   - Check Maven installation
   - Ensure all dependencies are resolved

3. **Deployment Issues**
   - Verify Tomcat is running
   - Check WAR file deployment
   - Review Tomcat logs for errors

### Logs

Check the following locations for error logs:
- Tomcat logs: `$TOMCAT_HOME/logs/`
- Application logs: Console output during development

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue in the repository
- Check the troubleshooting section
- Review the code documentation

## Future Enhancements

- Email notifications
- File upload for student photos
- Advanced reporting features
- REST API endpoints
- Mobile app integration
- Bulk import/export functionality
