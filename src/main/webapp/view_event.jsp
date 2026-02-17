<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ClubSphere — Events</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="CSS/view_event.css">
    
</head>
<body>
    <!-- Header -->
    <header>
        <nav class="navbar">
            <a href="#" class="logo">
                <i class="fas fa-globe"></i>
                ClubSphere
            </a>
            
            <div class="search-container">
                <input type="text" class="search-input" id="searchInput" placeholder="Search events, clubs...">
                <i class="fas fa-search search-icon"></i>
            </div>
            
            <div class="profile-icon">
                <i class="fas fa-user"></i>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <div class="main-container">
        <!-- Filter Panel -->
        <button class="filter-toggle" id="filterToggle">
            <i class="fas fa-filter"></i>
        </button>
        
        <aside class="filter-panel" id="filterPanel">
            <div class="filter-header">
                <h3 class="filter-title">Filters</h3>
                <button class="clear-filters" id="clearFilters">Clear all</button>
            </div>
            
            <div class="filter-section">
                <label class="filter-label">Clubs</label>
                <div class="checkbox-group" id="clubFilters">
                    <div class="checkbox-item">
                        <input type="checkbox" id="techxcel" value="TechXcel">
                        <label for="techxcel">TechXcel</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="pixelro" value="PixelRO">
                        <label for="pixelro">PixelRO</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="khelsaathi" value="KhelSaathi">
                        <label for="khelsaathi">KhelSaathi</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="sarvasrijana" value="SarvaSrijana">
                        <label for="sarvasrijana">SarvaSrijana</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="icro" value="ICRO">
                        <label for="icro">ICRO</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="kaladharani" value="Kaladharani">
                        <label for="kaladharani">Kaladharani</label>
                    </div>
                </div>
            </div>
            
            <div class="filter-section">
                <label class="filter-label">Date Range</label>
                <div class="date-inputs">
                    <input type="date" class="date-input" id="startDate">
                    <input type="date" class="date-input" id="endDate">
                </div>
            </div>
            
            <div class="filter-section">
                <label class="filter-label">Category</label>
                <select class="select-input" id="categoryFilter">
                    <option value="">All Categories</option>
                    <option value="workshop">Workshop</option>
                    <option value="competition">Competition</option>
                    <option value="meetup">Meetup</option>
                    <option value="cultural">Cultural</option>
                    <option value="sports">Sports</option>
                </select>
            </div>
            
            <div class="filter-section">
                <label class="filter-label">Price</label>
                <div class="toggle-container">
                    <span>Free</span>
                    <label class="toggle-switch">
                        <input type="checkbox" id="priceToggle">
                        <span class="toggle-slider"></span>
                    </label>
                    <span>Paid</span>
                </div>
            </div>
        </aside>

        <!-- Content Area -->
        <main class="content-area">
            <div class="content-header">
                <div class="results-count">
                    <span id="resultsCount">6</span> events found
                </div>
                
                <div class="content-controls">
                    <select class="sort-dropdown" id="sortDropdown">
                        <option value="upcoming">Upcoming</option>
                        <option value="popular">Popular</option>
                        <option value="newest">Newest</option>
                    </select>
                    
                    <div class="view-toggle">
                        <button class="view-btn active" id="gridViewBtn">
                            <i class="fas fa-th"></i>
                        </button>
                        <button class="view-btn" id="listViewBtn">
                            <i class="fas fa-list"></i>
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Events Container -->
            <div class="events-container" id="eventsContainer">
                <!-- Events will be dynamically inserted here -->
            </div>
            
            <!-- Empty State (hidden by default) -->
            <div class="empty-state" id="emptyState" style="display: none;">
                <div class="empty-icon">
                    <i class="fas fa-calendar-times"></i>
                </div>
                <h2 class="empty-title">No events found</h2>
                <p class="empty-description">
                    We couldn't find any events matching your filters. Try adjusting your search criteria or browse all clubs to discover more opportunities.
                </p>
                <button class="btn btn-outline" id="browseClubsBtn">Browse Clubs</button>
            </div>
            
            <!-- Load More Button -->
            <div class="load-more-container">
                <button class="load-more-btn" id="loadMoreBtn">Load More Events</button>
            </div>
        </main>
    </div>

    <!-- Event Details Modal -->
    <div class="modal" id="eventModal">
        <div class="modal-content">
            <div class="modal-header">
                <img src="" alt="" class="modal-image" id="modalImage">
                <button class="modal-close" id="modalClose">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            
            <div class="modal-body">
                <h2 class="modal-title" id="modalTitle"></h2>
                <div class="modal-club">
                    <div class="club-icon" id="modalClubIcon"></div>
                    <span id="modalClub"></span>
                </div>
                
                <div class="modal-meta">
                    <div class="modal-meta-item">
                        <i class="fas fa-calendar"></i>
                        <span id="modalDate"></span>
                    </div>
                    <div class="modal-meta-item">
                        <i class="fas fa-clock"></i>
                        <span id="modalTime"></span>
                    </div>
                    <div class="modal-meta-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <span id="modalLocation"></span>
                    </div>
                    <div class="modal-meta-item">
                        <i class="fas fa-users"></i>
                        <span id="modalSeats"></span>
                    </div>
                </div>
                
                <div class="modal-section">
                    <h3 class="modal-section-title">About This Event</h3>
                    <p class="modal-description" id="modalDescription"></p>
                </div>
                
                <div class="modal-section">
                    <h3 class="modal-section-title">Speakers</h3>
                    <div class="speakers-list" id="modalSpeakers">
                        <!-- Speakers will be dynamically inserted here -->
                    </div>
                </div>
                
                <div class="modal-section">
                    <h3 class="modal-section-title">Schedule</h3>
                    <div class="schedule-list" id="modalSchedule">
                        <!-- Schedule will be dynamically inserted here -->
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
                <div class="event-tags" id="modalTags">
                    <!-- Tags will be dynamically inserted here -->
                </div>
                
                <div class="modal-actions">
                    <button class="btn btn-secondary" id="modalDetailsClose">Close</button>
                    <button class="btn btn-primary btn-large" id="modalRegisterBtn">Register</button>
                </div>
            </div>
        </div>
    </div>

    <script src="JS/view_event.js"></script>
</body>
</html>