package com.clubsphere.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.*;
import java.util.*; // for List, Map, ArrayList, HashMap
import java.io.*;

public class DBUtil {
    private static final Properties config = new Properties();

    static {
        try (InputStream input = DBUtil.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (input == null) {
                System.out.println("Sorry, unable to find config.properties");
            } else {
                config.load(input);
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure you have mysql-connector-java .jar
        return DriverManager.getConnection(
                config.getProperty("db.url"),
                config.getProperty("db.user"),
                config.getProperty("db.password"));
    }

    // // ================= Step 1: Fetch all clubs =================
    // public static List<Map<String, Object>> getAllClubs() {
    // List<Map<String,Object>> clubs = new ArrayList<>();
    // String sql = "SELECT * FROM clubs"; // Replace 'clubs' with your actual table
    // name
    //
    // Connection conn=null;
    // Statement stmt=null;
    // ResultSet rs=null;
    // try{
    // conn = getConnection();
    // stmt = conn.createStatement();
    // rs = stmt.executeQuery(sql);
    //
    // while (rs.next()) {
    // Map<String,Object> club = new HashMap<>();
    // club.put("id", rs.getInt("id"));
    // club.put("name", rs.getString("club_name"));
    // club.put("category", rs.getString("category"));
    // club.put("status", rs.getString("status"));
    // club.put("members", rs.getInt("member_count"));
    // clubs.add(club);
    // }
    // } catch (Exception e) {
    // e.printStackTrace();
    // }finally {
    // try { if (rs != null) rs.close(); } catch (Exception e) {}
    // try { if (stmt != null) stmt.close(); } catch (Exception e) {}
    // try { if (conn != null) conn.close(); } catch (Exception e) {}
    // }
    //
    // return clubs;
    // }
}
