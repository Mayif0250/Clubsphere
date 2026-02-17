<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String branch = (String) request.getAttribute("branch");
    if (branch == null) {
        branch = ""; // to avoid null pointer
    }

    String academic_year = (String) request.getAttribute("academic_year");
    if (academic_year == null) {
        academic_year = "";
    }

    String section = (String) request.getAttribute("section");
    if (section == null) {
        section = "";
    }
%>

    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Club Sphere - Profile Setup</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
     <link rel="stylesheet" href="CSS/profile_page.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <a href="homepage">
            <button class="back-button">
                <i class="fas fa-arrow-left"></i>
                Back
            </button>
            </a>
            <div class="header-content">
                <h1>Club Sphere Profile</h1>
                <p>Complete your professional profile to join our community</p>
            </div>
        </div>
        
        <form action="profile" method="post" class="profile-form" id="profileForm" enctype="multipart/form-data">
            <div class="profile-image-container">
                <div class="profile-image-wrapper">
                    <div class="profile-image-preview" id="imagePreview">
                        <img src="data:image/jpeg;base64,${profileImage}" alt="Profile Picture" width="150" height="150">
                    </div>
                    <div class="camera-overlay" onclick="document.getElementById('profileImage').click()">
                        <i class="fas fa-camera"></i>
                    </div>
                </div>
                <div class="image-upload-info">
                    <h3>Profile Photo</h3>
                    <p>Upload a professional headshot that clearly shows your face. Recommended size: 400x400px. This photo will be visible to other club members.</p>
                    <div class="file-input-wrapper">
                        <input type="file" id="profileImage" name="profile_image" accept="image/*">
                        <label for="profileImage" class="file-input-label">
                            <i class="fas fa-cloud-upload-alt"></i> Upload Photo
                        </label>
                    </div>
                </div>
            </div>
            
            <div class="form-section">
                <h2 class="section-title">Personal Information</h2>
                <div class="form-grid">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="student_Id">Student ID <span class="required">*</span></label>
                            <input type="text" id="student_Id" value="${Student_ID}" name="Student_ID" required placeholder="e.g., RO210XXX">
                        </div>
                        
                        <div class="form-group">
                            <label for="academic_Year">Academic Year <span class="required">*</span></label>
                            <select id="academic_Year" name="academic_year" required>
                                <option value="">Select Year</option>
                                <option value="1st year" <%= "1st year".equals(academic_year) ? "selected" : "" %>>1st Year</option>
                                <option value="2nd year" <%= "2nd year".equals(academic_year) ? "selected" : "" %>>2nd Year</option>
                                <option value="3" <%= "3".equals(academic_year) ? "selected" : "" %>>3rd Year</option>
                                <option value="4th year" <%= "4th year".equals(academic_year) ? "selected" : "" %>>4th Year</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="first_name">First Name <span class="required">*</span></label>
                            <input type="text" id="first_name" value="${first_name}" name="first_name" required placeholder="Enter your first name">
                        </div>
                        
                        <div class="form-group">
                            <label for="last_name">Last Name <span class="required">*</span></label>
                            <input type="text" id="last_name" value="${last_name}" name="last_name" required placeholder="Enter your last name">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="rgukt_email">Email <span class="required">*</span></label>
                            <input type="email" id="rgukt_email" value="${rgukt_email}" name="rgukt_email" required placeholder="your.id@rgukt.ac.in">
                        </div>
                        
                        <div class="form-group">
                            <label for="phone_number">Phone Number <span class="required">*</span></label>
                            <input type="tel" id="phone_number" value="${phone_number}" name="phone_number" required placeholder="10-digit mobile number">
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="form-section">
                <h2 class="section-title">Academic Information</h2>
                <div class="form-grid">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="branch">Branch <span class="required">*</span></label>
                            <select id="branch" name="branch" required>
                                <option value="">Select Branch</option>
                                <option value="CSE"  <%= "CSE".equals(branch) ? "selected" : "" %> >Computer Science Engineering</option>
                                <option value="ECE" <%= "ECE".equals(branch) ? "selected" : "" %>>Electronics & Communication Engineering</option>
                                <option value="MECH" <%= "MECH".equals(branch) ? "selected" : "" %>>Mechanical Engineering</option>
                                <option value="CIVIL" <%= "CIVIL".equals(branch) ? "selected" : "" %>>Civil Engineering</option>
                                <option value="CHEM" <%= "CHEM".equals(branch) ? "selected" : "" %>>Chemical Engineering</option>
                                <option value="EEE" <%= "EEE".equals(branch) ? "selected" : "" %>>Electrical & Electronics Engineering</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="section">Section <span class="required">*</span></label>
                            <input type="text" id="section" value="${section}" name="section" required placeholder="e.g., A, B, C">
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="form-section">
                <h2 class="section-title">Professional Profile</h2>
                <div class="form-grid">
                    <div class="form-group">
                        <label for="interests">Interests & Skills</label>
                        <textarea id="interests" name="interests" placeholder="List your technical skills, interests, and areas of expertise...">${interests}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="bio">About</label>
                        <textarea id="bio" name="bio" placeholder="Write a brief professional summary about yourself, your goals, and what you hope to contribute to Club Sphere...">${bio}</textarea>
                    </div>
                </div>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn" id="saveBtn" >
                    <i class="fas fa-save"></i> Save Profile
                </button>
            </div>
        </form>
    </div>

    <div class="notification" id="notification">
        <i class="fas fa-check-circle"></i> Profile saved successfully!
    </div>

    <script>
        // Back button functionality
        function goBack() {
            window.history.back();
        }

        // Profile image preview
        document.getElementById('profileImage').addEventListener('change', function(e) {
            const file = e.target.files[0];
            const preview = document.getElementById('imagePreview');
            
            if (file) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    preview.innerHTML = `<img src="${e.target.result}" alt="Profile Preview">`;
                }
                
                reader.readAsDataURL(file);
            } else {
                preview.innerHTML = '<i class="fas fa-user"></i>';
            }
        });

        // Form submission
        document.getElementById("saveBtn").addEventListener("click", function () {
    const profileData = {
        firstName: document.getElementById('first_name').value,
        lastName: document.getElementById('last_name').value,
        email: document.getElementById('rgukt_email').value,
        phone: document.getElementById('phone_number').value,
       /* graduationYear: document.getElementById('graduationYear').value, major: document.getElementById('major').value, minor: document.getElementById('minor').value,*/
        Academic Year: document.getElementById('academic_year').value,
        interests: document.getElementById('interests').value,
        bio: document.getElementById('bio').value
    };

    .then(res => res.text())
    .then(data => {
        alert("Profile updated successfully!");
    })
    .catch(err => console.error("Error:", err));
});

    </script>
</body>
</html>