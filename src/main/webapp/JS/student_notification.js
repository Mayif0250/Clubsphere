let announcements = []; // this will be loaded from backend
let currentFilter = "all";

// Fetch data from backend
async function fetchAnnouncements(type = "all") {
    try {
        let url = `${window.location.origin}/ClubSphere/FetchAllUpdatesServlet`;
        if (type !== "all") url += `?type=${type}`;

        const response = await fetch(url);
        if (!response.ok) throw new Error("Network response failed");

        const data = await response.json();
        console.log("✅ Fetched updates:", data);

        const container = document.getElementById("notifications-container");
        container.innerHTML = "";

        if (data.error) {
            container.innerHTML = `<p class="error">${data.error}</p>`;
            return;
        }

        if (!data.updates || data.updates.length === 0) {
            container.innerHTML = `<p class="no-updates">No updates available</p>`;
            return;
        }

        data.updates.forEach(update => {
            const card = document.createElement("div");
            card.classList.add("update-card", update.type);

            card.innerHTML = `
                <div class="update-header">
                    <h3>${update.title}</h3>
                    <span class="type-tag ${update.type}">${update.type.toUpperCase()}</span>
                </div>
                <p class="update-description">${update.description}</p>
                <div class="update-footer">
                    <span class="club-name">🏛 ${update.club}</span>
                    <span class="update-date">${new Date(update.datePosted).toLocaleString()}</span>
                </div>
            `;
            container.appendChild(card);
        });
    } catch (err) {
        console.error("❌ Error fetching announcements:", err);
    }
}

// Load default
document.addEventListener("DOMContentLoaded", () => fetchAnnouncements());



// RENDERING
function renderAnnouncements() {
    const grid = document.getElementById("announcementsGrid");
    const emptyState = document.getElementById("emptyState");

    let filteredAnnouncements = announcements;
    if (currentFilter !== "all") {
        filteredAnnouncements = announcements.filter(ann => ann.club === currentFilter);
    }

    if (filteredAnnouncements.length === 0) {
        grid.style.display = "none";
        emptyState.style.display = "block";
        return;
    }

    grid.style.display = "grid";
    emptyState.style.display = "none";

    grid.innerHTML = filteredAnnouncements.map(announcement => `
        <div class="announcement-card" data-club="${announcement.club}">
            <div class="card-header">
                <div class="club-badge">${announcement.club}</div>
                <div class="priority-badge priority-${announcement.priority}">${announcement.priority}</div>
            </div>
            <h3 class="announcement-title">${announcement.title}</h3>
            <div class="announcement-type">📋 ${announcement.type}</div>
            <p class="announcement-description">${announcement.description}</p>
            <div class="poster-section">
                <div class="poster-image ${announcement.posterUrl ? "has-image" : ""}">
                    ${announcement.posterUrl ? 
                        `<img src="${announcement.posterUrl}" alt="Poster" style="width:100%; height:100%; object-fit:cover; border-radius:8px;">` : 
                        "📋 No poster available"
                    }
                </div>
            </div>
            <div class="announcement-stats">
                <div class="stat-item">
                    <span>👥</span>
                    <span>${Math.floor(Math.random() * 150) + 50} interested</span>
                </div>
                <div class="stat-item">
                    <span>👁️</span>
                    <span>${Math.floor(Math.random() * 500) + 100} views</span>
                </div>
            </div>
            <div class="card-footer">
                <div class="announcement-meta">
                    <span>📅 ${announcement.datePosted.toLocaleDateString()}</span>
                    <span>⏰ ${announcement.datePosted.toLocaleTimeString([], {hour: "2-digit", minute: "2-digit"})}</span>
                </div>
                <button class="read-more-btn" onclick="viewFullAnnouncement(${announcement.id})">📖 View Details</button>
            </div>
        </div>
    `).join("");
}

// MODAL VIEW
function viewFullAnnouncement(id) {
    const announcement = announcements.find(ann => ann.id === id);
    if (!announcement) return;

    const modalContent = document.querySelector(".modal-content");
    modalContent.innerHTML = `
        <div class="modal-header">
            <h2 class="modal-title">📋 ${announcement.type} Details</h2>
            <span class="close" onclick="closeModal()">&times;</span>
        </div>
        <div class="announcement-form-view">
            <div class="form-group">
                <label>Club Name</label>
                <div class="form-display"><div class="club-badge">${announcement.club}</div></div>
            </div>
            <div class="form-group">
                <label>Title</label>
                <div class="form-display"><h3>${announcement.title}</h3></div>
            </div>
            <div class="form-group">
                <label>Description</label>
                <div class="form-display">${announcement.description}</div>
            </div>
            ${announcement.posterUrl ? `
                <div class="form-group">
                    <label>Poster</label>
                    <div class="form-display">
                        <img src="${announcement.posterUrl}" alt="Poster" style="width:100%; border-radius:8px;">
                    </div>
                </div>` : `
                <div class="form-group">
                    <label>Poster</label>
                    <div class="form-display"><span>📋 No poster available</span></div>
                </div>`}
            <div class="form-group">
                <label>Date</label>
                <div class="form-display">
                    <span>📅 ${announcement.datePosted.toLocaleDateString()}</span>
                    <span>⏰ ${announcement.datePosted.toLocaleTimeString([], {hour: "2-digit", minute: "2-digit"})}</span>
                </div>
            </div>
            <div class="form-actions">
                <button class="action-btn interested-btn" onclick="markInterested(${announcement.id})">⭐ Mark as Interested</button>
                <button class="action-btn share-btn" onclick="shareAnnouncement(${announcement.id})">🔗 Share</button>
                <button class="action-btn close-btn" onclick="closeModal()">❌ Close</button>
            </div>
        </div>
    `;
    document.getElementById("announcementModal").style.display = "block";
}

// UTILITY FUNCTIONS
function closeModal() {
    document.getElementById("announcementModal").style.display = "none";
}

function markInterested(id) {
    alert("✅ You’ve marked interest for this update!");
}

function shareAnnouncement(id) {
    const announcement = announcements.find(ann => ann.id === id);
    if (!announcement) return;
    const shareText = `Check this out: ${announcement.title} (${announcement.club})`;
    if (navigator.share) {
        navigator.share({
            title: announcement.title,
            text: shareText,
            url: window.location.href
        });
    } else {
        navigator.clipboard.writeText(shareText);
        alert("📋 Copied announcement link to clipboard!");
    }
}


// FILTER BUTTONS
document.querySelectorAll(".filter-btn").forEach(btn => {
    btn.addEventListener("click", function() {
        document.querySelectorAll(".filter-btn").forEach(b => b.classList.remove("active"));
        this.classList.add("active");
        currentFilter = this.dataset.filter;
        renderAnnouncements();
    });
});

// MODAL CLOSE ON OUTSIDE CLICK
window.addEventListener("click", function(e) {
    const modal = document.getElementById("announcementModal");
    if (e.target === modal) closeModal();
});

// INITIAL FETCH
document.addEventListener("DOMContentLoaded", () => {
    fetchAnnouncements("all", "all");
});
