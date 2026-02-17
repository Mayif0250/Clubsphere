# ClubSphere 🌐

A dynamic web application for managing club activities, built with Java Servlets, JSP, and MySQL.

## Prerequisites 🛠️
*   **Java JDK 21**
*   **Apache Tomcat 9.0**
*   **MySQL Server**
*   **Eclipse IDE for Enterprise Java** (Recommended)

## Setup Guide 🚀

### 1. Database Setup
1.  Open your MySQL Workbench or Command Line.
2.  Create a database named `practice`.
    ```sql
    CREATE DATABASE practice;
    ```
3.  Import the necessary tables (You may need to inspect the models/DAOs to infer the schema if a SQL dump is not provided).

### 2. Configure Application
1.  Clone the repository:
    ```bash
    git clone https://github.com/Mayif0250/Clubsphere.git
    ```
2.  Open `src/main/java/com/clubsphere/util/DBUtil.java`.
3.  Update the database credentials:
    ```java
    return DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/practice",
        "root",         // Your MySQL Username
        "YOUR_PASSWORD" // Your MySQL Password
    );
    ```

### 3. Run in Eclipse
1.  **File** > **Open Projects from File System...** > Select the `Clubsphere` folder.
2.  Right-click the project > **Build Path** > **Configure Build Path** > **Libraries**.
    *   Ensure JRE System Library is set to Java 21.
    *   Ensure Apache Tomcat v9.0 is in the classpath.
3.  Right-click the project > **Run As** > **Run on Server**.
4.  Select your Tomcat v9.0 server and finish.
5.  Access at: `http://localhost:8080/ClubSphere`

## Project Structure
*   **src/main/java**: Backend logic (Servlets, DAOs, Models).
*   **src/main/webapp**: Frontend (JSP, HTML, CSS, JS).
