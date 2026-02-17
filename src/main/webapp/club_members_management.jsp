<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ClubSphere - Members Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	<link rel="stylesheet" href="CSS/club_members_management.css">
</head>
<body data-club-id="<%= session.getAttribute("clubId") %>"
      data-context-path="<%= request.getContextPath() %>">
    <!-- Top Navbar -->
    <nav class="navbar top-navbar">
        <div class="container-fluid">
            <span class="navbar-brand">
                <i class="fas fa-users-cog"></i> ClubSphere
            </span>
            <span class="club-name">${clubName} Dashboard</span>
            <div class="ms-auto">
                <button class="btn btn-light btn-sm">
                    <i class="fas fa-user"></i> Profile
                </button>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Page Header -->
        <div class="page-header">
            <h2><i class="fas fa-users"></i> Members Management</h2>
            <p>View, search, and manage all club members</p>
        </div>

        <!-- Stats Row -->
        <div class="stats-row">
            <div class="stat-card">
                <h4 id="displayCount">127</h4>
                <p>Total Members</p>
            </div>
            <div class="stat-card">
                <h4 id="coreMembersCount">18</h4>
                <p>Core Members</p>
            </div>
            <div class="stat-card">
                <h4 id="leadersCount">4</h4>
                <p>Leaders</p>
            </div>
            <div class="stat-card">
                <h4 id="newMembersCount">12</h4>
                <p>New This Month</p>
            </div>
        </div>

        <!-- Search and Filter Controls -->
        <div class="controls-section">
            <div class="row g-3">
                <div class="col-md-6">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" class="form-control" id="searchInput" 
                               placeholder="Search by name or roll number..." 
                               onkeyup="filterMembers()">
                    </div>
                </div>
                <div class="col-md-6 text-end">
                    <button class="btn btn-download" onclick="downloadCSV()">
                        <i class="fas fa-download"></i> Download CSV
                    </button>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-12">
                    <label class="mb-2" style="color: #6b7280; font-size: 0.9rem;">
                        <i class="fas fa-filter"></i> Filter by Role:
                    </label>
                    <div class="filter-group">
                        <button class="filter-btn active" onclick="filterByRole('all', event)">All Members</button>
                        <button class="filter-btn" onclick="filterByRole('President', event)">President</button>
                        <button class="filter-btn" onclick="filterByRole('Secretary'. event)">Secretary</button>
                        <button class="filter-btn" onclick="filterByRole('Core Member', event)">Core Members</button>
                        <button class="filter-btn" onclick="filterByRole('student', event)">Student</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Members Container -->
        <div class="members-container">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="mb-0">
            <i class="fas fa-list"></i> Members List 
            <span class="badge bg-primary" id="displayCount">0</span>
        </h5>
    </div>

    <!-- Desktop Table View -->
    <div class="table-responsive members-table-view">
        <table class="table table-hover">
  <thead>
    <tr>
      <th>Member</th>
      <th>Role</th>
      <th>Branch & Section</th>
      <th>Joined Date</th>
    </tr>
  </thead>
  <tbody id="membersTableBody">
    <!-- rows will be inserted here -->
  </tbody>
</table>
    </div>

    <!-- Empty State -->
    <div class="empty-state" id="emptyState" style="display: none;">
        <i class="fas fa-users-slash"></i>
        <h5>No members found</h5>
        <p>Try adjusting your search or filter criteria</p>
    </div>
</div>
        
            </div>

    <!-- Promote Modal -->
    <div class="modal fade" id="promoteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-arrow-up"></i> Promote Member
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Select new role for <strong id="promoteMemberName"></strong>:</p>
                    <select class="form-select" id="newRoleSelect">
                        <option value="President">President</option>
                        <option value="Secretary">Secretary</option>
                        <option value="Core Member">Core Member</option>
                        <option value="Member">Member</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="confirmPromote()">
                        <i class="fas fa-check"></i> Confirm
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Remove Confirmation Modal -->
    <div class="modal fade" id="removeModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle"></i> Remove Member
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" style="filter: brightness(0) invert(1);"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove <strong id="removeMemberName"></strong> from the club?</p>
                    <p class="text-danger mb-0"><small>This action cannot be undone.</small></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" onclick="confirmRemove()">
                        <i class="fas fa-trash"></i> Remove
                    </button>
                </div>
            </div>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="JS/club_member_management.js"></script>
</body>
</html>