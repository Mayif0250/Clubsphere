package com.clubsphere.dao;

import com.clubsphere.models.User;
import com.clubsphere.util.DBUtil;
import java.sql.*;
import java.util.*;

public class UserDAO {

    // ✅ Fetch all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setStudentId(rs.getString("Student_ID"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setRguktEmail(rs.getString("rgukt_email"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setBranch(rs.getString("branch"));
                user.setSection(rs.getString("section"));
                user.setAcademicYear(rs.getString("academic_year"));
                user.setBio(rs.getString("bio"));
                user.setInterests(rs.getString("interests"));
                user.setRole(rs.getString("role"));
                user.setProfileImage(rs.getString("profile_image"));
                user.setRegistrationDate(rs.getString("registration_date"));
                user.setClubId(rs.getInt("club_id"));

                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    // ✅ Delete a user
    public boolean deleteUser(int userId) {
        String query = "DELETE FROM users WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
 // ✅ Add a new user
    public boolean addUser(User user) {
        String sql = "INSERT INTO users (Student_ID, first_name, last_name, rgukt_email, phone_number, branch, section, academic_year, bio, interests, role, profile_image, club_id, login_password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getStudentId());
            ps.setString(2, user.getFirstName());
            ps.setString(3, user.getLastName());
            ps.setString(4, user.getRguktEmail());
            ps.setString(5, user.getPhoneNumber());
            ps.setString(6, user.getBranch());
            ps.setString(7, user.getSection());
            ps.setString(8, user.getAcademicYear());
            ps.setString(9, user.getBio());
            ps.setString(10, user.getInterests());
            ps.setString(11, user.getRole());
            ps.setString(12, user.getProfileImage());
            ps.setInt(13, user.getClubId());
            ps.setString(14, user.getPassword() != null ? user.getPassword() : "rgukt@123"); // fallback

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Map<String, String>> getClubLeaders() {
        List<Map<String, String>> leaders = new ArrayList<>();
        String query = "SELECT u.id, CONCAT(u.first_name, ' ', u.last_name) AS name, " +
                       "u.rgukt_email AS email, u.phone_number AS contact, " +
                       "u.role, u.profile_image AS avatar, c.club_name " +
                       "FROM users u " +
                       "JOIN clubs c ON u.club_id = c.id " +
                       "WHERE u.role = 'leader'";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, String> leader = new HashMap<>();
                leader.put("id", String.valueOf(rs.getInt("id")));
                leader.put("name", rs.getString("name"));
                leader.put("email", rs.getString("email"));
                leader.put("contact", rs.getString("contact"));
                leader.put("role", rs.getString("role"));
                leader.put("avatar", rs.getString("avatar"));
                leader.put("club_name", rs.getString("club_name"));
                leaders.add(leader);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return leaders;
    }






    // ✅ Update a user (you can expand this)
    public boolean updateUser(User user) {
        String query = "UPDATE users SET first_name=?, last_name=?, rgukt_email=?, phone_number=?, branch=?, section=?, academic_year=?, role=? WHERE id=?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getRguktEmail());
            ps.setString(4, user.getPhoneNumber());
            ps.setString(5, user.getBranch());
            ps.setString(6, user.getSection());
            ps.setString(7, user.getAcademicYear());
            ps.setString(8, user.getRole());
            ps.setInt(9, user.getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
