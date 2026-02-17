const contextPath = document.body.dataset.contextPath;
window.announcements = [];
// Navigation
        function navigateTo(sectionId) {
            // Hide all sections
            const sections = document.querySelectorAll('.content-section');
            sections.forEach(section => {
                section.classList.remove('active');
            });

            // Show selected section
            const targetSection = document.getElementById(sectionId);
            if (targetSection) {
                targetSection.classList.add('active');
            }

            // Update active nav link
            const navLinks = document.querySelectorAll('.nav-link');
            navLinks.forEach(link => {
                link.classList.remove('active');
            });
            event.currentTarget.classList.add('active');

            // Close mobile sidebar if open
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.remove('mobile-open');
        }

        // Sidebar Toggle
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('collapsed');
        }

        function toggleMobileSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('mobile-open');
        }

        // Profile Dropdown
        function toggleProfileDropdown() {
            const dropdown = document.getElementById('profileDropdown');
            dropdown.classList.toggle('show');
            event.stopPropagation();
        }

        // Close dropdown when clicking outside
        document.addEventListener('click', function(event) {
            const dropdown = document.getElementById('profileDropdown');
            const profileSection = document.querySelector('.profile-section');
            
            if (!profileSection.contains(event.target)) {
                dropdown.classList.remove('show');
            }
        });

        // Search Functionality
        function handleSearch(event) {
            if (event.key === 'Enter') {
                const searchTerm = document.getElementById('searchInput').value;
                if (searchTerm.trim()) {
                    alert(`Searching for: "${searchTerm}"\n\nSearch functionality will filter clubs, members, and events based on your query.`);
                }
            }
        }

        // Notifications
        function showNotifications() {
            alert('Notifications:\n\n• 3 new club registration requests\n• Upcoming event: TechFest 2025 tomorrow\n• Budget approval pending for Cultural Arts Society\n• New announcement published\n• 5 members joined today');
        }

        // Logout
		function logout() {
			       if (confirm('Are you sure you want to logout?')) {
			           // Simply redirect to the servlet URL
			           window.location.href = 'LogoutServlet';
			       }
			   }

        // Add Announcement
        function addAnnouncement(event) {
            event.preventDefault();
            
            const title = document.getElementById('announcementTitle').value;
            const message = document.getElementById('announcementMessage').value;
            
            if (title && message) {
                const announcementsList = document.getElementById('announcementsList');
                const today = new Date().toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' });
                
                const newAnnouncement = document.createElement('div');
                newAnnouncement.className = 'announcement-item';
                newAnnouncement.innerHTML = `
                    <div class="announcement-header">
                        <div class="announcement-title">${title}</div>
                        <div class="announcement-date">${today}</div>
                    </div>
                    <div class="announcement-content">${message}</div>
                `;
                
                announcementsList.insertBefore(newAnnouncement, announcementsList.firstChild);
                
                // Reset form
                document.getElementById('announcementTitle').value = '';
                document.getElementById('announcementMessage').value = '';
                
                alert('Announcement published successfully!');
            }
        }

        // Save Settings
        function saveSettings(event) {
            event.preventDefault();
            alert('Profile settings saved successfully!');
        }

        // Animate bars on page load
        window.addEventListener('load', function() {
            const bars = document.querySelectorAll('.bar');
            bars.forEach((bar, index) => {
                setTimeout(() => {
                    bar.style.opacity = '1';
                }, index * 100);
            });
        });

        // Add smooth scroll behavior
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Table row click animation
        document.querySelectorAll('tbody tr').forEach(row => {
            row.addEventListener('click', function(e) {
                if (!e.target.closest('button')) {
                    this.style.transform = 'scale(0.99)';
                    setTimeout(() => {
                        this.style.transform = 'scale(1)';
                    }, 100);
                }
            });
        });

        // Initialize tooltips and animations
        document.addEventListener('DOMContentLoaded', function() {
            // Fade in stat cards
            const statCards = document.querySelectorAll('.stat-card');
            statCards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
            });

            // Add hover effect to buttons
            const buttons = document.querySelectorAll('.btn');
            buttons.forEach(button => {
                button.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-2px)';
                });
                button.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });

            // Animate chart bars
            const chartBars = document.querySelectorAll('.bar');
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.animation = 'growBar 0.8s ease forwards';
                    }
                });
            }, { threshold: 0.1 });

            chartBars.forEach(bar => {
                observer.observe(bar);
            });
        });

        // Handle responsive behavior
        function handleResize() {
            const sidebar = document.getElementById('sidebar');
            const width = window.innerWidth;
            
            if (width > 768) {
                sidebar.classList.remove('mobile-open');
            }
        }

        window.addEventListener('resize', handleResize);

        // Add keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Alt + D for Dashboard
            if (e.altKey && e.key === 'd') {
                navigateTo('dashboard');
                document.querySelector('[onclick*="dashboard"]').click();
            }
            // Alt + C for Clubs
            if (e.altKey && e.key === 'c') {
                navigateTo('clubs');
                document.querySelectorAll('.nav-link')[1].click();
            }
            // Alt + M for Members
            if (e.altKey && e.key === 'm') {
                navigateTo('members');
                document.querySelectorAll('.nav-link')[2].click();
            }
            // Alt + E for Events
            if (e.altKey && e.key === 'e') {
                navigateTo('events');
                document.querySelectorAll('.nav-link')[3].click();
            }
            // Escape to close dropdown
            if (e.key === 'Escape') {
                document.getElementById('profileDropdown').classList.remove('show');
            }
        });

        // Form validation enhancement
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('blur', function() {
                if (this.value.trim() === '' && this.hasAttribute('required')) {
                    this.style.borderColor = 'var(--danger)';
                } else {
                    this.style.borderColor = 'var(--border-color)';
                }
            });

            input.addEventListener('focus', function() {
                this.style.borderColor = 'var(--accent-blue)';
            });
        });

        // Add loading state simulation
        function showLoading() {
            const loader = document.createElement('div');
            loader.id = 'loader';
            loader.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(255,255,255,0.9);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 9999;
            `;
            loader.innerHTML = '<div style="width: 50px; height: 50px; border: 4px solid var(--silver); border-top-color: var(--accent-blue); border-radius: 50%; animation: spin 1s linear infinite;"></div>';
            document.body.appendChild(loader);

            setTimeout(() => {
                loader.remove();
            }, 500);
        }

        // Add spin animation for loader
        const style = document.createElement('style');
        style.textContent = `
            @keyframes spin {
                to { transform: rotate(360deg); }
            }
        `;
        document.head.appendChild(style);

        // Simulate data refresh
        function refreshData() {
            showLoading();
            setTimeout(() => {
                alert('Data refreshed successfully!');
            }, 600);
        }

        // Add context menu prevention for professional feel
        document.addEventListener('contextmenu', function(e) {
            if (e.target.tagName === 'TD' || e.target.closest('table')) {
                // Allow context menu on tables for data operations
                return true;
            }
        });

        // Smooth transitions for section changes
        const sections = document.querySelectorAll('.content-section');
        const navLinksAll = document.querySelectorAll('.nav-link');
        
        navLinksAll.forEach((link, index) => {
            link.addEventListener('click', function() {
                showLoading();
            });
        });

        // Add success feedback for form submissions
        document.querySelectorAll('form').forEach(form => {
            form.addEventListener('submit', function(e) {
                const submitBtn = this.querySelector('button[type="submit"]');
                if (submitBtn) {
                    const originalText = submitBtn.textContent;
                    submitBtn.textContent = 'Saving...';
                    submitBtn.disabled = true;
                    
                    setTimeout(() => {
                        submitBtn.textContent = originalText;
                        submitBtn.disabled = false;
                    }, 1000);
                }
            });
        });
		document.addEventListener("DOMContentLoaded", () => {
		  fetch(`${window.location.origin}/ClubSphere/get-club-leaders`)
		    .then(response => {
		      if (!response.ok) throw new Error("Network error " + response.status);
		      return response.json();
		    })
		    .then(leaders => {
		      console.log("✅ Leaders fetched:", leaders);
		      const memberGrid = document.querySelector(".member-grid");
		      memberGrid.innerHTML = ""; // clear existing cards

		      leaders.forEach(leader => {
		        const initials = leader.name
		          .split(" ")
		          .map(n => n[0])
		          .join("")
		          .toUpperCase();

		        const card = document.createElement("div");
		        card.classList.add("member-card");
		        card.innerHTML = `
		          <div class="member-header">
		            <div class="member-avatar">${initials}</div>
		            <div>
		              <div class="member-name">${leader.name}</div>
		              <div class="member-role">${leader.role.replace("_", " ")}</div>
		            </div>
		          </div>
		          <div class="member-details">
		            <div><strong>Club:</strong> ${leader.club_name}</div>
		            <div><strong>Email:</strong> ${leader.email}</div>
		            <div><strong>Contact:</strong> ${leader.contact || "N/A"}</div>
		          </div>
		        `;
		        memberGrid.appendChild(card);
		      });
		    })
		    .catch(err => {
		      console.error("❌ Error fetching club leaders:", err);
		    });
		});
		async function loadApprovals() {
		    try {
		        const response = await fetch("get-approvals");
		        if (!response.ok) throw new Error("Network error");

		        const data = await response.json();
		        console.log("Fetched approvals:", data);

		        const tbody = document.querySelector("#approvals-table tbody");
		        tbody.innerHTML = "";

		        if (data.length === 0) {
		            tbody.innerHTML = "<tr><td colspan='5' style='text-align:center;'>No pending approvals</td></tr>";
		            return;
		        }

				data.forEach(req => {
				    const row = document.createElement("tr");
				    row.innerHTML = `
				        <td><strong>${req.club_name}</strong></td>
				        <td>${req.requested_by}</td>
				        <td>--</td>
				        <td>${req.requested_at}</td>
				        <td>
				            <div class="action-buttons">
				                <button class="btn btn-primary btn-sm" onclick="updateApproval(${req.request_id}, 'approve')">Approve</button>
				                <button class="btn btn-secondary btn-sm" style="background: var(--danger); color: white;" onclick="updateApproval(${req.request_id}, 'reject')">Reject</button>
				            </div>
				        </td>`;
				    tbody.appendChild(row);
				});


		    } catch (err) {
		        console.error("Error loading approvals:", err);
		    }
		}

		async function updateApproval(requestId, actionType) {
		    try {
		        console.log("Updating approval:", { requestId, actionType }); // 🪶 Debug log

		        const formData = new FormData();
		        formData.append("requestId", requestId);
		        formData.append("actionType", actionType);

		        const response = await fetch(`${window.location.origin}/ClubSphere/update-approval`, {
		            method: "POST",
		            body: formData
		        });

		        if (!response.ok) {
		            const text = await response.text();
		            console.error("Server response:", text);
		            throw new Error("Failed to update approval");
		        }

		        const data = await response.json();
		        alert(data.message || "Request " + actionType + " successful!");
		        loadApprovals();

		    } catch (err) {
		        console.error("Error updating approval:", err);
		    }
		}
		window.addEventListener("DOMContentLoaded", loadApprovals);
		
		async function loadClubs() {
		    try {
		        const response = await fetch(`${window.location.origin}/ClubSphere/get-clubs`);
		        if (!response.ok) throw new Error("Network error");

				window.clubs = await response.json();
				const clubs = window.clubs;

		        console.log("✅ Clubs fetched:", clubs);

		        const tbody = document.getElementById("clubsTableBody");
		        tbody.innerHTML = "";

		        if (clubs.length === 0) {
		            tbody.innerHTML = `<tr><td colspan="5" style="text-align:center;">No clubs found</td></tr>`;
		            return;
		        }

		        clubs.forEach(club => {
		            const statusBadge = club.status === "Active"
		                ? `<span class="badge badge-success">Active</span>`
		                : `<span class="badge badge-warning">${club.status}</span>`;

		            const row = `
		                <tr>
		                    <td>${club.club_name}</td>
		                    <td>${club.leader_name || "—"}</td>
		                    <td>${club.member_count}</td>
		                    <td>${statusBadge}</td>
		                    <td>
		                        <div class="action-buttons">
		                            <button class="btn btn-secondary btn-sm" onclick="viewClub(${club.id})">View</button>
		                            <button class="btn btn-secondary btn-sm" onclick="editClub(${club.id})">Edit</button>
		                            <button class="btn btn-secondary btn-sm" onclick="deleteClub(${club.id})">Delete</button>
		                        </div>
		                    </td>
		                </tr>
		            `;
		            tbody.insertAdjacentHTML("beforeend", row);
		        });

		    } catch (error) {
		        console.error("❌ Error loading clubs:", error);
		    }
		}
		

		// Load clubs when dashboard loads
		document.addEventListener("DOMContentLoaded", loadClubs);
		
		function viewClub(id) {
		  const club = window.clubs?.find(c => c.id === id);
		  if (!club) return alert("Club not found!");

		  document.getElementById("modalClubName").textContent = club.club_name;
		  document.getElementById("modalClubLeader").textContent = club.leader_name || "—";
		  document.getElementById("modalClubCategory").textContent = club.category || "—";
		  document.getElementById("modalClubStatus").textContent = club.status || "—";
		  document.getElementById("modalClubMembers").textContent = club.member_count || "—";
		  document.getElementById("modalClubDescription").textContent = club.description || "No description available.";
		  document.getElementById("modalClubCreated").textContent = club.created_at || "—";
		  document.getElementById("modalClubEmail").textContent = club.email || "—";
		  document.getElementById("modalClubPhone").textContent = club.phone || "—";

		  document.getElementById("clubModal").style.display = "flex";
		}

		function closeClubModal() {
		  document.getElementById("clubModal").style.display = "none";
		}
		/*-------------------------------------------------------------------- */
		// ======================= ANNOUNCEMENTS =========================

		// Load all announcements
		async function loadAnnouncements() {
		    try {
		        const response = await fetch(`${window.location.origin}/ClubSphere/FetchAnnouncementsServlet`);
		        if (!response.ok) throw new Error("Network error");

		        const data = await response.json();
		        console.log("✅ Announcements fetched:", data);

				window.announcements = Array.isArray(data.announcements) ? data.announcements : data;
		        const container = document.getElementById("announcementsList");
		        container.innerHTML = "";

		        if (!Array.isArray(announcements) || announcements.length === 0) {
		            container.innerHTML = `<p style="text-align:center; color: gray;">No announcements available</p>`;
		            return;
		        }

		        announcements.forEach(ann => {
		            const date = new Date(ann.created_at).toLocaleDateString('en-US', {
		                year: 'numeric', month: 'short', day: 'numeric'
		            });

		            const targetLabel =
		                ann.target_type === "all" ? "All Members" :
		                ann.target_type === "leaders" ? "Club Leaders" :
		                ann.target_type === "specific" ? `Club ID: ${ann.target_club_id}` :
		                "—";

		            const card = document.createElement("div");
		            card.classList.add("announcement-item");
		            card.innerHTML = `
		                <div class="announcement-header">
		                    <div class="announcement-title">${ann.title}</div>
		                    <div class="announcement-date">${date}</div>
		                </div>
		                <div class="announcement-content">${ann.message}</div>
		                <div class="announcement-footer">
		                    <span class="badge badge-secondary">${targetLabel}</span>
		                    <span class="posted-by">Posted by Admin #${ann.created_by || '—'}</span>
		                </div>
		            `;
		            container.appendChild(card);
		        });

		    } catch (error) {
		        console.error("❌ Failed to load announcements:", error);
		        document.getElementById("announcementsList").innerHTML =
		            `<p style="color:red; text-align:center;">Failed to load announcements.</p>`;
		    }
		}


		// Add a new announcement
		async function addAnnouncement(event) {
		    event.preventDefault();

		    const title = document.getElementById("announcementTitle").value.trim();
		    const message = document.getElementById("announcementMessage").value.trim();
		    const targetType = document.getElementById("announcementAudience").value;
		    const targetClubId = document.getElementById("specificClubSelect")?.value || "";

		    if (!title || !message) {
		        alert("Please fill all fields!");
		        return;
		    }

		    const params = new URLSearchParams();
		    params.append("title", title);
		    params.append("message", message);
		    params.append("target_type", targetType);
		    params.append("target_club_id", targetClubId);

		    try {
		        const response = await fetch(`${window.location.origin}/ClubSphere/AnnouncementServlet`, {
		            method: "POST",
		            headers: { "Content-Type": "application/x-www-form-urlencoded" },
		            body: params.toString()
		        });

		        const data = await response.json();
		        console.log("✅ Server response:", data);

		        if (data.status === "success") {
		            alert(data.message);
		            document.getElementById("announcementForm").reset();
		            loadAnnouncements();
		        } else {
		            alert("⚠️ " + data.message);
		        }

		    } catch (err) {
		        console.error("❌ Error adding announcement:", err);
		        alert("Failed to add announcement. Try again.");
		    }
		}
		document.getElementById('announcementAudience').addEventListener('change', (e) => {
		  document.getElementById('specificClubContainer').style.display =
		    e.target.value === 'specific' ? 'block' : 'none';
		});




		// Load announcements automatically when dashboard opens
		window.addEventListener("DOMContentLoaded", loadAnnouncements);
		/*----------------------------------------------------------------------------------------------------- */
		
		function openNotificationsModal() {
		  const modal = document.getElementById("notificationsModal");
		  const body = document.getElementById("notificationsBody");

		  if (!window.announcements || window.announcements.length === 0) {
		    body.innerHTML = "<p style='text-align:center;color:#666;'>No notifications available.</p>";
		  } else {
		    body.innerHTML = window.announcements.map(item => {
		      const type = item.type || 'announcement';
		      const icon = type === 'event'
		        ? '<i class="bi bi-calendar-event notification-icon" style="color:#28a745;"></i>'
		        : '<i class="bi bi-megaphone-fill notification-icon" style="color:#007bff;"></i>';

		      return `
		        <div class="notification-card notification-${type}" >
		          <div class="notification-header">
		            <div class="notification-title">${icon}${item.title}</div>
		            <div class="notification-date">${new Date(item.created_at).toLocaleDateString()}</div>
		          </div>
		          <div class="notification-message">${item.message}</div>
		        </div>
		      `;
		    }).join('');
		  }

		  modal.style.display = "flex";
		}


		function closeNotificationsModal() {
		  document.getElementById("notificationsModal").style.display = "none";
		}

		// Optional: close modal on outside click
		window.onclick = function(event) {
		  const modal = document.getElementById("notificationsModal");
		  if (event.target === modal) {
		    modal.style.display = "none";
		  }
		};
/**-----------------------------------------------------------------------------------------------* */
// ==================================================
// 📅 ClubSphere Admin Dashboard — Event Management JS
// ==================================================

// -------------------------
// 🎯 Create Event Handling
// -------------------------
document.getElementById("createEventForm")?.addEventListener("submit", async (e) => {
  e.preventDefault();

  const form = e.target;
  const formData = new FormData(form);

  // ⚙️ Use actual session-based data
  const role = userRole?.toLowerCase();
  const isAdmin = role === "admin";

  formData.append("created_by", userId);
  formData.append("club_id", clubId);
  formData.append("role", role); // important — servlet uses this
  formData.append("target_type", isAdmin ? "all" : "club");
  console.log("🧩 Role context:", { userId, clubId, role, isAdmin });

  try {
    const response = await fetch(`${window.location.origin}/ClubSphere/CreateEventServlet`, {
      method: "POST",
      body: formData,
    });

    const result = await response.json();
    console.log("✅ Event creation result:", result);

    if (result.success) {
      showToast("✅ Event created successfully!");
      form.reset();
      closeEventModal();
      loadEvents();
    } else {
      showToast("❌ " + result.message);
    }
  } catch (error) {
    console.error("❌ Error creating event:", error);
    showToast("⚠️ Something went wrong while creating the event.");
  }
});

// -------------------------
// 📋 Fetch & Display Events
// -------------------------
async function loadEvents() {
  try {
    const response = await fetch(`${window.location.origin}/ClubSphere/FetchEventsServlet`);
    if (!response.ok) throw new Error("Network response was not ok");

    const data = await response.json();
    console.log("✅ Events fetched:", data);

    const container = document.querySelector(".event-list");
    if (!container) return;

    container.innerHTML = "";

    if (!data.events || data.events.length === 0) {
      container.innerHTML = `<p class="no-events-msg">No events available.</p>`;
      return;
    }

    data.events.forEach((event) => {
      const eventDiv = document.createElement("div");
      eventDiv.classList.add("event-item");
      eventDiv.style.cursor = "pointer";

      eventDiv.innerHTML = `
        <div class="event-info">
          <h3>${event.title}</h3>
          <div class="event-meta">
            <span>📅 ${event.date}</span>
            <span>📍 ${event.venue}</span>
          </div>
        </div>
        <div>
          <span class="badge badge-status">${event.status || "Upcoming"}</span>
        </div>
      `;

      // 🧭 Redirect to event template page
      eventDiv.addEventListener("click", () => {
        window.location.href = `event_template.jsp?eventId=${event.id}`;
      });

      container.appendChild(eventDiv);
    });
  } catch (error) {
    console.error("❌ Error loading events:", error);
    showToast("⚠️ Could not load events. Try again later.");
  }
}

// Auto-load events on page load
document.addEventListener("DOMContentLoaded", loadEvents);

// -------------------------
// 🎨 Custom Modal Handling
// -------------------------
function openEventModal() {
  const overlay = document.getElementById("eventModalOverlay");
  if (!overlay) return;
  overlay.style.display = "flex";
  document.body.style.overflow = "hidden";
}

function closeEventModal() {
  const overlay = document.getElementById("eventModalOverlay");
  if (!overlay) return;
  overlay.style.display = "none";
  document.body.style.overflow = "auto";
}

// -------------------------
// 🔔 Simple Toast Notifications
// -------------------------
function showToast(message) {
  let toast = document.createElement("div");
  toast.className = "custom-toast";
  toast.textContent = message;
  document.body.appendChild(toast);

  setTimeout(() => {
    toast.classList.add("show");
  }, 100);

  setTimeout(() => {
    toast.classList.remove("show");
    setTimeout(() => toast.remove(), 300);
  }, 3000);
}


		


		






        console.log('%cClubSphere Admin Dashboard', 'color: #3182ce; font-size: 20px; font-weight: bold;');
        console.log('%c© 2025 RGUKT Ongole', 'color: #4a5568; font-size: 12px;');
        console.log('%cVersion 1.0.0', 'color: #718096; font-size: 11px;');
