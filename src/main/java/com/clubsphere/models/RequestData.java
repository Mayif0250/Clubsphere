package com.clubsphere.models;

import java.sql.Timestamp;

public class RequestData {
    private int id;
    private String studentId;
    private String studentName;
    private String clubName;
    private String status;
    private Timestamp requestedAt;

    public RequestData(int id, String studentId, String studentName, String clubName, String status, Timestamp requestedAt) {
        this.id = id;
        this.studentId = studentId;
        this.studentName = studentName;
        this.clubName = clubName;
        this.status = status;
        this.requestedAt = requestedAt;
    }

    public int getId() { return id; }
    public String getStudentId() { return studentId; }
    public String getStudentName() { return studentName; }
    public String getClubName() { return clubName; }
    public String getStatus() { return status; }
    public Timestamp getRequestedAt() { return requestedAt; }
}
