<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List, java.util.Map" %>
    <%@ page import="java.util.ArrayList" %>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ClubSphere Admin Dashboard - RGUKT Ongole</title>
    
    <link rel="stylesheet" href="CSS/admin_dashboard.css">
    
</head>
<body data-context-path="${pageContext.request.contextPath}">
    <div class="container">
        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="logo-section">
                    <div class="logo-icon">CS</div>
                    <div class="logo-text">ClubSphere</div>
                </div>
                <button class="toggle-btn" id="toggleBtn" onclick="toggleSidebar()">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <line x1="3" y1="12" x2="21" y2="12"></line>
                        <line x1="3" y1="6" x2="21" y2="6"></line>
                        <line x1="3" y1="18" x2="21" y2="18"></line>
                    </svg>
                </button>
            </div>
            <nav>
                <ul class="nav-menu">
                    <li class="nav-item">
                        <a class="nav-link active" onclick="navigateTo('dashboard')">
                            <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="3" y="3" width="7" height="7"></rect>
                                <rect x="14" y="3" width="7" height="7"></rect>
                                <rect x="14" y="14" width="7" height="7"></rect>
                                <rect x="3" y="14" width="7" height="7"></rect>
                            </svg>
                            <span class="nav-text">Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" onclick="navigateTo('clubs')">
                            <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                <circle cx="9" cy="7" r="4"></circle>
                                <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                            </svg>
                            <span class="nav-text">Clubs</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" onclick="navigateTo('members')">
                            <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                <circle cx="9" cy="7" r="4"></circle>
                                <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                            </svg>
                            <span class="nav-text">Members</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" onclick="navigateTo('events')">
                            <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                <line x1="16" y1="2" x2="16" y2="6"></line>
                                <line x1="8" y1="2" x2="8" y2="6"></line>
                                <line x1="3" y1="10" x2="21" y2="10"></line>
                            </svg>
                            <span class="nav-text">Events</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" onclick="navigateTo('announcements')">
                            <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
                                <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
                            </svg>
                            <span class="nav-text">Announcements</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" onclick="navigateTo('approvals')">
                            <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M9 11l3 3L22 4"></path>
                                <path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path>
                            </svg>
                            <span class="nav-text">Approvals</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" onclick="navigateTo('reports')">
                            <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <line x1="12" y1="20" x2="12" y2="10"></line>
                                <line x1="18" y1="20" x2="18" y2="4"></line>
                                <line x1="6" y1="20" x2="6" y2="16"></line>
                            </svg>
                            <span class="nav-text">Reports</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" onclick="navigateTo('settings')">
                            <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <circle cx="12" cy="12" r="3"></circle>
                                <path d="M12 1v6m0 6v6m9-9h-6m-6 0H3"></path>
                            </svg>
                            <span class="nav-text">Settings</span>
                        </a>
                    </li>
                    <li class="nav-item" style="margin-top: 20px;">
                        <a class="nav-link" onclick="logout()">
                            <svg class="nav-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                                <polyline points="16 17 21 12 16 7"></polyline>
                                <line x1="21" y1="12" x2="9" y2="12"></line>
                            </svg>
                            <span class="nav-text">Logout</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <header class="header">
                <div class="header-left">
                    <button class="hamburger" onclick="toggleMobileSidebar()">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <line x1="3" y1="12" x2="21" y2="12"></line>
                            <line x1="3" y1="6" x2="21" y2="6"></line>
                            <line x1="3" y1="18" x2="21" y2="18"></line>
                        </svg>
                    </button>
                    <h1 class="header-title">ClubSphere Admin</h1>
                    <div class="search-bar">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="11" cy="11" r="8"></circle>
                            <path d="m21 21-4.35-4.35"></path>
                        </svg>
                        <input type="text" placeholder="Search..." id="searchInput" onkeyup="handleSearch(event)">
                    </div>
                </div>
                <div class="header-right">
                    <button class="icon-btn" class="bi bi-bell-fill" style="cursor:pointer;font-size:20px;color:#002855;" onclick="openNotificationsModal()">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
                            <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
                        </svg>
                        <span class="notification-badge"></span>
                    </button>
                    <div class="profile-section" onclick="toggleProfileDropdown()">
                        <div class="profile-avatar">AK</div>
                        <div class="profile-info">
                            <div class="profile-name">Admin Coordinator</div>
                            <div class="profile-role">System Administrator</div>
                        </div>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="6 9 12 15 18 9"></polyline>
                        </svg>
                        <div class="dropdown" id="profileDropdown">
                            <div class="dropdown-item" onclick="navigateTo('settings')">Profile Settings</div>
                            <div class="dropdown-item" onclick="alert('Account preferences coming soon')">Account Preferences</div>
                            <div class="dropdown-item" onclick="logout()">Logout</div>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Content Wrapper -->
            <div class="content-wrapper">
                <!-- Dashboard Section -->
                <section class="content-section active" id="dashboard">
                    <h2 style="font-size: 28px; font-weight: 700; color: var(--primary-navy); margin-bottom: 24px;">Dashboard Overview</h2>
                    
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-header">
                                <div>
                                    <div class="stat-label">Total Clubs</div>
                                </div>
                                <div class="stat-icon" style="background: rgba(49,130,206,0.1); color: var(--accent-blue);">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                        <circle cx="9" cy="7" r="4"></circle>
                                        <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                    </svg>
                                </div>
                            </div>
                            <div class="stat-value">24</div>
                            <div class="stat-change">↑ 3 new this month</div>
                        </div>

                        <div class="stat-card">
                            <div class="stat-header">
                                <div>
                                    <div class="stat-label">Active Members</div>
                                </div>
                                <div class="stat-icon" style="background: rgba(56,161,105,0.1); color: var(--success);">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"></path>
                                        <circle cx="9" cy="7" r="4"></circle>
                                        <line x1="19" y1="8" x2="19" y2="14"></line>
                                        <line x1="22" y1="11" x2="16" y2="11"></line>
                                    </svg>
                                </div>
                            </div>
                            <div class="stat-value">1,847</div>
                            <div class="stat-change">↑ 12% from last month</div>
                        </div>

                        <div class="stat-card">
                            <div class="stat-header">
                                <div>
                                    <div class="stat-label">Ongoing Events</div>
                                </div>
                                <div class="stat-icon" style="background: rgba(214,158,46,0.1); color: var(--warning);">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                        <line x1="16" y1="2" x2="16" y2="6"></line>
                                        <line x1="8" y1="2" x2="8" y2="6"></line>
                                        <line x1="3" y1="10" x2="21" y2="10"></line>
                                    </svg>
                                </div>
                            </div>
                            <div class="stat-value">12</div>
                            <div class="stat-change">5 scheduled this week</div>
                        </div>

                        <div class="stat-card">
                            <div class="stat-header">
                                <div>
                                    <div class="stat-label">Pending Approvals</div>
                                </div>
                                <div class="stat-icon" style="background: rgba(229,62,62,0.1); color: var(--danger);">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <circle cx="12" cy="12" r="10"></circle>
                                        <line x1="12" y1="8" x2="12" y2="12"></line>
                                        <line x1="12" y1="16" x2="12.01" y2="16"></line>
                                    </svg>
                                </div>
                            </div>
                            <div class="stat-value">8</div>
                            <div class="stat-change">Requires attention</div>
                        </div>
                    </div>

                    <div class="chart-container">
                        <div class="chart-header">Club Membership Growth (Last 6 Months)</div>
                        <div class="chart" id="membershipChart">
                            <div class="bar" style="height: 45%;">
                                <span class="bar-value">285</span>
                                <span class="bar-label">Jun</span>
                            </div>
                            <div class="bar" style="height: 55%;">
                                <span class="bar-value">340</span>
                                <span class="bar-label">Jul</span>
                            </div>
                            <div class="bar" style="height: 65%;">
                                <span class="bar-value">410</span>
                                <span class="bar-label">Aug</span>
                            </div>
                            <div class="bar" style="height: 60%;">
                                <span class="bar-value">380</span>
                                <span class="bar-label">Sep</span>
                            </div>
                            <div class="bar" style="height: 75%;">
                                <span class="bar-value">465</span>
                                <span class="bar-label">Oct</span>
                            </div>
                            <div class="bar" style="height: 85%;">
                                <span class="bar-value">520</span>
                                <span class="bar-label">Nov</span>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Clubs Section -->
                <section class="content-section" id="clubs">
                    <h2 style="font-size: 28px; font-weight: 700; color: var(--primary-navy); margin-bottom: 24px;">Club Management</h2>
                    
                    <div class="table-container">
                        <div class="table-header">
                            <div class="table-title">Registered Clubs</div>
                            <button class="btn btn-primary" onclick="alert('Add new club functionality')">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <line x1="12" y1="5" x2="12" y2="19"></line>
                                    <line x1="5" y1="12" x2="19" y2="12"></line>
                                </svg>
                                Add New Club
                            </button>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <th>Club Name</th>
                                    <th>Leader</th>
                                    <th>Members</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody id="clubsTableBody">
    								<!-- Dynamic rows will be inserted here -->
							</tbody>
                        </table>
                    </div>
                </section>

                <!-- Members Section -->
                <section class="content-section" id="members">
                	<h2 style="font-size: 28px; font-weight: 700; color: var(--primary-navy); margin-bottom: 24px;">Member Directory</h2>
					<div style="margin-bottom: 24px;">
    					<a href="user_management.jsp">
      						<button class="btn btn-primary">
        						<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          							<line x1="12" y1="5" x2="12" y2="19"></line>
          							<line x1="5" y1="12" x2="19" y2="12"></line>
        						</svg>
        						View all Members
      						</button>
    					</a>
  					</div>

  					<div id="memberGrid" class="member-grid"></div>
                </section>
                
                <!-- Events Section -->
                <section class="content-section" id="events">
                    <h2 style="font-size: 28px; font-weight: 700; color: var(--primary-navy); margin-bottom: 24px;">Events Calendar</h2>
                    
                   <div style="margin-bottom: 24px;">
                   <button class="btn btn-primary" onclick="openEventModal()">
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <line x1="12" y1="5" x2="12" y2="19"></line>
        <line x1="5" y1="12" x2="19" y2="12"></line>
    </svg>
    Schedule Event
</button></div>


                    <div class="event-list">
                        <div class="event-item">
                            <div class="event-info">
                                <h3>TechFest 2025 - Annual Hackathon</h3>
                                <div class="event-meta">
                                    <span>📅 November 15-17, 2025</span>
                                    <span>📍 Main Auditorium</span>
                                    <span>👥 250 Participants</span>
                                </div>
                            </div>
                            <div>
                                <span class="badge badge-success">Ongoing</span>
                            </div>
                        </div>

                        <div class="event-item">
                            <div class="event-info">
                                <h3>Cultural Night - Traditional Dance Performance</h3>
                                <div class="event-meta">
                                    <span>📅 November 20, 2025</span>
                                    <span>📍 Open Air Theatre</span>
                                    <span>👥 500 Participants</span>
                                </div>
                            </div>
                            <div>
                                <span class="badge badge-warning">Upcoming</span>
                            </div>
                        </div>

                        <div class="event-item">
                            <div class="event-info">
                                <h3>Inter-College Sports Meet</h3>
                                <div class="event-meta">
                                    <span>📅 November 25-27, 2025</span>
                                    <span>📍 Sports Complex</span>
                                    <span>👥 400 Participants</span>
                                </div>
                            </div>
                            <div>
                                <span class="badge badge-warning">Upcoming</span>
                            </div>
                        </div>

                        <div class="event-item">
                            <div class="event-info">
                                <h3>Literary Symposium - Poetry & Prose</h3>
                                <div class="event-meta">
                                    <span>📅 December 2, 2025</span>
                                    <span>📍 Conference Hall</span>
                                    <span>👥 150 Participants</span>
                                </div>
                            </div>
                            <div>
                                <span class="badge badge-warning">Upcoming</span>
                            </div>
                        </div>

                        <div class="event-item">
                            <div class="event-info">
                                <h3>Robotics Workshop - AI & Machine Learning</h3>
                                <div class="event-meta">
                                    <span>📅 December 8-10, 2025</span>
                                    <span>📍 Lab Complex</span>
                                    <span>👥 120 Participants</span>
                                </div>
                            </div>
                            <div>
                                <span class="badge badge-warning">Upcoming</span>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Announcements Section -->
				<section class="content-section" id="announcements" style="padding: 20px;">
  <h2 style="font-size: 28px; font-weight: 700; color: var(--primary-navy); margin-bottom: 24px;">
    Announcements
  </h2>

  <!-- Create Announcement -->
  		<div class="form-container" style="background: #fff; padding: 24px; border-radius: 10px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); margin-bottom: 40px;">
    		<h3 style="font-size: 18px; font-weight: 600; margin-bottom: 20px; color: var(--primary-navy);">
      			Create New Announcement
    		</h3>

    		<form id="announcementForm" onsubmit="addAnnouncement(event)" enctype="multipart/form-data">
      			<div class="form-group" style="margin-bottom: 16px;">
        				<label class="form-label" style="font-weight: 500;">Title</label>
        				<input type="text" class="form-control" id="announcementTitle" name="title" placeholder="Enter announcement title" required
               		style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 6px;">
      			</div>

      			<div class="form-group" style="margin-bottom: 16px;">
        				<label class="form-label" style="font-weight: 500;">Message</label>
        				<textarea class="form-control" id="announcementMessage" placeholder="Enter announcement message" required
                  		style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 6px; min-height: 100px;"></textarea>
      			</div>

      			<div class="form-group" style="margin-bottom: 16px;">
        				<label class="form-label" style="font-weight: 500;">Send To</label>
        				<select class="form-control" id="announcementAudience" name="target_type" required
                		style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 6px;">
          						<option value="all">All Users</option>
          						<option value="leaders">All Club Leaders</option>
          						<option value="specific">Specific Club Leaders</option>
        				</select>
     			 </div>

      				<!-- Specific club selector -->
      				<div class="form-group" id="specificClubContainer" style="display: none; margin-bottom: 16px;">
        				<label class="form-label" style="font-weight: 500;">Select Club</label>
        				<select class="form-control" id="specificClubSelect" name="target_club_id"
                				style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 6px;">
          					<option value="">Select a club</option>
        				</select>
      				</div>

      				<button type="submit" class="btn btn-primary"
              			style="background-color: var(--primary-navy); border: none; padding: 10px 20px; border-radius: 6px; color: #fff; font-weight: 600; cursor: pointer;">
        				Publish Announcement
      				</button>
    			</form>
  					</div>

  						<!-- Recent Announcements -->
  					<div>
    				<h3 style="font-size: 20px; font-weight: 600; margin-bottom: 20px; color: var(--primary-navy);">
      					Recent Announcements
    				</h3>

    				<div id="announcementsList">
     					 <!-- Will be dynamically filled -->
    				</div>
  				</div>
			</section>
                

                <!-- Approvals Section -->
                <section class="content-section" id="approvals">
                    <h2 style="font-size: 28px; font-weight: 700; color: var(--primary-navy); margin-bottom: 24px;">Pending Approvals</h2>
                    
                    <div class="stats-grid" style="margin-bottom: 32px;">
                        <div class="stat-card">
                            <div class="stat-label">Club Registrations</div>
                            <div class="stat-value" style="font-size: 28px; color: var(--danger);">3</div>
                            <div class="stat-change">Awaiting review</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-label">Event Requests</div>
                            <div class="stat-value" style="font-size: 28px; color: var(--warning);">4</div>
                            <div class="stat-change">Pending approval</div>
                        </div>
                    </div>

					<div class="table-container" style="margin-bottom: 32px;">
    					<div class="table-header">
        					<div class="table-title">Club Registration Requests</div>
        						<button class="btn btn-secondary" onclick="loadApprovals()">Refresh</button>
    						</div>
    						<table id="approvals-table">
        						<thead>
            						<tr>
                						<th>Club Name</th>
                						<th>Requested By</th>
                						<th>Members</th>
                						<th>Submitted</th>
                						<th>Actions</th>
            						</tr>
        						</thead>
        						<tbody>
            						<tr><td colspan="5" style="text-align:center;">Loading...</td></tr>
        						</tbody>
    						</table>
						</div>
					

                    <div class="table-container" style="margin-bottom: 32px;">
                        <div class="table-header">
                            <div class="table-title">Event Approval Requests</div>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <th>Event Name</th>
                                    <th>Club</th>
                                    <th>Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><strong>Photography Exhibition 2025</strong></td>
                                    <td>Photography Club (Pending)</td>
                                    <td>December 10, 2025</td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn btn-secondary btn-sm" onclick="viewApprovalDetails('Photography Exhibition')">View Details</button>
                                            <button class="btn btn-primary btn-sm" onclick="approveRequest('Photography Exhibition', 'event')">Approve</button>
                                            <button class="btn btn-secondary btn-sm" style="background: var(--danger); color: white;" onclick="rejectRequest('Photography Exhibition', 'event')">Reject</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Coding Bootcamp</strong></td>
                                    <td>Tech Innovation Club</td>
                                    <td>November 18-20, 2025</td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn btn-secondary btn-sm" onclick="viewApprovalDetails('Coding Bootcamp')">View Details</button>
                                            <button class="btn btn-primary btn-sm" onclick="approveRequest('Coding Bootcamp', 'event')">Approve</button>
                                            <button class="btn btn-secondary btn-sm" style="background: var(--danger); color: white;" onclick="rejectRequest('Coding Bootcamp', 'event')">Reject</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Tree Plantation Drive</strong></td>
                                    <td>Environmental Action Group (Pending)</td>
                                    <td>November 15, 2025</td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn btn-secondary btn-sm" onclick="viewApprovalDetails('Tree Plantation Drive')">View Details</button>
                                            <button class="btn btn-primary btn-sm" onclick="approveRequest('Tree Plantation Drive', 'event')">Approve</button>
                                            <button class="btn btn-secondary btn-sm" style="background: var(--danger); color: white;" onclick="rejectRequest('Tree Plantation Drive', 'event')">Reject</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Night Sky Observation</strong></td>
                                    <td>Astronomy Society (Pending)</td>
                                    <td>November 22, 2025</td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn btn-secondary btn-sm" onclick="viewApprovalDetails('Night Sky Observation')">View Details</button>
                                            <button class="btn btn-primary btn-sm" onclick="approveRequest('Night Sky Observation', 'event')">Approve</button>
                                            <button class="btn btn-secondary btn-sm" style="background: var(--danger); color: white;" onclick="rejectRequest('Night Sky Observation', 'event')">Reject</button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </section>

                <!-- Reports Section -->
                <section class="content-section" id="reports">
                    <h2 style="font-size: 28px; font-weight: 700; color: var(--primary-navy); margin-bottom: 24px;">Reports & Analytics</h2>
                    
                    <div class="stats-grid" style="margin-bottom: 32px;">
                        <div class="stat-card">
                            <div class="stat-label">Monthly Active Users</div>
                            <div class="stat-value" style="font-size: 28px;">1,652</div>
                            <div class="stat-change">↑ 8.5% from last month</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-label">Events Completed</div>
                            <div class="stat-value" style="font-size: 28px;">47</div>
                            <div class="stat-change">This semester</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-label">Average Attendance</div>
                            <div class="stat-value" style="font-size: 28px;">78%</div>
                            <div class="stat-change">↑ 5% improvement</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-label">Budget Utilization</div>
                            <div class="stat-value" style="font-size: 28px;">65%</div>
                            <div class="stat-change">₹3.25L of ₹5L</div>
                        </div>
                    </div>

                    <div class="table-container">
                        <div class="table-header">
                            <div class="table-title">Club Performance Summary</div>
                            <button class="btn btn-primary" onclick="alert('Export report as PDF')">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                    <polyline points="7 10 12 15 17 10"></polyline>
                                    <line x1="12" y1="15" x2="12" y2="3"></line>
                                </svg>
                                Export Report
                            </button>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <th>Club Name</th>
                                    <th>Events Conducted</th>
                                    <th>Avg. Attendance</th>
                                    <th>Budget Used</th>
                                    <th>Performance</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Tech Innovation Club</td>
                                    <td>12</td>
                                    <td>85%</td>
                                    <td>₹68,000</td>
                                    <td><span class="badge badge-success">Excellent</span></td>
                                </tr>
                                <tr>
                                    <td>Cultural Arts Society</td>
                                    <td>15</td>
                                    <td>92%</td>
                                    <td>₹85,000</td>
                                    <td><span class="badge badge-success">Excellent</span></td>
                                </tr>
                                <tr>
                                    <td>Sports & Fitness Club</td>
                                    <td>8</td>
                                    <td>78%</td>
                                    <td>₹45,000</td>
                                    <td><span class="badge badge-success">Good</span></td>
                                </tr>
                                <tr>
                                    <td>Literary Circle</td>
                                    <td>6</td>
                                    <td>65%</td>
                                    <td>₹32,000</td>
                                    <td><span class="badge badge-warning">Average</span></td>
                                </tr>
                                <tr>
                                    <td>Robotics & AI Club</td>
                                    <td>10</td>
                                    <td>88%</td>
                                    <td>₹95,000</td>
                                    <td><span class="badge badge-success">Excellent</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </section>

                <!-- Settings Section -->
                <section class="content-section" id="settings">
                    <h2 style="font-size: 28px; font-weight: 700; color: var(--primary-navy); margin-bottom: 24px;">System Settings</h2>
                    
                    <div class="form-container" style="max-width: 100%;">
                        <h3 style="font-size: 18px; font-weight: 600; margin-bottom: 20px; color: var(--primary-navy);">Profile Settings</h3>
                        <form onsubmit="saveSettings(event)">
                            <div class="form-group">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control" value="Admin Coordinator" placeholder="Enter full name">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Email Address</label>
                                <input type="email" class="form-control" value="admin@rgukt.ac.in" placeholder="Enter email address">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" value="+91 98765 00000" placeholder="Enter phone number">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Department</label>
                                <input type="text" class="form-control" value="Administration" placeholder="Enter department">
                            </div>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </form>
                    </div>

                    <div class="form-container" style="max-width: 100%; margin-top: 24px;">
                        <h3 style="font-size: 18px; font-weight: 600; margin-bottom: 20px; color: var(--primary-navy);">System Preferences</h3>
                        <form>
                            <div class="form-group">
                                <label class="form-label">Notification Email</label>
                                <input type="email" class="form-control" value="notifications@rgukt.ac.in" placeholder="Enter notification email">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Default Events Approval</label>
                                <select class="form-control">
                                    <option>Require Manual Approval</option>
                                    <option>Auto-approve from Verified Clubs</option>
                                    <option>Auto-approve All</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Member Registration</label>
                                <select class="form-control">
                                    <option>Open Registration</option>
                                    <option>Approval Required</option>
                                    <option>Closed</option>
                                </select>
                            </div>
                            <button type="button" class="btn btn-primary" onclick="alert('System preferences saved successfully!')">Update Preferences</button>
                        </form>
                    </div>
                </section>
            </div>

            <!-- Footer -->
            <footer class="footer">
                © 2025 RGUKT Ongole | ClubSphere Admin Portal
            </footer>
        </div>
    </div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Club Details Modal -->
<div id="clubModal" class="custom-modal">
  <div class="custom-modal-content">
    <span class="custom-modal-close" onclick="closeClubModal()">&times;</span>
    <h2 id="modalClubName" class="modal-club-title"></h2>
    <div class="club-details-grid">
      <p><strong>Leader:</strong> <span id="modalClubLeader"></span></p>
      <p><strong>Category:</strong> <span id="modalClubCategory"></span></p>
      <p><strong>Status:</strong> <span id="modalClubStatus"></span></p>
      <p><strong>Members:</strong> <span id="modalClubMembers"></span></p>
      <p><strong>Description:</strong> <span id="modalClubDescription"></span></p>
      <p><strong>Created At:</strong> <span id="modalClubCreated"></span></p>
      <p><strong>Contact Email:</strong> <span id="modalClubEmail"></span></p>
      <p><strong>Contact Phone:</strong> <span id="modalClubPhone"></span></p>
    </div>
    <div class="modal-footer">
      <button class="custom-close-btn" onclick="closeClubModal()">Close</button>
    </div>
  </div>
</div>
<!-- Notifications Modal -->
<div id="notificationsModal" class="custom-modal">
  <div class="custom-modal-content"style="
    padding-left: 0px;
    padding-right: 0px;
    padding-top: 0px;
    padding-bottom: 0px;
">
    <div class="modal-header">
      <h4><i class="bi bi-bell-fill me-2"></i>Notifications Center</h4>
      <button class="close-btn" onclick="closeNotificationsModal()">×</button>
    </div>

    <div class="modal-body" id="notificationsBody">
      <!-- Dynamic content goes here -->
    </div>

    <div class="modal-footer">
      <button class="btn btn-secondary" onclick="closeNotificationsModal()">Close</button>
    </div>
  </div>
</div>
<!-- 🆕 Create Event Full View -->

<!-- Custom Create Event Modal -->
<div id="eventModalOverlay" class="event-modal-overlay">
  <div class="event-modal">
    <div class="event-modal-header">
      <h2>Schedule a New Event</h2>
      <span class="close-event-modal" onclick="closeEventModal()">&times;</span>
    </div>

    <form id="createEventForm" class="event-form">
      <div class="event-form-group">
        <label>Event Title</label>
        <input type="text" name="title" required>
      </div>

      <div class="event-form-group">
        <label>Description</label>
        <textarea name="description" rows="3" required></textarea>
      </div>

      <div class="event-form-group">
        <label>Date</label>
        <input type="date" name="date" required>
      </div>

      <div class="event-form-group">
        <label>Venue</label>
        <input type="text" name="venue" required>
      </div>

      <div class="event-form-buttons">
        <button type="button" class="cancel-btn" onclick="closeEventModal()">Cancel</button>
        <button type="submit" class="create-btn">Create Event</button>
      </div>
    </form>
  </div>
</div>

	<script>
    	const clubId = "<%= session.getAttribute("clubId") %>";
    	const currentClubId = clubId;
    	const userId = "<%= session.getAttribute("userId") %>";
    	const userRole = "<%= session.getAttribute("role") %>";
	</script>
    <script src="JS/admin_dashboard.js"></script>
</body>
</html>