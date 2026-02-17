document.addEventListener("DOMContentLoaded", () => {
  const body = document.body;
  const clubId = body.dataset.clubId;
  const contextPath = body.dataset.contextPath;
  const tableBody = document.getElementById("membersTableBody");
  const displayCount = document.getElementById("displayCount");

  // Global variables
  window.membersData = [];
  window.filteredMembers = [];
  window.currentFilter = "all"; // can be 'all', 'leader', 'student', etc.

  console.log("fetching members for club_id:", clubId);

  fetch(`${contextPath}/get-members?club_id=${clubId}`)
    .then(res => {
      console.log("Response status:", res.status);
      return res.json();
    })
    .then(data => {
      console.log("✅ Fetched members:", data);
      if (!Array.isArray(data) || data.length === 0) {
        tableBody.innerHTML = `<tr><td colspan="4" class="text-center text-muted">No members found</td></tr>`;
        displayCount.textContent = "0";
        return;
      }

      // Save globally
      window.membersData = data;
      window.filteredMembers = data;

      // Render all members initially
      renderMembers();
    })
    .catch(err => {
      console.error("❌ Error fetching members:", err);
      tableBody.innerHTML = `
        <tr><td colspan="4" class="text-danger text-center">Error loading members.</td></tr>`;
    });
});


// ✅ Function to render members in the table
function renderMembers() {
  const tableBody = document.getElementById("membersTableBody");
  const displayCount = document.getElementById("displayCount");

  tableBody.innerHTML = "";

  if (filteredMembers.length === 0) {
    tableBody.innerHTML = `<tr><td colspan="4" class="text-center text-muted">No members found</td></tr>`;
    displayCount.textContent = "0";
    return;
  }

  displayCount.textContent = filteredMembers.length;

  filteredMembers.forEach(member => {
    const row = document.createElement("tr");
    row.innerHTML = `
      <td>
        <div class="d-flex align-items-center">
          <div class="bg-primary text-white fw-bold rounded-circle me-2"
               style="width:40px;height:40px;display:flex;align-items:center;justify-content:center;">
            ${member.avatar || "U"}
          </div>
          <div>
            <div class="fw-semibold">${member.name || "-"}</div>
            <div class="text-muted small">${member.email || ""}</div>
          </div>
        </div>
      </td>
      <td>${member.role || "-"}</td>
      <td>${member.branch || "-"} ${member.section ? "- " + member.section : ""}</td>
      <td>${member.joinedDate || "-"}</td>
    `;
    tableBody.appendChild(row);
  });
}


// ✅ Search Function
function filterMembers() {
  const searchTerm = document.getElementById('searchInput').value.toLowerCase();

  filteredMembers = membersData.filter(member => {
    const matchesSearch =
      (member.name && member.name.toLowerCase().includes(searchTerm)) ||
      (member.rollNo && member.rollNo.toLowerCase().includes(searchTerm));

    const matchesRole = currentFilter === 'all' || member.role === currentFilter;

    return matchesSearch && matchesRole;
  });

  renderMembers();
}
function filterByRole(role, event) {
  currentFilter = role;

  // Update active button
  document.querySelectorAll('.filter-btn').forEach(btn => {
    btn.classList.remove('active');
  });

  event.target.classList.add('active');

  filterMembers();
}
// ✅ Working CSV download function
function downloadCSV() {
  if (!window.membersData || window.membersData.length === 0) {
    alert("No members to download!");
    return;
  }

  const headers = ['Name', 'Email', 'Role', 'Joined Date'];
  const rows = window.membersData.map(member => [
    member.name || "-",
    member.email || "-",
    member.role || "-",
    member.joinedDate || "-"
  ]);

  let csvContent = headers.join(',') + '\n';
  rows.forEach(row => {
    csvContent += row.join(',') + '\n';
  });

  const blob = new Blob([csvContent], { type: 'text/csv' });
  const url = window.URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = 'club_members_' + new Date().toISOString().split('T')[0] + '.csv';
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  window.URL.revokeObjectURL(url);
}