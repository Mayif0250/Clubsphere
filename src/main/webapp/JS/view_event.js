/* === ClubSphere events client JS (final) ===
   Expects:
   - GET /FetchEventsServlet -> { events: [ {id, title, description, date, venue, ...}, ... ] }
   - GET /FetchEventDetailsServlet?eventId=NN -> { id, title, description, date, venue, ... }
   - Keeps UI element IDs same as your HTML
*/

// ---------- Minimal sample fallback (used if server fetch fails) ----------
const sampleEventsFallback = [
    {
        id: 9991,
        title: "Sample Hackathon",
        club: "TechXcel",
        clubInitial: "T",
        date: new Date(2023, 10, 15),
        time: "10:00 AM",
        location: "Tech Hub",
        description: "Sample short description.",
        fullDescription: "Sample full description.",
        category: "competition",
        price: "Free",
        seatsAvailable: 15,
        totalSeats: 50,
        tags: ["Limited seats", "Free"],
        image: "https://picsum.photos/seed/hackathon123/600/400.jpg",
        speakers: [{ name: "Alex Chen", title: "Senior Developer" }],
        schedule: [{ time: "10:00 AM", activity: "Opening" }]
    }
];

// ---------- DOM elements (assumes these IDs exist in HTML) ----------
const searchInput = document.getElementById('searchInput');
const filterToggle = document.getElementById('filterToggle');
const filterPanel = document.getElementById('filterPanel');
const clearFiltersBtn = document.getElementById('clearFilters');
const clubFilters = document.getElementById('clubFilters');
const startDateInput = document.getElementById('startDate');
const endDateInput = document.getElementById('endDate');
const categoryFilter = document.getElementById('categoryFilter');
const priceToggle = document.getElementById('priceToggle');
const sortDropdown = document.getElementById('sortDropdown');
const gridViewBtn = document.getElementById('gridViewBtn');
const listViewBtn = document.getElementById('listViewBtn');
const eventsContainer = document.getElementById('eventsContainer');
const resultsCount = document.getElementById('resultsCount');
const emptyState = document.getElementById('emptyState');
const loadMoreBtn = document.getElementById('loadMoreBtn');
const browseClubsBtn = document.getElementById('browseClubsBtn');
const eventModal = document.getElementById('eventModal');
const modalClose = document.getElementById('modalClose');
const modalDetailsClose = document.getElementById('modalDetailsClose');
const modalRegisterBtn = document.getElementById('modalRegisterBtn');

// Modal inner IDs assumed:
const modalImage = document.getElementById('modalImage');
const modalTitle = document.getElementById('modalTitle');
const modalClubIcon = document.getElementById('modalClubIcon');
const modalClub = document.getElementById('modalClub');
const modalDate = document.getElementById('modalDate');
const modalTime = document.getElementById('modalTime');
const modalLocation = document.getElementById('modalLocation');
const modalSeats = document.getElementById('modalSeats');
const modalDescription = document.getElementById('modalDescription');
const modalSpeakers = document.getElementById('modalSpeakers');
const modalSchedule = document.getElementById('modalSchedule');
const modalTags = document.getElementById('modalTags');

// ---------- State ----------
let eventsData = [];
let filteredEvents = [];
let displayedEvents = [];
let currentPage = 1;
const eventsPerPage = 6;
let isGridView = true;
let registeredEvents = new Set();
let searchTimeout;

// ---------- Helpers ----------
JSON.parseSafe = function (s) {
    try { return typeof s === 'string' ? JSON.parse(s) : s; }
    catch (e) { return null; }
};

function normalizeEvent(raw) {
    // raw may be from list servlet or details servlet; be permissive in field names
    const dateVal = raw.date || raw.event_date || raw.created_at || '';
    let parsedDate;
    if (dateVal === null || dateVal === undefined || dateVal === '') {
        parsedDate = new Date();
    } else if (typeof dateVal === 'number') {
        parsedDate = new Date(dateVal);
    } else {
        parsedDate = new Date(dateVal);
        if (isNaN(parsedDate.getTime())) {
            const m = String(dateVal).match(/(\d{4})-(\d{1,2})-(\d{1,2})/);
            if (m) parsedDate = new Date(m[1], Number(m[2]) - 1, m[3]);
            else parsedDate = new Date();
        }
    }

    const tags = Array.isArray(raw.tags) ? raw.tags : (raw.tags && typeof raw.tags === 'string' ? raw.tags.split(',').map(s=>s.trim()) : []);
    const speakers = Array.isArray(raw.speakers) ? raw.speakers : (JSON.parseSafe(raw.speakers) || []);
    const schedule = Array.isArray(raw.schedule) ? raw.schedule : (JSON.parseSafe(raw.schedule) || []);

    return {
        id: Number(raw.id),
        title: raw.title || '',
        club: raw.club || raw.club_name || raw.target_type || '',
        clubInitial: raw.clubInitial || (raw.club ? raw.club.charAt(0).toUpperCase() : (raw.target_type ? raw.target_type.charAt(0).toUpperCase() : 'E')),
        date: parsedDate,
        time: raw.time || raw.event_time || '',
        location: raw.venue || raw.location || '',
        description: raw.description || raw.short_desc || '',
        fullDescription: raw.fullDescription || raw.full_desc || raw.description || '',
        category: raw.category || '',
        price: raw.price || 'Free',
        seatsAvailable: Number(raw.seatsAvailable || raw.seats_available || 0),
        totalSeats: Number(raw.totalSeats || raw.total_seats || 0),
        tags: tags,
        image: raw.image || raw.image_url || 'https://picsum.photos/600/400',
        speakers: speakers,
        schedule: schedule
    };
}

function formatDate(date) {
    const options = { weekday: 'short', month: 'short', day: 'numeric' };
    return date.toLocaleDateString('en-US', options);
}

function showToast(message) {
    const toast = document.createElement('div');
    toast.className = 'toast';
    toast.textContent = message;
    toast.style.cssText = `
        position: fixed;
        bottom: 20px;
        left: 50%;
        transform: translateX(-50%);
        background-color: #222;
        color: white;
        padding: 12px 24px;
        border-radius: 50px;
        box-shadow: 0 8px 24px rgba(0,0,0,0.2);
        z-index: 2000;
        opacity: 0;
        transition: opacity 0.3s ease;
    `;
    document.body.appendChild(toast);
    setTimeout(()=> toast.style.opacity = '1', 10);
    setTimeout(()=> { toast.style.opacity = '0'; setTimeout(()=> toast.remove(), 300); }, 3000);
}

function debounce(func, delay) {
    return function() {
        const context = this;
        const args = arguments;
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(() => func.apply(context, args), delay);
    };
}

// ---------- Fetching ----------
// Fetch list from your existing FetchEventsServlet
async function fetchEvents() {
    try {
        const resp = await fetch(`${window.location.origin}/ClubSphere/FetchEventsServlet`, { method: 'GET', credentials: 'same-origin' });
		
        if (!resp.ok) throw new Error('Network response not ok: ' + resp.status);
        const json = await resp.json();
        const rawEvents = Array.isArray(json.events) ? json.events : (Array.isArray(json) ? json : []);
        if (!rawEvents || rawEvents.length === 0) {
            eventsData = sampleEventsFallback.map(e => normalizeEvent(e));
        } else {
            eventsData = rawEvents.map(normalizeEvent);
        }
    } catch (err) {
        console.error('Error fetching events: ', err);
        eventsData = sampleEventsFallback.map(e => normalizeEvent(e));
    } finally {
        filteredEvents = [...eventsData];
        currentPage = 1;
        renderEvents();
    }
}

// Fetch a single event's details from FetchEventDetailsServlet and open modal
async function fetchEventDetailsAndOpen(eventId) {
    try {
        const resp = await fetch(`${window.location.origin}/ClubSphere/FetchEventDetailsServlet?eventId=${encodeURIComponent(eventId)}`, { method: 'GET', credentials: 'same-origin' });
        if (!resp.ok) throw new Error('Network response not ok: ' + resp.status);
        const raw = await resp.json();
        if (raw.error) {
            showToast(raw.error);
            return;
        }
        const event = normalizeEvent(raw);
        populateModalWithEvent(event);
        eventModal.classList.add('active');
        document.body.style.overflow = 'hidden';
    } catch (err) {
        console.error('Error fetching event details:', err);
        showToast('Could not load event details.');
    }
}

// ---------- Rendering ----------
function renderEvents() {
    const startIndex = 0;
    const endIndex = currentPage * eventsPerPage;
    displayedEvents = filteredEvents.slice(startIndex, endIndex);

    resultsCount.textContent = filteredEvents.length;

    if (filteredEvents.length === 0) {
        eventsContainer.style.display = 'none';
        emptyState.style.display = 'block';
        loadMoreBtn.style.display = 'none';
        return;
    }

    eventsContainer.style.display = 'grid';
    emptyState.style.display = 'none';

    loadMoreBtn.style.display = (displayedEvents.length >= filteredEvents.length) ? 'none' : 'block';

    eventsContainer.innerHTML = '';
    displayedEvents.forEach(event => {
        const card = createEventCard(event);
        eventsContainer.appendChild(card);
    });
}

function createEventCard(event) {
    const card = document.createElement('div');
    card.className = 'event-card';

    const formattedDate = formatDate(event.date);
    const isRegistered = registeredEvents.has(event.id);

    const tagsHTML = (event.tags || []).map(tag => {
        let tagClass = 'event-tag';
        if (tag === 'Limited seats') tagClass += ' tag-limited';
        else if (tag === 'Free') tagClass += ' tag-free';
        else if (tag === 'Paid') tagClass += ' tag-paid';
        return `<span class="${tagClass}">${tag}</span>`;
    }).join('');

    card.innerHTML = `
        <img src="${event.image}" alt="${event.title}" class="event-image" loading="lazy">
        <div class="event-content">
            <div class="event-header">
                <h3 class="event-title">${event.title}</h3>
                <div class="club-badge">
                    <div class="club-icon">${event.clubInitial}</div>
                    <span>${event.club}</span>
                </div>
            </div>

            <div class="event-meta">
                <div class="event-meta-item"><i class="fas fa-calendar"></i><span>${formattedDate}</span></div>
                <div class="event-meta-item"><i class="fas fa-clock"></i><span>${event.time}</span></div>
                <div class="event-meta-item"><i class="fas fa-map-marker-alt"></i><span>${event.location}</span></div>
            </div>

            <p class="event-description">${event.description}</p>

            <div class="event-footer">
                <div class="event-actions">
                    <button class="btn ${isRegistered ? 'btn-success' : 'btn-primary'}" 
                            data-event-id="${event.id}" 
                            data-action="${isRegistered ? 'registered' : 'register'}">
                        ${isRegistered ? '<i class="fas fa-check"></i> Registered' : (event.seatsAvailable > 0 ? 'Join' : 'Register')}
                    </button>
                    <button class="btn btn-secondary" data-event-id="${event.id}" data-action="details">Details</button>
                </div>
                <div class="event-tags">${tagsHTML}</div>
            </div>
        </div>
    `;

    const buttons = card.querySelectorAll('.btn');
    buttons.forEach(button => {
        button.addEventListener('click', (e) => {
            e.stopPropagation();
            const eventId = parseInt(button.dataset.eventId);
            const action = button.dataset.action;
            if (action === 'register' || action === 'registered') {
                handleRegister(eventId);
            } else if (action === 'details') {
                // use server-side details to populate modal
                 window.location.href = `event_template.jsp?eventId=${eventId}`;
            }
        });
    });

    return card;
}

// ---------- Modal population ----------
function populateModalWithEvent(event) {
    const formattedDate = formatDate(event.date);

    modalImage.src = event.image;
    modalImage.alt = event.title;
    modalTitle.textContent = event.title;
    modalClubIcon.textContent = event.clubInitial;
    modalClub.textContent = event.club;
    modalDate.textContent = formattedDate;
    modalTime.textContent = event.time;
    modalLocation.textContent = event.location;
    modalSeats.textContent = `${event.seatsAvailable} seats available`;
    modalDescription.textContent = event.fullDescription;

    modalSpeakers.innerHTML = (event.speakers || []).map(speaker => `
        <div class="speaker-item">
            <div class="speaker-avatar">${(speaker.name||'').charAt(0)}</div>
            <div class="speaker-info">
                <div class="speaker-name">${speaker.name||''}</div>
                <div class="speaker-title">${speaker.title||''}</div>
            </div>
        </div>
    `).join('');

    modalSchedule.innerHTML = (event.schedule || []).map(item => `
        <div class="schedule-item">
            <div class="schedule-time">${item.time||''}</div>
            <div class="schedule-activity">${item.activity||''}</div>
        </div>
    `).join('');

    modalTags.innerHTML = (event.tags || []).map(tag => `<span class="event-tag">${tag}</span>`).join('');

    modalRegisterBtn.dataset.eventId = event.id;
    updateModalRegisterButton(event.id);
}

function updateModalRegisterButton(eventId) {
    const isRegistered = registeredEvents.has(eventId);
    if (isRegistered) {
        modalRegisterBtn.className = 'btn btn-success btn-large';
        modalRegisterBtn.innerHTML = '<i class="fas fa-check"></i> Registered';
    } else {
        modalRegisterBtn.className = 'btn btn-primary btn-large';
        // seatsAvailable not guaranteed here; try to find in eventsData
        const ev = eventsData.find(e => e.id === eventId);
        modalRegisterBtn.textContent = ev && ev.seatsAvailable > 0 ? 'Register' : 'Join Waitlist';
    }
}

function closeModal() {
    eventModal.classList.remove('active');
    document.body.style.overflow = 'auto';
}

// ---------- Registration (client-only toggle) ----------
function handleRegister(eventId) {
    const ev = eventsData.find(e => e.id === eventId);
    if (!ev) return;

    if (registeredEvents.has(eventId)) {
        registeredEvents.delete(eventId);
        showToast(`You have unregistered from "${ev.title}"`);
        // TODO: call server endpoint to unregister if you have one
    } else {
        registeredEvents.add(eventId);
        showToast(`You have successfully registered for "${ev.title}"`);
        // TODO: POST to server to register the user if you support that
    }

    renderEvents();

    if (eventModal.classList.contains('active') && parseInt(modalRegisterBtn.dataset.eventId) === eventId) {
        updateModalRegisterButton(eventId);
    }
}

// ---------- Searching & Filtering ----------
function handleSearch() {
    const searchTerm = searchInput.value.toLowerCase().trim();
    if (searchTerm === '') {
        applyFilters();
        return;
    }
    filteredEvents = eventsData.filter(event => {
        return (event.title || '').toLowerCase().includes(searchTerm) ||
               (event.club || '').toLowerCase().includes(searchTerm) ||
               (event.description || '').toLowerCase().includes(searchTerm);
    });
    currentPage = 1;
    renderEvents();
}

function applyFilters() {
    const selectedClubs = Array.from(clubFilters ? clubFilters.querySelectorAll('input:checked') : []).map(i => i.value);
    const startDate = startDateInput.value ? new Date(startDateInput.value) : null;
    const endDate = endDateInput.value ? new Date(endDateInput.value) : null;
    const selectedCategory = categoryFilter.value;
    const isPaid = priceToggle.checked;
    const sortBy = sortDropdown.value;

    filteredEvents = eventsData.filter(event => {
        if (selectedClubs.length > 0 && !selectedClubs.includes(event.club)) return false;
        if (startDate && event.date < startDate) return false;
        if (endDate && event.date > endDate) return false;
        if (selectedCategory && event.category !== selectedCategory) return false;
        if (isPaid && event.price !== 'Paid') return false;
        return true;
    });

    sortEvents(sortBy);
    currentPage = 1;
    renderEvents();
}

function sortEvents(sortBy) {
    switch (sortBy) {
        case 'upcoming':
            filteredEvents.sort((a,b) => a.date - b.date);
            break;
        case 'popular':
            filteredEvents.sort((a,b) => {
                const aRatio = (a.seatsAvailable / Math.max(1, a.totalSeats));
                const bRatio = (b.seatsAvailable / Math.max(1, b.totalSeats));
                return aRatio - bRatio;
            });
            break;
        case 'newest':
            filteredEvents.sort((a,b) => b.id - a.id);
            break;
    }
}

function clearAllFilters() {
    if (clubFilters) clubFilters.querySelectorAll('input').forEach(i => i.checked = false);
    startDateInput.value = '';
    endDateInput.value = '';
    categoryFilter.value = '';
    priceToggle.checked = false;
    sortDropdown.value = 'upcoming';
    searchInput.value = '';
    applyFilters();
}

function loadMoreEvents() {
    currentPage++;
    renderEvents();
}

// ---------- Event Listeners ----------
function setupEventListeners() {
    if (searchInput) searchInput.addEventListener('input', debounce(handleSearch, 300));
    if (filterToggle) filterToggle.addEventListener('click', () => filterPanel.classList.toggle('active'));
    if (clearFiltersBtn) clearFiltersBtn.addEventListener('click', clearAllFilters);
    if (clubFilters) clubFilters.addEventListener('change', applyFilters);
    if (startDateInput) startDateInput.addEventListener('change', applyFilters);
    if (endDateInput) endDateInput.addEventListener('change', applyFilters);
    if (categoryFilter) categoryFilter.addEventListener('change', applyFilters);
    if (priceToggle) priceToggle.addEventListener('change', applyFilters);
    if (sortDropdown) sortDropdown.addEventListener('change', applyFilters);

    if (gridViewBtn) gridViewBtn.addEventListener('click', () => {
        isGridView = true;
        gridViewBtn.classList.add('active');
        listViewBtn.classList.remove('active');
        eventsContainer.classList.remove('list-view');
    });

    if (listViewBtn) listViewBtn.addEventListener('click', () => {
        isGridView = false;
        listViewBtn.classList.add('active');
        gridViewBtn.classList.remove('active');
        eventsContainer.classList.add('list-view');
    });

    if (loadMoreBtn) loadMoreBtn.addEventListener('click', loadMoreEvents);
    if (browseClubsBtn) browseClubsBtn.addEventListener('click', clearAllFilters);

    if (modalClose) modalClose.addEventListener('click', closeModal);
    if (modalDetailsClose) modalDetailsClose.addEventListener('click', closeModal);
    if (eventModal) eventModal.addEventListener('click', (e) => { if (e.target === eventModal) closeModal(); });
    if (modalRegisterBtn) modalRegisterBtn.addEventListener('click', () => {
        const eventId = parseInt(modalRegisterBtn.dataset.eventId);
        handleRegister(eventId);
    });
}

// ---------- Init ----------
document.addEventListener('DOMContentLoaded', () => {
    setupEventListeners();
    fetchEvents();
});
