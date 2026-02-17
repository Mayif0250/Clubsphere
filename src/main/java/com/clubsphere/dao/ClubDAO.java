package com.clubsphere.dao;

import com.clubsphere.util.DBUtil;
import java.sql.*;
import java.util.*;

public class ClubDAO {

    public List<Map<String, Object>> getAllClubs() {
        List<Map<String, Object>> clubs = new ArrayList<>();

        String sql = """
            SELECT 
                c.id,
                c.club_name,
                c.category,
                c.status,
                u.rgukt_email as Email,
                COALESCE(CONCAT(u.first_name, ' ', u.last_name), '') AS leader_name,
                (SELECT COUNT(*) FROM club_members cm WHERE cm.club_id = c.id) AS member_count
            FROM clubs c
            LEFT JOIN users u ON u.club_id = c.id AND u.role = 'leader'
            ORDER BY c.club_name;
        """;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> club = new HashMap<>();
                club.put("id", rs.getInt("id"));
                club.put("club_name", rs.getString("club_name"));
                club.put("category", rs.getString("category"));
                club.put("status", rs.getString("status"));
                club.put("leader_name", rs.getString("leader_name"));
                club.put("Email", rs.getString("Email"));
                club.put("member_count", rs.getInt("member_count"));
                clubs.add(club);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return clubs;
    }
}
