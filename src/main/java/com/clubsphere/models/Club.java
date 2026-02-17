package com.clubsphere.models;

public class Club {
    private int id;
    private String clubName;
    private String category;
    private String status;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getClubName() { return clubName; }
    public void setClubName(String clubName) { this.clubName = clubName; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
