// Global variables
       let currentEventId = null;
       let currentMemberId = null;

       // Initialize
	   document.addEventListener('DOMContentLoaded', () => {
	       // --- Get clubId from session (injected by JSP) ---
		   const body = document.body;
		   const clubId = body.dataset.clubId;
		   const contextPath = body.dataset.contextPath;
	       const tableBody = document.getElementById("membersTableBody");
	       console.log("fetching members for club_id:", clubId);

	       // =============================
	       // 1️⃣ MENU SECTION HANDLING
	       // =============================
	       const menuItems = document.querySelectorAll('.menu-item[data-section]');
	       menuItems.forEach(item => {
	           item.addEventListener('click', function() {
	               const section = this.getAttribute('data-section');
	               switchSection(section);
	           });
	       });

	       // =============================
	       // 2️⃣ MEMBER SEARCH HANDLING
	       // =============================
	       const memberSearch = document.getElementById('member-search');
	       if (memberSearch) {
	           memberSearch.addEventListener('input', function() {
	               filterMembers(this.value);
	           });
	       }

	       // =============================
	       // 3️⃣ FETCH MEMBERS AUTOMATICALLY
	       // =============================
	       if (clubId && tableBody) {
	           fetch(`${contextPath}/get-members?club_id=${clubId}`)
	               .then(res => {
	                   console.log("Response status:", res.status);
	                   return res.json();
	               })
	               .then(data => {
	                   console.log("✅ Fetched members:", data);
	                   tableBody.innerHTML = "";

	                   if (!Array.isArray(data) || data.length === 0) {
	                       tableBody.innerHTML = `
	                           <tr><td colspan="4" class="text-center text-muted">No members found</td></tr>`;
	                       
	                       return;
	                   }

	                   

	                   data.forEach(member => {
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
	               })
	               .catch(err => {
	                   console.error("❌ Error fetching members:", err);
	                   tableBody.innerHTML = `
	                       <tr><td colspan="4" class="text-danger text-center">Error loading members.</td></tr>`;
	               });
	       }
	   });

	   // =============================
	   // Helper Functions (outside DOMContentLoaded)
	   // =============================

	   // Switch between sections
	   function switchSection(sectionId) {
	       const menuItems = document.querySelectorAll('.menu-item');
	       menuItems.forEach(item => {
	           item.classList.remove('active');
	           if (item.getAttribute('data-section') === sectionId) {
	               item.classList.add('active');
	           }
	       });

	       const sections = document.querySelectorAll('.content-section');
	       sections.forEach(section => section.classList.remove('active'));
	       document.getElementById(sectionId).classList.add('active');

	       if (window.innerWidth <= 768) toggleMobileSidebar();
	   }

	   // Member filtering
	   function filterMembers(searchTerm) {
	       const rows = document.querySelectorAll('#membersTableBody tr');
	       const term = searchTerm.toLowerCase();
	       rows.forEach(row => {
	           const name = row.querySelector('td:first-child').textContent.toLowerCase();
	           const role = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
	           row.style.display = (name.includes(term) || role.includes(term)) ? '' : 'none';
	       });
	   }

	   // Sidebar toggler (if you use mobile sidebar)
	   function toggleMobileSidebar() {
	       const sidebar = document.getElementById('sidebar');
	       const overlay = document.querySelector('.sidebar-overlay');
	       sidebar.classList.toggle('active');
	       overlay.classList.toggle('active');
	   }


       // Switch between sections
       function switchSection(sectionId) {
           // Update active menu item
           const menuItems = document.querySelectorAll('.menu-item');
           menuItems.forEach(item => {
               item.classList.remove('active');
               if (item.getAttribute('data-section') === sectionId) {
                   item.classList.add('active');
               }
           });

           // Update active section
           const sections = document.querySelectorAll('.content-section');
           sections.forEach(section => {
               section.classList.remove('active');
           });
           document.getElementById(sectionId).classList.add('active');

           // Close mobile sidebar
           if (window.innerWidth <= 768) {
               toggleMobileSidebar();
           }
       }

       // Toggle sidebar (desktop)
       function toggleSidebar() {
           const sidebar = document.getElementById('sidebar');
           sidebar.classList.toggle('collapsed');
       }

       // Toggle mobile sidebar
       function toggleMobileSidebar() {
           const sidebar = document.getElementById('sidebar');
           const overlay = document.querySelector('.sidebar-overlay');
           sidebar.classList.toggle('active');
           overlay.classList.toggle('active');
       }



       // Member Functions
       function filterMembers(searchTerm) {
           const rows = document.querySelectorAll('#members-table-body tr');
           const term = searchTerm.toLowerCase();
           
           rows.forEach(row => {
               const name = row.querySelector('td:first-child').textContent.toLowerCase();
               const role = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
               
               if (name.includes(term) || role.includes(term)) {
                   row.style.display = '';
               } else {
                   row.style.display = 'none';
               }
           });
       }

       function editMember(memberId) {
           // In a real app, you would open a modal with member data
           showAlert('Edit member functionality would open a modal here', 'info');
       }

       function removeMember(memberId) {
           if (confirm('Are you sure you want to remove this member?')) {
               // In a real app, you would delete from database
               showAlert('Member removed successfully', 'success');
           }
       }

       // Announcement Functions
	   async function loadAnnouncements() {
	       const container = document.getElementById("announcements-list");
	       if (!container) {
	           console.error("❌ announcements-list element not found in DOM");
	           return;
	       }

	       container.innerHTML = `<p>Loading announcements...</p>`;

	       try {
	           const response = await fetch(`${window.location.origin}/ClubSphere/FetchAnnouncementsServlet`);
	           console.log("Response status:", response.status);

	           if (!response.ok) throw new Error("Failed to fetch announcements");

	           const data = await response.json();
	           console.log("✅ Announcements fetched:", data);

	           const announcements = data.announcements;
	           if (!announcements || announcements.length === 0) {
	               container.innerHTML = `<p>No announcements available.</p>`;
	               return;
	           }

	           container.innerHTML = ""; // clear container
	           announcements.forEach(a => {
	               const card = document.createElement("div");
	               card.classList.add("announcement-card");

	               const date = new Date(a.created_at).toLocaleString("en-IN", {
	                   dateStyle: "medium",
	                   timeStyle: "short"
	               });

	               card.innerHTML = `
	                   <div class="announcement-header">
	                       <div class="announcement-title">${a.title}</div>
	                       <div class="announcement-date">${date}</div>
	                   </div>
	                   <div class="announcement-message">${a.message}</div>
	               `;
	               container.appendChild(card);
	           });

	       } catch (error) {
	           console.error("❌ Error loading announcements:", error);
	           container.innerHTML = `<p>Failed to load announcements.</p>`;
	       }
	   }
	   document.addEventListener("DOMContentLoaded", () => {
	       loadAnnouncements();
	   });
	   document.addEventListener('DOMContentLoaded', () => {
	       const form = document.getElementById('announcementForm');
	       const statusText = document.getElementById('announcementStatus');
		   // Get from <body data-club-id="..."> injected by JSP
		   const clubId = document.body.dataset.clubId;
		   const contextPath = document.body.dataset.contextPath;

		   if (clubId) {
		       const targetClubIdField = document.getElementById('targetClubId');
		       if (targetClubIdField) targetClubIdField.value = clubId;
		   }


	       form.addEventListener('submit', async (e) => {
	           e.preventDefault();

	           const formData = new URLSearchParams();
	           formData.append("title", document.getElementById('announcementTitle').value);
	           formData.append("message", document.getElementById('announcementMessage').value);
	           formData.append("target_type", "specific");
	           formData.append("target_club_id", clubId);

	           try {
	               const response = await fetch(`${window.location.origin}/ClubSphere/AnnouncementServlet`, {
	                   method: 'POST',
	                   headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
	                   body: formData.toString()
	               });

	               const result = await response.json();
	               if (result.status === 'success') {
	                   statusText.textContent = "✅ Announcement sent successfully!";
	                   statusText.style.color = "green";
	                   form.reset();
	               } else {
	                   statusText.textContent = "❌ " + result.message;
	                   statusText.style.color = "red";
	               }
	           } catch (err) {
	               console.error("Error:", err);
	               statusText.textContent = "❌ Failed to send announcement.";
	               statusText.style.color = "red";
	           }
	       });
	   });



       // Settings Functions
       function saveSettings() {
           const clubName = document.getElementById('club-name').value;
           const clubDescription = document.getElementById('club-description').value;
           
           if (!clubName) {
               showAlert('Club name is required', 'error');
               return;
           }
           
           // Update club name in sidebar
           document.querySelector('.club-name').textContent = clubName;
           
           showAlert('Settings saved successfully', 'success');
       }

       function saveNotificationSettings() {
           showAlert('Notification preferences saved', 'success');
       }

       // Logout Function
	   function logout() {
	       if (confirm('Are you sure you want to logout?')) {
	           // Simply redirect to the servlet URL
	           window.location.href = 'LogoutServlet';
	       }
	   }
	   /**------------------------------------------------------------------- */
	   async function loadEvents() {
	       try {
	           const role = userRole; // "leader" or "admin"
	           const clubId = currentClubId; // from session or context

	           const response = await fetch(`${window.location.origin}/ClubSphere/FetchEventsServlet?role=${role}&club_id=${clubId}`);
	           const data = await response.json();

	           const tbody = document.getElementById("events-table-body");
	           tbody.innerHTML = "";

	           if (!data.events || data.events.length === 0) {
	               tbody.innerHTML = `<tr><td colspan="4" style="text-align:center;">No events available.</td></tr>`;
	               return;
	           }

	           data.events.forEach(e => {
	               const row = document.createElement("tr");
	               row.innerHTML = `
	                   <td>${e.title}</td>
	                   <td>${e.date}</td>
	                   <td><span class="status-badge ${e.status === "approved" ? "approved" : "pending"}">${e.status}</span></td>
	                   <td>
	                       <button class="btn btn-secondary btn-sm" onclick="editEvent(${e.id})">Edit</button>
	                       <button class="btn btn-danger btn-sm" onclick="deleteEvent(${e.id})">Delete</button>
	                   </td>
	               `;
	               tbody.appendChild(row);
	           });

	       } catch (err) {
	           console.error("❌ Error loading events:", err);
	       }
	   }

	   // Auto-load events when page opens
	   document.addEventListener("DOMContentLoaded", loadEvents);
	   
	   // 🌟 Open Event Modal
	   function openEventModal() {
	       // Fill hidden inputs using JSP-injected values
	       document.getElementById("created_by").value = userId;
	       document.getElementById("club_id").value = clubId;
	       document.getElementById("role").value = userRole;

	       // Show modal
	       const modal = document.getElementById("event-modal");
	       modal.style.display = "flex";
	       setTimeout(() => modal.classList.add("active"), 10);
	   }


	   // 🌟 CLOSE Event Modal
	   function closeEventModal() {
	     const modal = document.getElementById("event-modal");
	     if (!modal) return;
	     
	     modal.classList.remove("active");
	     setTimeout(() => {
	       modal.style.display = "none";
	     }, 200);
	   }

	   // Optional: close modal when clicking backdrop
	   window.addEventListener("click", (e) => {
	     const modal = document.getElementById("event-modal");
	     if (e.target === modal) closeEventModal();
	   });

	   async function saveEvent() {
	       const title = document.getElementById("event-title").value.trim();
	       const description = document.getElementById("event-description").value.trim();
	       const date = document.getElementById("event-date").value;
	       const venue = document.getElementById("event-venue").value.trim();

	       const createdBy = document.getElementById("created_by").value;
	       const clubId = document.getElementById("club_id").value;
	       const role = document.getElementById("role").value;

	       if (!title || !description || !date || !venue) {
	           alert("⚠️ Please fill in all fields.");
	           return;
	       }

	       const formData = new FormData();
	       formData.append("title", title);
	       formData.append("description", description);
	       formData.append("date", date);
	       formData.append("venue", venue);
	       formData.append("created_by", createdBy);
	       formData.append("club_id", clubId);
	       formData.append("role", role);

	       try {
			console.log("📡 Sending event create request to:", `${window.location.origin}/ClubSphere/CreateEventServlet`);

	           const response = await fetch(`${window.location.origin}/ClubSphere/CreateEventServlet`, {
	               method: "POST",
	               body: formData
	           });

	           const data = await response.json();
	           console.log("📅 Event creation response:", data);

	           if (data.success) {
	               alert("🎉 " + data.message);
	               closeEventModal();
	               loadEvents(); // reload events dynamically
	           } else {
	               alert("⚠️ " + data.message);
	           }
	       } catch (error) {
	           console.error("❌ Error creating event:", error);
	           alert("Error creating event. Please try again.");
	       }
	   }
	   document.addEventListener("DOMContentLoaded", () => {
	     const modal = document.getElementById("event-modal");
	     if (modal) {
	       modal.classList.remove("active");
	       modal.style.display = "none";
	     }
	   });




		/**---------------------------------------------------------------- */
       // Alert Function
       function showAlert(message, type = 'info') {
           const alertContainer = document.getElementById('alert-container');
           const alert = document.createElement('div');
           alert.className = `alert ${type}`;
           
           let icon = '';
           if (type === 'success') {
               icon = '<svg class="alert-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>';
           } else if (type === 'error') {
               icon = '<svg class="alert-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>';
           } else {
               icon = '<svg class="alert-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>';
           }
           
           alert.innerHTML = `
               ${icon}
               <div class="alert-message">${message}</div>
               <div class="alert-close" onclick="this.parentElement.remove()">
                   <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                       <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                   </svg>
               </div>
           `;
           
           alertContainer.appendChild(alert);
           
           // Auto remove after 5 seconds
           setTimeout(() => {
               if (alert.parentElement) {
                   alert.remove();
               }
           }, 5000);
       }

       // Utility Functions
       function formatDate(dateString) {
           const date = new Date(dateString);
           return date.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' });
       }