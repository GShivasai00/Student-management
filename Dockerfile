# Dockerfile for Student Management System
FROM tomcat:9.0-jdk11

# Copy the webapp to Tomcat
COPY src/main/webapp/ /usr/local/tomcat/webapps/student-management-system/

# Copy compiled classes (after Maven build)
COPY target/classes/ /usr/local/tomcat/webapps/student-management-system/WEB-INF/classes/

# Copy dependencies
COPY target/lib/ /usr/local/tomcat/webapps/student-management-system/WEB-INF/lib/

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
