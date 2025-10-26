# MySQL Database Setup Guide

## Option 1: XAMPP (Recommended - Easiest)

1. **Download XAMPP** from: https://www.apachefriends.org/download.html
2. **Install XAMPP** (includes MySQL, Apache, PHP)
3. **Start XAMPP Control Panel**
4. **Start MySQL service** in XAMPP
5. **Open phpMyAdmin** (http://localhost/phpmyadmin)
6. **Create database** named `student_management`
7. **Import schema** using the `database/schema.sql` file

## Option 2: MySQL Server

1. **Download MySQL** from: https://dev.mysql.com/downloads/mysql/
2. **Install MySQL Server** with these settings:
   - Root password: `rootpassword123`
   - Create user: `studentuser` with password: `studentpass123`
3. **Create database** named `student_management`
4. **Import schema** using the `database/schema.sql` file

## Option 3: MySQL Workbench

1. **Download MySQL Workbench** from: https://dev.mysql.com/downloads/workbench/
2. **Install MySQL Workbench** (includes MySQL server)
3. **Start MySQL service**
4. **Create database** named `student_management`
5. **Import schema** using the `database/schema.sql` file

## Database Configuration

After installing MySQL, update the connection settings in:
`src/main/java/com/studentmanagement/util/DatabaseConnection.java`

### Default Settings:
- **Host**: localhost
- **Port**: 3306
- **Database**: student_management
- **Username**: studentuser
- **Password**: studentpass123

### For XAMPP (if using default settings):
- **Username**: root
- **Password**: (empty)

## Schema Import

1. **Open MySQL client** (phpMyAdmin, MySQL Workbench, or command line)
2. **Create database**: `CREATE DATABASE student_management;`
3. **Select database**: `USE student_management;`
4. **Import schema**: Run the contents of `database/schema.sql`

## Testing Connection

After setup, test the connection by running your application. The system will:
- Connect to MySQL database
- Use real data instead of demo mode
- Provide full CRUD functionality

## Troubleshooting

### Connection Issues:
- Ensure MySQL service is running
- Check firewall settings
- Verify username/password
- Confirm database exists

### Port Conflicts:
- Default MySQL port: 3306
- Change port if needed in connection string

### Authentication:
- Default admin user: `admin` / `admin123`
- Register new users through the application
