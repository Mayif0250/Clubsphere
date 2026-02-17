<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clubsphere - Announcements</title>
    <link rel="stylesheet" href="CSS/student_notifications.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🎓 Student Dashboard - Announcements</h1>
            <p>Stay updated with the latest news and events from all college clubs</p>
        </div>

        <div class="controls">
            <div class="filter-section">
    <label for="filterType">Filter by Type:</label>
    <select id="filterType">
        <option value="all">All</option>
        <option value="announcement">Announcements</option>
        <option value="event">Events</option>
    </select>

    <label for="filterClub">Filter by Club:</label>
    <select id="filterClub">
        <option value="all">All Clubs</option>
    </select>

    <button id="applyFilterBtn">Apply Filter</button>
</div>


            <div class="student-info">
                <span class="welcome-text">👋 Welcome, Student!</span>
            </div>
        </div>

        <div class="announcements-grid" id="notifications-container">

            <!-- Sample announcements will be populated by JavaScript -->
        </div>

        <div class="empty-state" id="emptyState" style="display: none;">
            <h3>No announcements available</h3>
            <p>Check back later for updates from your college clubs!</p>
        </div>
    </div>

    <!-- Modal for creating/editing announcements -->
    <div id="announcementModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="modalTitle">Create New Announcement</h2>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <form id="announcementForm">
                <div class="form-group">
                    <label for="clubName">Club Name *</label>
                    <select id="clubName" required>
                        <option value="">Select a club...</option>
                        <option value="English Communication">English Communication Club</option>
                        <option value="Graphic Designing">Graphic Designing Club</option>
                        <option value="Coding Club">Coding Club</option>
                        <option value="Culturals Club">Culturals Club</option>
                        <option value="Sports Club">Sports Club</option>
                        <option value="Publishing Club">Publishing Club</option>
                        <option value="Arts Club">Arts Club</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="announcementTitle">Announcement Title *</label>
                    <input type="text" id="announcementTitle" placeholder="Enter announcement title..." required>
                </div>

                <div class="form-group">
                    <label for="announcementType">Type of Announcement *</label>
                    <select id="announcementType" required>
                        <option value="">Select type...</option>
                        <option value="Event">Event</option>
                        <option value="Meeting">Meeting</option>
                        <option value="Workshop">Workshop</option>
                        <option value="Competition">Competition</option>
                        <option value="Recruitment">Recruitment</option>
                        <option value="General">General</option>
                        <option value="Urgent">Urgent</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="priority">Priority Level</label>
                    <select id="priority">
                        <option value="low">Low</option>
                        <option value="medium">Medium</option>
                        <option value="high">High</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="description">Description *</label>
                    <textarea id="description" placeholder="Enter detailed description..." required></textarea>
                </div>

                <div class="form-group">
                    <label for="posterUrl">Poster URL (Optional)</label>
                    <input type="url" id="posterUrl" placeholder="https://example.com/poster.jpg">
                </div>

                <button type="submit" class="submit-btn" id="submitBtn">Create Announcement</button>
            </form>
        </div>
    </div>

    <script src="JS/student_notification.js"></script>
</body>
</html>