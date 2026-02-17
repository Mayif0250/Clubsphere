<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="java.util.List, java.util.Map" %>
    <%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Club Management - ClubSphere</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #2196F3;
            --primary-dark: #1976D2;
            --success-color: #4CAF50;
            --warning-color: #FFC107;
            --danger-color: #f44336;
            --gray-color: #9E9E9E;
        }

        body {
            background-color: #f5f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Header Section */
        .page-header {
            background: white;
            padding: 25px 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
        }

        .breadcrumb {
            background: none;
            padding: 0;
            margin: 0;
            font-size: 14px;
        }

        .breadcrumb-item a {
            color: var(--primary-color);
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: #666;
        }

        .page-title {
            font-size: 32px;
            font-weight: 700;
            color: #333;
            margin: 10px 0 0 0;
        }

        /* Control Bar */
        .control-bar {
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
        }

        .search-box {
            position: relative;
        }

        .search-box input {
            padding-left: 40px;
            border-radius: 10px;
            border: 2px solid #e0e0e0;
            transition: all 0.3s ease;
        }

        .search-box input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(33, 150, 243, 0.1);
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        .filter-select {
            border-radius: 10px;
            border: 2px solid #e0e0e0;
            transition: all 0.3s ease;
        }

        .filter-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(33, 150, 243, 0.1);
        }

        .btn-add-user {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            border: none;
            padding: 10px 25px;
            border-radius: 10px;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(33, 150, 243, 0.3);
        }

        .btn-add-user:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(33, 150, 243, 0.4);
        }

        /* Table Container */
        .table-container {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            overflow-x: auto;
        }

        .users-table {
            margin: 0;
            white-space: nowrap;
        }

        .users-table thead {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        }

        .users-table th {
            font-weight: 600;
            color: #555;
            border: none;
            padding: 15px;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .users-table tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid #f0f0f0;
        }

        .users-table tbody tr:hover {
            background-color: #f8f9ff;
            box-shadow: 0 2px 8px rgba(33, 150, 243, 0.1);
            transform: scale(1.01);
        }

        .users-table td {
            padding: 15px;
            vertical-align: middle;
            font-size: 14px;
            color: #555;
        }

        /* Status Badges */
        .badge-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-active {
            background-color: #e8f5e9;
            color: var(--success-color);
        }

        .badge-inactive {
            background-color: #f5f5f5;
            color: var(--gray-color);
        }

        .badge-pending {
            background-color: #fff8e1;
            color: #f57c00;
        }

        /* Role Badge */
        .badge-role {
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 11px;
            font-weight: 600;
        }

        .badge-admin {
            background-color: #e3f2fd;
            color: var(--primary-color);
        }

        .badge-student {
            background-color: #f3e5f5;
            color: #9c27b0;
        }

        .badge-faculty {
            background-color: #fff3e0;
            color: #ff6f00;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-action {
            width: 35px;
            height: 35px;
            border-radius: 8px;
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            font-size: 16px;
        }

        .btn-view {
            background-color: #e3f2fd;
            color: var(--primary-color);
        }

        .btn-view:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(33, 150, 243, 0.3);
        }

        .btn-edit {
            background-color: #fff8e1;
            color: #f57c00;
        }

        .btn-edit:hover {
            background-color: #f57c00;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(245, 124, 0, 0.3);
        }

        .btn-delete {
            background-color: #ffebee;
            color: var(--danger-color);
        }

        .btn-delete:hover {
            background-color: var(--danger-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);
        }

        /* Modal Styling */
        .modal-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: white;
            border-radius: 15px 15px 0 0;
        }

        .modal-content {
            border-radius: 15px;
            border: none;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        }

        .user-detail-row {
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .user-detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-weight: 600;
            color: #666;
            font-size: 14px;
        }

        .detail-value {
            color: #333;
            font-size: 14px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-title {
                font-size: 24px;
            }

            .control-bar {
                padding: 15px;
            }

            .btn-add-user {
                width: 100%;
                margin-top: 10px;
            }

            .table-container {
                padding: 15px;
            }

            .action-buttons {
                flex-direction: column;
            }
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-state i {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.3;
        }
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        <!-- Page Header -->
        <div class="page-header">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="admin_dashboard"><i class="bi bi-house-door"></i> Dashboard</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Club Management</li>
                </ol>
            </nav>
            <h1 class="page-title"><i class="bi bi-people-fill me-2"></i>Club Management</h1>
        </div>

        <!-- Control Bar -->
        <div class="control-bar">
            <div class="row g-3 align-items-center">
                <div class="col-lg-4 col-md-6">
                    <div class="search-box">
                        <i class="bi bi-search"></i>
                        <input type="text" class="form-control" id="searchInput" placeholder="Search by name or email...">
                    </div>
                </div>
                <div class="col-lg-2 col-md-3 col-6">
                    <select class="form-select filter-select" id="roleFilter">
                        <option value="">All Category</option>
                        <option value="technology">Technology</option>
                        <option value="phtography">Photography</option>
                        <option value="education">Education</option>
                        <option value="sports">Sports</option>
                    </select>
                </div>
                <div class="col-lg-2 col-md-3 col-6">
                    <select class="form-select filter-select" id="statusFilter">
                        <option value="">All Status</option>
                        <option value="Active">Active</option>
                        <option value="Inactive">Inactive</option>
                        <option value="Pending">Pending</option>
                    </select>
                </div>
                <div class="col-lg-4 col-md-12">
                    <button class="btn btn-add-user" data-bs-toggle="modal" data-bs-target="#addUserModal">
                        <i class="bi bi-plus-circle me-2"></i>Add New Club
                    </button>
                </div>
            </div>
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <div class="table-responsive">
                <table class="table users-table" id="usersTable">
                    <thead>
                            <tr>
                                <th>Club Name</th>
                                <th>Category</th>
                                <th>Members</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
						<%
    						List<Map<String, Object>> clubs = (List<Map<String, Object>>) request.getAttribute("clubs");
    						if (clubs != null && !clubs.isEmpty()) {
        					for (Map<String, Object> club : clubs) {
						%>
    				<tr>
        				<td><strong><%= club.get("club_name") %></strong></td>
        				<td><%= club.get("category") %></td>
        				<td><%= club.get("member_count") %></td>
        				<td>
            			<% String status = (String) club.get("status"); %>
            			<% if ("Active".equalsIgnoreCase(status)) { %>
                		<span class="badge bg-success badge-status">Active</span>
            			<% } else if ("Pending".equalsIgnoreCase(status)) { %>
                		<span class="badge bg-warning badge-status text-dark">Pending</span>
            			<% } else { %>
                				<span class="badge bg-secondary badge-status"><%= status %></span>
            			<% } %>
        				</td>
        				<td>
    						<div class="action-buttons">
                            	<button class="btn-action btn-view" data-bs-toggle="modal" data-bs-target="#viewUserModal" title="View Details">
                                	<i class="bi bi-eye"></i>
                            	</button>
                            	<button class="btn-action btn-edit" onclick="editUser('${user.id}')" title="Edit User">
                                	<i class="bi bi-pencil"></i>
                            	</button>
                            	<button class="btn-action btn-delete" onclick="deleteUser('${user.id}')" title="Delete User">
                                	<i class="bi bi-trash"></i>
                            	</button>
                        </div>
						</td>

    				</tr>
					<%
       					 }
    } else {
%>
    <tr><td colspan="5" class="text-center text-muted">No clubs found.</td></tr>
<%
    }
%>
</tbody>
                    </tbody>
                </table>
            </div>
            <div id="emptyState" class="empty-state d-none">
                <i class="bi bi-inbox"></i>
                <h5>No Users Found</h5>
                <p>Try adjusting your search or filters</p>
            </div>
        </div>
    </div>

    <!-- View User Modal -->
    <div class="modal fade" id="viewUserModal" tabindex="-1" aria-labelledby="viewUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewUserModalLabel"><i class="bi bi-person-circle me-2"></i>User Details</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4" id="userDetailsBody">
                    <!-- User details will be populated here -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Add User Modal (Placeholder) -->
    <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addUserModalLabel"><i class="bi bi-person-plus me-2"></i>Add Club User</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <p class="text-center text-muted">Add Club form will be implemented here</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary">Add Club</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Sample user data
        /*
        const users = [
            {
                id: 'N200401',
                name: 'Rajesh Kumar',
                email: 'n200401@rgukt.ac.in',
                branch: 'Computer Science',
                section: 'A',
                year: '3rd Year',
                role: 'Student',
                status: 'Active',
                phone: '+91 98765 43210',
                joinDate: '15-Aug-2022'
            },
            {
                id: 'N200402',
                name: 'Priya Sharma',
                email: 'n200402@rgukt.ac.in',
                branch: 'Electronics',
                section: 'B',
                year: '2nd Year',
                role: 'Student',
                status: 'Active',
                phone: '+91 98765 43211',
                joinDate: '16-Aug-2023'
            },
            {
                id: 'F001',
                name: 'Dr. Suresh Reddy',
                email: 'suresh.reddy@rgukt.ac.in',
                branch: 'Computer Science',
                section: '-',
                year: '-',
                role: 'Faculty',
                status: 'Active',
                phone: '+91 98765 43212',
                joinDate: '01-Jan-2015'
            },
            {
                id: 'N200403',
                name: 'Ananya Desai',
                email: 'n200403@rgukt.ac.in',
                branch: 'Mechanical',
                section: 'C',
                year: '4th Year',
                role: 'Student',
                status: 'Pending',
                phone: '+91 98765 43213',
                joinDate: '20-Aug-2021'
            },
            {
                id: 'A001',
                name: 'Vikram Singh',
                email: 'vikram.admin@rgukt.ac.in',
                branch: 'Administration',
                section: '-',
                year: '-',
                role: 'Admin',
                status: 'Active',
                phone: '+91 98765 43214',
                joinDate: '10-Jun-2018'
            }
        ];

        let filteredUsers = [...users];

        // Render table
        function renderTable(data) {
            const tableBody = document.getElementById('tableBody');
            const emptyState = document.getElementById('emptyState');

            if (data.length === 0) {
                tableBody.innerHTML = '';
                emptyState.classList.remove('d-none');
                return;
            }

            emptyState.classList.add('d-none');

            tableBody.innerHTML = data.map(user => `
                <tr>
                    <td><strong>${user.id}</strong></td>
                    <td>${user.name}</td>
                    <td>${user.email}</td>
                    <td>${user.branch}</td>
                    <td>${user.section}</td>
                    <td>${user.year}</td>
                    <td><span class="badge-role badge-${user.role.toLowerCase()}">${user.role}</span></td>
                    <td><span class="badge-status badge-${user.status.toLowerCase()}">${user.status}</span></td>
                    <td>
                        <div class="action-buttons">
                            <button class="btn-action btn-view" onclick="viewUser('${user.id}')" title="View Details">
                                <i class="bi bi-eye"></i>
                            </button>
                            <button class="btn-action btn-edit" onclick="editUser('${user.id}')" title="Edit User">
                                <i class="bi bi-pencil"></i>
                            </button>
                            <button class="btn-action btn-delete" onclick="deleteUser('${user.id}')" title="Delete User">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>
            `).join('');
        } */

        // View user details
        function viewUser(userId) {

            const detailsBody = document.getElementById('userDetailsBody');
            detailsBody.innerHTML = `
                <div class="user-detail-row">
                    <div class="row">
                        <div class="col-5 detail-label">Student/Staff ID:</div>
                        <div class="col-7 detail-value">${user.id}</div>
                    </div>
                </div>
                <div class="user-detail-row">
                    <div class="row">
                        <div class="col-5 detail-label">Full Name:</div>
                        <div class="col-7 detail-value">${user.name}</div>
                    </div>
                </div>
                <div class="user-detail-row">
                    <div class="row">
                        <div class="col-5 detail-label">Email:</div>
                        <div class="col-7 detail-value">${user.email}</div>
                    </div>
                </div>
                <div class="user-detail-row">
                    <div class="row">
                        <div class="col-5 detail-label">Phone:</div>
                        <div class="col-7 detail-value">${user.phone}</div>
                    </div>
                </div>
                <div class="user-detail-row">
                    <div class="row">
                        <div class="col-5 detail-label">Branch:</div>
                        <div class="col-7 detail-value">${user.branch}</div>
                    </div>
                </div>
                <div class="user-detail-row">
                    <div class="row">
                        <div class="col-5 detail-label">Section:</div>
                        <div class="col-7 detail-value">${user.section}</div>
                    </div>
                </div>
                <div class="user-detail-row">
                    <div class="row">
                        <div class="col-5 detail-label">Academic Year:</div>
                        <div class="col-7 detail-value">${user.year}</div>
                    </div>
                </div>
                <div class="user-detail-row">
                    <div class="row">
                        <div class="col-5 detail-label">Role:</div>
                        <div class="col-7 detail-value"><span class="badge-role badge-${user.role.toLowerCase()}">${user.role}</span></div>
                    </div>
                </div>
                <div class="user-detail-row">
                    <div class="row">
                        <div class="col-5 detail-label">Status:</div>
                        <div class="col-7 detail-value"><span class="badge-status badge-${user.status.toLowerCase()}">${user.status}</span></div>
                    </div>
                </div>
                <div class="user-detail-row">
                    <div class="row">
                        <div class="col-5 detail-label">Join Date:</div>
                        <div class="col-7 detail-value">${user.joinDate}</div>
                    </div>
                </div>
            `;

            const modal = new bootstrap.Modal(document.getElementById('viewUserModal'));
            modal.show();
        }

        // Edit user
        function editUser(userId) {
            alert(`Edit user: ${userId}\n(Edit functionality will be implemented)`);
        }

        // Delete user
        function deleteUser(userId) {
            if (confirm(`Are you sure you want to delete user ${userId}?`)) {
                const index = users.findIndex(u => u.id === userId);
                if (index > -1) {
                    users.splice(index, 1);
                    applyFilters();
                    alert('User deleted successfully!');
                }
            }
        }

        // Search and filter
        function applyFilters() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const roleFilter = document.getElementById('roleFilter').value;
            const statusFilter = document.getElementById('statusFilter').value;

            filteredUsers = users.filter(user => {
                const matchesSearch = user.name.toLowerCase().includes(searchTerm) || 
                                    user.email.toLowerCase().includes(searchTerm) ||
                                    user.id.toLowerCase().includes(searchTerm);
                const matchesRole = !roleFilter || user.role === roleFilter;
                const matchesStatus = !statusFilter || user.status === statusFilter;

                return matchesSearch && matchesRole && matchesStatus;
            });

            renderTable(filteredUsers);
        }

        // Event listeners
        document.getElementById('searchInput').addEventListener('input', applyFilters);
        document.getElementById('roleFilter').addEventListener('change', applyFilters);
        document.getElementById('statusFilter').addEventListener('change', applyFilters);

        // Initial render
        renderTable(users);
    </script>
</body>
</html>