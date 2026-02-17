<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechXcel Club Leader Dashboard</title>
    <link rel="stylesheet" href="CSS/leader_dashboard.css">
</head>
<body data-club-id="<%= session.getAttribute("clubId") %>"
      data-context-path="<%= request.getContextPath() %>">
    <div class="dashboard-container">
        <!-- Mobile Menu Toggle -->
        <div class="mobile-menu-toggle" onclick="toggleMobileSidebar()">
            <svg class="menu-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
            </svg>
        </div>

        <!-- Sidebar Overlay for Mobile -->
        <div class="sidebar-overlay" onclick="toggleMobileSidebar()"></div>

        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="logo">CS</div>
                <div class="club-name">${clubName}</div>
            </div>
            <div class="toggle-sidebar" onclick="toggleSidebar()">
                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
                </svg>
            </div>
            <nav class="sidebar-menu">
                <div class="menu-item active" data-section="dashboard">
                    <svg class="menu-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path>
                    </svg>
                    <span class="menu-text">Dashboard</span>
                </div>
                <div class="menu-item" data-section="events">
                    <svg class="menu-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                    </svg>
                    <span class="menu-text">Events</span>
                </div>
                <div class="menu-item" data-section="members">
                    <svg class="menu-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
                    </svg>
                    <span class="menu-text">Members</span>
                </div>
                <div class="menu-item" data-section="announcements">
                    <svg class="menu-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5.882V19.24a1.76 1.76 0 01-3.417.592l-2.147-6.15M18 13a3 3 0 100-6M5.436 13.683A4.001 4.001 0 017 6h1.832c4.1 0 7.625-1.234 9.168-3v14c-1.543-1.766-5.067-3-9.168-3H7a3.988 3.988 0 01-1.564-.317z"></path>
                    </svg>
                    <span class="menu-text">Announcements</span>
                </div>
                <div class="menu-item" data-section="settings">
                    <svg class="menu-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                    </svg>
                    <span class="menu-text">Settings</span>
                </div>
                <div class="menu-item" onclick="logout()">
                    <svg class="menu-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                    </svg>
                    
                    <span class="menu-text">Logout</span>
                    
                </div>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Dashboard Section -->
            <section class="content-section active" id="dashboard">
                <div class="section-header">
                    <h1 class="section-title">Welcome, Club Leader 👋</h1>
                    <p class="section-subtitle">Here's what's happening with your club today.</p>
                </div>

                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon members">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
                            </svg>
                        </div>
                        <div class="stat-value">42</div>
                        <div class="stat-label">Total Members</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon events">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                            </svg>
                        </div>
                        <div class="stat-value">8</div>
                        <div class="stat-label">Upcoming Events</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon announcements">
                            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5.882V19.24a1.76 1.76 0 01-3.417.592l-2.147-6.15M18 13a3 3 0 100-6M5.436 13.683A4.001 4.001 0 017 6h1.832c4.1 0 7.625-1.234 9.168-3v14c-1.543-1.766-5.067-3-9.168-3H7a3.988 3.988 0 01-1.564-.317z"></path>
                            </svg>
                        </div>
                        <div class="stat-value">5</div>
                        <div class="stat-label">Recent Announcements</div>
                    </div>
                </div>

                <div class="table-container">
                    <div class="table-header">
                        <h3 class="table-title">Recent Activities</h3>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>Activity</th>
                                <th>User</th>
                                <th>Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>New member joined</td>
                                <td>Alex Johnson</td>
                                <td>Today, 2:30 PM</td>
                                <td><span class="status-badge active">Completed</span></td>
                            </tr>
                            <tr>
                                <td>Event registration</td>
                                <td>Sarah Williams</td>
                                <td>Today, 11:45 AM</td>
                                <td><span class="status-badge active">Completed</span></td>
                            </tr>
                            <tr>
                                <td>Announcement posted</td>
                                <td>Admin</td>
                                <td>Yesterday, 4:20 PM</td>
                                <td><span class="status-badge active">Completed</span></td>
                            </tr>
                            <tr>
                                <td>Event created</td>
                                <td>Mike Chen</td>
                                <td>Yesterday, 10:15 AM</td>
                                <td><span class="status-badge upcoming">Upcoming</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- ✅ Events Section -->
<section class="content-section" id="events">
    <div class="section-header">
        <h1 class="section-title">Events</h1>
        <p class="section-subtitle">Manage your club events and activities</p>
    </div>

    <div class="table-container">
        <div class="table-header">
            <h3 class="table-title">Upcoming Events</h3>
            <button class="btn btn-primary" onclick="openEventModal()">
   					<svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24"
        				xmlns="http://www.w3.org/2000/svg">
        				<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
    				</svg>
   				 Create New Event
			</button>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="events-table-body">
                <!-- ⚡ Events will be loaded dynamically here -->
            </tbody>
        </table>
    </div>
</section>
            
            <!-- Members Section -->
            <section class="content-section" id="members">
                <div class="section-header">
                    <h1 class="section-title">Members</h1>
                    <p class="section-subtitle">Manage your club members</p>
                </div>
				<div class="search-container">
				<a href="club_members_management.jsp">
                     <button class="btn btn-primary">
                            <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                            </svg>
                            View all Members
                  </button>
                 </a>
                 </div>
                <div class="table-container">
                    <div class="table-header">
                        <h3 class="table-title">All Members</h3>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Role</th>
                                <th>Branch & Section</th>
                                <th>Joined-Date</th>
                            </tr>
                        </thead>
                        <tbody id="membersTableBody"></tbody>
                    </table>
                </div>
            </section>

            <!-- Announcements Section -->
            <section class="content-section" id="announcements">
    <div class="section-header">
        <h1 class="section-title">Announcements</h1>
        <p class="section-subtitle">Latest updates and messages</p>
    </div>

    <!-- Create Announcement Form (Visible to Leaders/Admins) -->
    <div class="announcement-form-card">
        <h3>Create New Announcement</h3>
        <form id="announcementForm" method="post">
    <div class="form-group">
        <label for="announcementTitle">Title</label>
        <input type="text" id="announcementTitle" name="title" required />
    </div>

    <div class="form-group">
        <label for="announcementMessage">Message</label>
        <textarea id="announcementMessage" name="message" rows="4" required></textarea>
    </div>

    <!-- Hidden fields -->
    <input type="hidden" id="targetType" name="target_type" value="specific" />
    <input type="hidden" id="targetClubId" name="target_club_id" />

    <button type="submit" class="btn btn-primary">Send Announcement</button>
</form>

        <p id="announcementStatus" class="status-text"></p>
    </div>

    <hr class="divider" />

    <!-- Display Section -->
    <div class="settings-section">
        <h3 class="settings-title">Recent Announcements</h3>
        <div id="announcements-list" class="announcements-list"></div>
    </div>
</section>
                  
            <!-- Settings Section -->
            <section class="content-section" id="settings">
                <div class="section-header">
                    <h1 class="section-title">Settings</h1>
                    <p class="section-subtitle">Manage your club information</p>
                </div>

                <div class="settings-section">
                    <h3 class="settings-title">Club Information</h3>
                    <div class="form-group">
                        <label class="form-label">Club Name</label>
                        <input type="text" class="form-input" id="club-name" value="TechXcel">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <textarea class="form-textarea" id="club-description">A technology club focused on innovation, learning, and community building. We organize workshops, tech talks, and hackathons to help members develop their skills.</textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Club Logo</label>
                        <div class="file-upload">
                            <input type="file" id="club-logo" accept="image/*">
                            <label for="club-logo" class="file-upload-label">
                                <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"></path>
                                </svg>
                                Upload Logo
                            </label>
                        </div>
                    </div>
                    <button class="btn btn-primary" onclick="saveSettings()">Save Changes</button>
                </div>

                <div class="settings-section">
                    <h3 class="settings-title">Notification Preferences</h3>
                    <div class="form-group">
                        <label class="form-label">
                            <input type="checkbox" checked> Email notifications for new members
                        </label>
                    </div>
                    <div class="form-group">
                        <label class="form-label">
                            <input type="checkbox" checked> Email notifications for event registrations
                        </label>
                    </div>
                    <div class="form-group">
                        <label class="form-label">
                            <input type="checkbox"> Weekly activity summary
                        </label>
                    </div>
                    <button class="btn btn-primary" onclick="saveNotificationSettings()">Save Preferences</button>
                </div>
            </section>
        </main>
    </div>

    <!-- Event Modal -->
    <div class="modal" id="event-modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="event-modal-title">Create New Event</h3>
                <div class="modal-close" onclick="closeEventModal()">
                    <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </div>
            </div>
            <div class="modal-body">
    <div class="form-group">
        <label class="form-label">Event Title</label>
        <input type="text" class="form-input" id="event-title" placeholder="Enter event title">
    </div>
    <div class="form-group">
        <label class="form-label">Date</label>
        <input type="date" class="form-input" id="event-date">
    </div>
    <div class="form-group">
        <label class="form-label">Venue</label>
        <input type="text" class="form-input" id="event-venue" placeholder="Enter event venue">
    </div>
    <div class="form-group">
        <label class="form-label">Description</label>
        <textarea class="form-textarea" id="event-description" placeholder="Enter event description"></textarea>
    </div>

    <!-- Hidden values (filled via JS) -->
    <input type="hidden" id="created_by">
    <input type="hidden" id="club_id">
    <input type="hidden" id="role">
</div>
	
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeEventModal()">Cancel</button>
                <button class="btn btn-primary" id="event-save-btn" onclick="saveEvent()">Create Event</button>
            </div>
        </div>
    </div>

    <!-- Alert Container -->
    <div class="alert-container" id="alert-container"></div>
    <script>
    	const contextPath = "<%= request.getContextPath() %>";
    	const clubId = "<%= session.getAttribute("clubId") %>";
    	const currentClubId = clubId;
    	const userId = "<%= session.getAttribute("userId") %>";
    	const userRole = "<%= session.getAttribute("role") %>";
    	document.body.dataset.contextPath = contextPath;
	</script>
    
    <script src="JS/leader_dashboard.js"></script>
</body>
</html>