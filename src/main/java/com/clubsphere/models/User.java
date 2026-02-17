package com.clubsphere.models;

import java.sql.Timestamp;

public class User {
    private int id;
    private String studentId;
    private String firstName;
    private String lastName;
    private String rguktEmail;
    private String phoneNumber;
    private String branch;
    private String section;
    private String academicYear;
    private String bio;
    private String interests;
    private String role;
    private String profileImage;
    private String registrationDate;
    private int clubId;

    // --- Getters and Setters ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getRguktEmail() { return rguktEmail; }
    public void setRguktEmail(String rguktEmail) { this.rguktEmail = rguktEmail; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getBranch() { return branch; }
    public void setBranch(String branch) { this.branch = branch; }

    public String getSection() { return section; }
    public void setSection(String section) { this.section = section; }

    public String getAcademicYear() { return academicYear; }
    public void setAcademicYear(String academicYear) { this.academicYear = academicYear; }

    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }

    public String getInterests() { return interests; }
    public void setInterests(String interests) { this.interests = interests; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getProfileImage() { return profileImage; }
    public void setProfileImage(String profileImage) { this.profileImage = profileImage; }

    public String getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(String registrationDate) { this.registrationDate = registrationDate; }

    public int getClubId() { return clubId; }
    public void setClubId(int clubId) { this.clubId = clubId; }
	public void setJoinDate(Timestamp timestamp) {
		// TODO Auto-generated method stub
		
	}
	public String getPassword() {
		// TODO Auto-generated method stub
		return null;
	}
	public void setClubName(String string) {
		// TODO Auto-generated method stub
		
	}
}
