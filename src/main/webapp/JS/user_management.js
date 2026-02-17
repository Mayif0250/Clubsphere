let users = [];
let filteredUsers = [];
const contextPath = document.body.dataset.contextPath;
document.addEventListener("DOMContentLoaded", () => {
  const tableBody = document.getElementById("tableBody");
  console.log("contextPath:", contextPath);

  fetch(`${contextPath}/get-all-users`)
    .then(res => res.json())
    .then(data => {
      console.log("✅ All users fetched:", data);
      users = data;
      filteredUsers = data;
      renderTable(users);
    })
    .catch(err => {
      console.error("❌ Error loading users:", err);
      tableBody.innerHTML = `<tr><td colspan="8" class="text-danger text-center">Error loading users.</td></tr>`;
    });

  // Add event listeners *after* DOM and data are ready
  document.getElementById('searchInput').addEventListener('input', applyFilters);
  document.getElementById('roleFilter').addEventListener('change', applyFilters);
  document.getElementById('statusFilter').addEventListener('change', applyFilters);
});
function deleteUser(id) {
  if (!confirm("Are you sure you want to delete this user?")) return;

  fetch(`${contextPath}/delete-user`, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: `id=${id}`
  })
    .then(res => res.json())
    .then(result => {
      if (result.success) {
        alert("✅ User deleted");
        location.reload();
      } else {
        alert("❌ Failed to delete user");
      }
    });
}
// ==========================
// EDIT USER FUNCTIONALITY
// ==========================
function editUser(userId) {
  const user = users.find(u => u.id == userId);
  if (!user) {
    console.error("User not found for ID:", userId);
    return;
  }

  // Fill form with user data
  document.getElementById("editUserId").value = user.id;
  document.getElementById("editFirstName").value = user.firstName || "";
  document.getElementById("editLastName").value = user.lastName || "";
  document.getElementById("editEmail").value = user.email || user.rguktEmail || "";
  document.getElementById("editPhone").value = user.phone || user.phoneNumber || "";
  document.getElementById("editBranch").value = user.branch || "";
  document.getElementById("editSection").value = user.section || "";
  document.getElementById("editYear").value = user.academicYear || "";
  document.getElementById("editRole").value = (user.role || "student").toLowerCase();

  // Show modal
  const modal = new bootstrap.Modal(document.getElementById("editUserModal"));
  modal.show();

  // Remove old listeners before adding new one
  const saveBtn = document.getElementById("saveEditUserBtn");
  const newBtn = saveBtn.cloneNode(true);
  saveBtn.parentNode.replaceChild(newBtn, saveBtn);

  newBtn.addEventListener("click", function () {
    saveEditedUser(user);
  });
}

// ==========================
// SAVE UPDATED USER
// ==========================
function saveEditedUser(user) {
  const base = document.body.dataset.contextPath || "";
  const updatedUser = {
    id: document.getElementById("editUserId").value,
    firstName: document.getElementById("editFirstName").value.trim(),
    lastName: document.getElementById("editLastName").value.trim(),
    rguktEmail: document.getElementById("editEmail").value.trim(),
    phoneNumber: document.getElementById("editPhone").value.trim(),
    branch: document.getElementById("editBranch").value.trim(),
    section: document.getElementById("editSection").value.trim(),
    academicYear: document.getElementById("editYear").value.trim(),
    role: document.getElementById("editRole").value.trim()
  };

  fetch(`${base}/update-user`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(updatedUser)
  })
    .then((res) => res.text())
    .then((text) => {
      let data;
      try {
        data = JSON.parse(text);
      } catch (e) {
        console.error("Invalid JSON:", text);
        showToast("⚠️ Invalid server response.", "danger");
        return;
      }

      if (data.status === "success") {
        Object.assign(user, updatedUser);
        renderTable(users);
        const modalEl = document.getElementById("editUserModal");
        const modalInstance = bootstrap.Modal.getInstance(modalEl);
        modalInstance.hide();
        showToast("✅ User updated successfully!");
      } else {
        showToast("❌ Update failed. Try again.", "danger");
      }
    })
    .catch((err) => {
      console.error("Error updating user:", err);
      showToast("⚠️ Server error occurred.", "danger");
    });
}

// ==========================
// TOAST ALERT (nice alert box)
// ==========================
function showToast(message, type = "success") {
  const toast = document.createElement("div");
  toast.className = `alert alert-${type} position-fixed bottom-0 end-0 m-3 fade show shadow`;
  toast.style.zIndex = "9999";
  toast.textContent = message;
  document.body.appendChild(toast);

  setTimeout(() => {
    toast.classList.remove("show");
    setTimeout(() => toast.remove(), 300);
  }, 3000);
}



// ✅ FIXED: Apply filters correctly
function applyFilters() {
  const searchTerm = document.getElementById('searchInput').value.toLowerCase();
  const roleFilter = document.getElementById('roleFilter').value.toLowerCase();
  const statusFilter = document.getElementById('statusFilter').value.toLowerCase();

  filteredUsers = users.filter(user => {
    const name = `${user.firstName || ''} ${user.lastName || ''}`.toLowerCase();
    const email = (user.email || '').toLowerCase();
    const studentId = (user.studentId || '').toLowerCase();
    const role = (user.role || '').toLowerCase();
    const status = (user.status || '').toLowerCase();

    const matchesSearch =
      name.includes(searchTerm) ||
      email.includes(searchTerm) ||
      studentId.includes(searchTerm);

    // ✅ Fix: if roleFilter is empty or 'all', show everyone
    const matchesRole =
      !roleFilter || roleFilter === 'all' || role === roleFilter;

    // ✅ Same logic for status
    const matchesStatus =
      !statusFilter || statusFilter === 'all' || status === statusFilter;

    return matchesSearch && matchesRole && matchesStatus;
  });

  renderTable(filteredUsers);
}
function viewUser(userId) {
    const user = users.find(u => u.id == userId);
    if (!user) return;

    const detailsBody = document.getElementById('userDetailsBody');
    detailsBody.innerHTML = `
        <div class="user-detail-row">
            <div class="row">
                <div class="col-5 detail-label">Student ID:</div>
                <div class="col-7 detail-value">${user.studentId || '-'}</div>
            </div>
        </div>

        <div class="user-detail-row">
            <div class="row">
                <div class="col-5 detail-label">Full Name:</div>
                <div class="col-7 detail-value">${user.firstName || ''} ${user.lastName || ''}</div>
            </div>
        </div>

        <div class="user-detail-row">
            <div class="row">
                <div class="col-5 detail-label">Email:</div>
                <div class="col-7 detail-value">${user.email || user.rguktEmail || '-'}</div>
            </div>
        </div>

        <div class="user-detail-row">
            <div class="row">
                <div class="col-5 detail-label">Phone:</div>
                <div class="col-7 detail-value">${user.phone || user.phoneNumber || '-'}</div>
            </div>
        </div>

        <div class="user-detail-row">
            <div class="row">
                <div class="col-5 detail-label">Branch:</div>
                <div class="col-7 detail-value">${user.branch || '-'}</div>
            </div>
        </div>

        <div class="user-detail-row">
            <div class="row">
                <div class="col-5 detail-label">Section:</div>
                <div class="col-7 detail-value">${user.section || '-'}</div>
            </div>
        </div>

        <div class="user-detail-row">
            <div class="row">
                <div class="col-5 detail-label">Academic Year:</div>
                <div class="col-7 detail-value">${user.academicYear || '-'}</div>
            </div>
        </div>

        <div class="user-detail-row">
            <div class="row">
                <div class="col-5 detail-label">Role:</div>
                <div class="col-7 detail-value">
                    <span class="badge-role badge-${(user.role || 'unknown').toLowerCase()}">
                        ${user.role || 'Unknown'}
                    </span>
                </div>
            </div>
        </div>

        <div class="user-detail-row">
            <div class="row">
                <div class="col-5 detail-label">Registration Date:</div>
                <div class="col-7 detail-value">${user.registrationDate || '-'}</div>
            </div>
        </div>

        <div class="user-detail-row">
            <div class="row">
                <div class="col-5 detail-label">Bio:</div>
                <div class="col-7 detail-value">${user.bio || '—'}</div>
            </div>
        </div>

        <div class="user-detail-row">
            <div class="row">
                <div class="col-5 detail-label">Interests:</div>
                <div class="col-7 detail-value">${user.interests || '—'}</div>
            </div>
        </div>
    `;

    const modal = new bootstrap.Modal(document.getElementById('viewUserModal'));
    modal.show();
}
function closeUserModal() {
    const modalEl = document.getElementById('viewUserModal');
    const modal = bootstrap.Modal.getInstance(modalEl);
    if (modal) {
        document.activeElement.blur(); // remove focus to avoid aria-hidden warning
        modal.hide();
    }
}
function openAddUserModal() {
  // Reset form
  document.getElementById("addUserForm").reset();

  // Open modal
  const modal = new bootstrap.Modal(document.getElementById("addUserModal"));
  modal.show();

  // Attach click event
  const saveBtn = document.getElementById("saveAddUserBtn");
  saveBtn.onclick = saveNewUser;
}

function saveNewUser() {
  const newUser = {
    firstName: document.getElementById("addFirstName").value.trim(),
    lastName: document.getElementById("addLastName").value.trim(),
    rguktEmail: document.getElementById("addEmail").value.trim(),
    phoneNumber: document.getElementById("addPhone").value.trim(),
    branch: document.getElementById("addBranch").value.trim(),
    section: document.getElementById("addSection").value.trim(),
    academicYear: document.getElementById("addYear").value.trim(),
    role: document.getElementById("addRole").value.trim()
  };

  // ✅ Send POST request to backend
  fetch(`${contextPath}/add-user`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(newUser)
  })
    .then(res => res.json())
    .then(data => {
      if (data.status === "success") {
        users.push(data.user);
        renderTable(users);
        showToast("✅ User added successfully!");

        // Close modal
        const modalEl = document.getElementById("addUserModal");
        const modal = bootstrap.Modal.getInstance(modalEl);
        modal.hide();
      } else {
        showToast("❌ Failed to add user.", "danger");
      }
    })
    .catch(err => {
      console.error("Error adding user:", err);
      showToast("⚠️ Server error while adding user.", "danger");
    });
}



// ✅ FIXED: Render table safely
function renderTable(data) {
  const tableBody = document.getElementById('tableBody');
  const emptyState = document.getElementById('emptyState');

  if (!data || data.length === 0) {
    tableBody.innerHTML = '';
    emptyState.classList.remove('d-none');
    return;
  }

  emptyState.classList.add('d-none');

  tableBody.innerHTML = data.map(user => `
    <tr>
      <td><strong>${user.studentId || '-'}</strong></td>
      <td>${user.firstName || ''} ${user.lastName || ''}</td>
      <td>${user.rguktEmail || '-'}</td>
      <td>${user.phoneNumber || '-'}</td>
      <td>${user.branch || '-'}</td>
      <td>${user.academicYear || '-'}</td>
      <td>
        <span class="badge-role badge-${(user.role || 'unknown').toLowerCase()}">
          ${user.role || 'Unknown'}
        </span>
      </td>
      <td>${user.registrationDate || '-'}</td>
      <td>
        <div class="action-buttons">
          <button class="btn-action btn-view" onclick="viewUser('${user.id}')">
            <i class="bi bi-eye"></i>
          </button>
          <button class="btn-action btn-edit" onclick="editUser(${user.id})">
            <i class="bi bi-pencil"></i>
          </button>
          <button class="btn-action btn-delete" onclick="deleteUser('${user.id}')">
            <i class="bi bi-trash"></i>
          </button>
        </div>
      </td>
    </tr>
  `).join('');
}
