<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="java.util.List, java.util.Map" %>
    <%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - ClubSphere</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="CSS/user_management.css">
</head>
<body data-context-path="${pageContext.request.contextPath}">
    <div class="container-fluid py-4">
        <!-- Page Header -->
        <div class="page-header">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="admin_dashboard"><i class="bi bi-house-door"></i> Dashboard</a></li>
                    <li class="breadcrumb-item active" aria-current="page">User Management</li>
                </ol>
            </nav>
            <h1 class="page-title"><i class="bi bi-people-fill me-2"></i>User Management</h1>
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
                        <option value="">All Roles</option>
                        <option value="admin">Admin</option>
                        <option value="student">Student</option>
                        <option value="leader">Club Leader</option>
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
                    <button class="btn btn-add-user" onclick="openAddUserModal()">
                        <i class="bi bi-plus-circle me-2"></i>Add New User
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
    						<th>Student ID</th>
    						<th>Name</th>
    						<th>Email</th>
    						<th>Phone</th>
    						<th>Branch & Section</th>
    						<th>Year</th>
    						<th>Role</th>
    						<th>Registered</th>
    						<th>Actions</th>
    					</tr>
                        </thead>
                    <tbody id="tableBody">
                        <tbody></tbody>
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
                    <div class="user-detail-row">
                    <div class="row">
                        <div class="col-5 detail-label">Student/Staff ID:</div>
                        <div class="col-7 detail-value">${user.StudentId}</div>
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
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closeUserModal()">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Edit User Modal -->
<div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content rounded-3 shadow">
      <div class="modal-header">
        <h5 class="modal-title fw-bold" id="editUserModalLabel">Edit User Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">
        <form id="editUserForm">
          <input type="hidden" id="editUserId">

          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label">First Name</label>
              <input type="text" id="editFirstName" class="form-control" />
            </div>
            <div class="col-md-6">
              <label class="form-label">Last Name</label>
              <input type="text" id="editLastName" class="form-control" />
            </div>

            <div class="col-md-6">
              <label class="form-label">Email</label>
              <input type="email" id="editEmail" class="form-control" />
            </div>
            <div class="col-md-6">
              <label class="form-label">Phone</label>
              <input type="text" id="editPhone" class="form-control" />
            </div>

            <div class="col-md-4">
              <label class="form-label">Branch</label>
              <input type="text" id="editBranch" class="form-control" />
            </div>
            <div class="col-md-4">
              <label class="form-label">Section</label>
              <input type="text" id="editSection" class="form-control" />
            </div>
            <div class="col-md-4">
              <label class="form-label">Academic Year</label>
              <input type="text" id="editYear" class="form-control" />
            </div>

            <div class="col-md-6">
              <label class="form-label">Role</label>
              <select id="editRole" class="form-select">
                <option value="student">Student</option>
                <option value="leader">Leader</option>
                <option value="admin">Admin</option>
              </select>
            </div>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closeUserModal()">Close</button>
        <button id="saveEditUserBtn" type="button" class="btn btn-primary">Save Changes</button>
      </div>
    </div>
  </div>
</div>
    

    <!-- Add User Modal (Placeholder) -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content rounded-4 shadow-lg">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="addUserModalLabel">Add New User</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        <form id="addUserForm" class="p-2">
          <div class="row mb-3">
            <div class="col-md-6">
              <label class="form-label">First Name</label>
              <input type="text" id="addFirstName" class="form-control" required>
            </div>
            <div class="col-md-6">
              <label class="form-label">Last Name</label>
              <input type="text" id="addLastName" class="form-control">
            </div>
          </div>

          <div class="row mb-3">
            <div class="col-md-6">
              <label class="form-label">Email</label>
              <input type="email" id="addEmail" class="form-control" required>
            </div>
            <div class="col-md-6">
              <label class="form-label">Phone</label>
              <input type="text" id="addPhone" class="form-control">
            </div>
          </div>

          <div class="row mb-3">
            <div class="col-md-4">
              <label class="form-label">Branch</label>
              <input type="text" id="addBranch" class="form-control">
            </div>
            <div class="col-md-4">
              <label class="form-label">Section</label>
              <input type="text" id="addSection" class="form-control">
            </div>
            <div class="col-md-4">
              <label class="form-label">Academic Year</label>
              <input type="text" id="addYear" class="form-control">
            </div>
          </div>

          <div class="row mb-3">
            <div class="col-md-6">
              <label class="form-label">Role</label>
              <select id="addRole" class="form-select">
                <option value="student">Student</option>
                <option value="leader">Leader</option>
                <option value="admin">Admin</option>
              </select>
            </div>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="closeUserModal()">Close</button>
        <button id="saveAddUserBtn" type="button" class="btn btn-success">Save User</button>
      </div>
    </div>
  </div>
</div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="JS/user_management.js"></script>
</body>
</html>