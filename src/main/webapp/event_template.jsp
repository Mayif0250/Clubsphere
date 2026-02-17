<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Details - ClubSphere</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-blue: #4A90E2;
            --light-blue: #E8F4F8;
            --dark-blue: #2C5F8D;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #F5F7FA;
            color: #333;
        }
        
        /* Navbar */
        .navbar-custom {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--dark-blue) 100%);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 1rem 0;
        }
        
        .navbar-custom .navbar-brand {
            color: white;
            font-weight: 600;
            font-size: 1.5rem;
        }
        
        .navbar-custom .nav-link {
            color: rgba(255,255,255,0.9);
            margin: 0 10px;
        }
        
        .navbar-custom .nav-link:hover {
            color: white;
        }
        
        /* Hero Section */
        .event-hero {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--dark-blue) 100%);
            color: white;
            padding: 60px 0 40px;
            margin-bottom: 40px;
        }
        
        .event-badge {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 8px 20px;
            border-radius: 30px;
            font-size: 0.9rem;
            display: inline-block;
            margin-bottom: 20px;
            backdrop-filter: blur(10px);
        }
        
        .event-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        .club-name {
            font-size: 1.2rem;
            opacity: 0.95;
            margin-bottom: 30px;
        }
        
        .club-name i {
            margin-right: 8px;
        }
        
        /* Main Content */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px 60px;
        }
        
        .content-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            padding: 35px;
            margin-bottom: 30px;
        }
        
        .section-title {
            color: var(--dark-blue);
            font-weight: 600;
            font-size: 1.5rem;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 3px solid var(--light-blue);
        }
        
        /* Event Info Grid */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .info-item {
            display: flex;
            align-items: flex-start;
            padding: 20px;
            background: var(--light-blue);
            border-radius: 12px;
            transition: transform 0.3s;
        }
        
        .info-item:hover {
            transform: translateY(-3px);
        }
        
        .info-icon {
            width: 50px;
            height: 50px;
            background: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            flex-shrink: 0;
        }
        
        .info-icon i {
            font-size: 22px;
            color: var(--primary-blue);
        }
        
        .info-content h6 {
            color: #6C757D;
            font-size: 0.85rem;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .info-content p {
            color: var(--dark-blue);
            font-weight: 600;
            margin: 0;
            font-size: 1.05rem;
        }
        
        /* Description */
        .description-text {
            color: #495057;
            line-height: 1.8;
            font-size: 1.05rem;
        }
        
        /* Coordinator Card */
        .coordinator-card {
            display: flex;
            align-items: center;
            padding: 25px;
            background: linear-gradient(135deg, var(--light-blue) 0%, rgba(232, 244, 248, 0.5) 100%);
            border-radius: 12px;
            margin-top: 20px;
        }
        
        .coordinator-avatar {
            width: 70px;
            height: 70px;
            background: var(--primary-blue);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 28px;
            margin-right: 20px;
            flex-shrink: 0;
        }
        
        .coordinator-info h5 {
            color: var(--dark-blue);
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .coordinator-info p {
            color: #6C757D;
            margin: 0;
            font-size: 0.95rem;
        }
        
        .coordinator-contact {
            margin-left: auto;
        }
        
        .btn-contact {
            background: white;
            color: var(--primary-blue);
            border: 2px solid var(--primary-blue);
            padding: 10px 25px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-contact:hover {
            background: var(--primary-blue);
            color: white;
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .btn-rsvp {
            background: linear-gradient(135deg, #5CB85C 0%, #449D44 100%);
            color: white;
            border: none;
            padding: 15px 40px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1.05rem;
            transition: all 0.3s;
            flex: 1;
            min-width: 200px;
        }
        
        .btn-rsvp:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(92, 184, 92, 0.3);
            color: white;
        }
        
        .btn-interested {
            background: white;
            color: var(--primary-blue);
            border: 2px solid var(--primary-blue);
            padding: 15px 40px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1.05rem;
            transition: all 0.3s;
            flex: 1;
            min-width: 200px;
        }
        
        .btn-interested:hover {
            background: var(--primary-blue);
            color: white;
            transform: translateY(-3px);
        }
        
        /* Comments Section */
        .comment-form {
            background: var(--light-blue);
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
        }
        
        .comment-form textarea {
            border: 2px solid #E9ECEF;
            border-radius: 10px;
            padding: 15px;
            font-size: 1rem;
            resize: vertical;
            min-height: 100px;
        }
        
        .comment-form textarea:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 0.2rem rgba(74, 144, 226, 0.15);
        }
        
        .btn-comment {
            background: var(--primary-blue);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-comment:hover {
            background: var(--dark-blue);
            transform: translateY(-2px);
        }
        
        .comment-list {
            margin-top: 30px;
        }
        
        .comment-item {
            padding: 20px;
            background: #F8F9FA;
            border-radius: 12px;
            margin-bottom: 15px;
            transition: background 0.3s;
        }
        
        .comment-item:hover {
            background: #E9ECEF;
        }
        
        .comment-header {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
        }
        
        .comment-avatar {
            width: 45px;
            height: 45px;
            background: var(--primary-blue);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            margin-right: 15px;
        }
        
        .comment-author {
            flex: 1;
        }
        
        .comment-author h6 {
            color: var(--dark-blue);
            font-weight: 600;
            margin: 0;
            font-size: 1rem;
        }
        
        .comment-time {
            color: #ADB5BD;
            font-size: 0.85rem;
        }
        
        .comment-text {
            color: #495057;
            line-height: 1.6;
            margin: 0;
            padding-left: 60px;
        }
        
        /* Stats */
        .event-stats {
            display: flex;
            gap: 30px;
            margin-top: 20px;
            flex-wrap: wrap;
        }
        
        .stat-item {
            display: flex;
            align-items: center;
            color: rgba(255,255,255,0.9);
        }
        
        .stat-item i {
            font-size: 20px;
            margin-right: 10px;
        }
        
        .stat-number {
            font-weight: 700;
            font-size: 1.3rem;
            margin-right: 5px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .event-title {
                font-size: 2rem;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .coordinator-card {
                flex-direction: column;
                text-align: center;
            }
            
            .coordinator-avatar {
                margin-right: 0;
                margin-bottom: 15px;
            }
            
            .coordinator-contact {
                margin-left: 0;
                margin-top: 15px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn-rsvp, .btn-interested {
                min-width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <i class="fas fa-users-cog me-2"></i>ClubSphere
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Events</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Clubs</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">My Dashboard</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Event Hero Section -->
    <div class="event-hero">
        <div class="container">
            <div class="event-badge">
                <i class="fas fa-calendar-check me-2"></i>Upcoming Event
            </div>
            <h1 class="event-title">Annual Tech Conference 2025</h1>
            <p class="club-name">
                <i class="fas fa-users"></i>Organized by Tech Innovators Club
            </p>
            <div class="event-stats">
                <div class="stat-item">
                    <i class="fas fa-user-check"></i>
                    <span class="stat-number">156</span>
                    <span>Attending</span>
                </div>
                <div class="stat-item">
                    <i class="fas fa-star"></i>
                    <span class="stat-number">89</span>
                    <span>Interested</span>
                </div>
                <div class="stat-item">
                    <i class="fas fa-comments"></i>
                    <span class="stat-number">24</span>
                    <span>Comments</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Event Information -->
        <div class="content-card">
            <h2 class="section-title">
                <i class="fas fa-info-circle me-2"></i>Event Information
            </h2>
            
            <div class="info-grid">
                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <div class="info-content">
                        <h6>Date</h6>
                        <p>November 15, 2025</p>
                    </div>
                </div>
                
                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="info-content">
                        <h6>Time</h6>
                        <p>10:00 AM - 5:00 PM</p>
                    </div>
                </div>
                
                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <div class="info-content">
                        <h6>Venue</h6>
                        <p>Main Auditorium, Building A</p>
                    </div>
                </div>
                
                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-tag"></i>
                    </div>
                    <div class="info-content">
                        <h6>Category</h6>
                        <p>Technology & Innovation</p>
                    </div>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div class="action-buttons">
                <button class="btn btn-rsvp">
                    <i class="fas fa-check-circle me-2"></i>RSVP - I'm Attending
                </button>
                <button class="btn btn-interested">
                    <i class="fas fa-star me-2"></i>Mark as Interested
                </button>
            </div>
        </div>

        <!-- Event Description -->
        <div class="content-card">
            <h2 class="section-title">
                <i class="fas fa-align-left me-2"></i>About This Event
            </h2>
            <div class="description-text">
                <p>
                    Join us for the Annual Tech Conference 2025, the premier gathering of technology enthusiasts, 
                    innovators, and industry leaders. This year's conference will feature cutting-edge presentations, 
                    hands-on workshops, and networking opportunities that will shape the future of technology.
                </p>
                <p class="mt-3">
                    <strong>What to Expect:</strong>
                </p>
                <ul>
                    <li>Keynote speeches from industry experts</li>
                    <li>Interactive workshops on AI, Machine Learning, and Cloud Computing</li>
                    <li>Product demonstrations and tech showcases</li>
                    <li>Networking sessions with professionals and peers</li>
                    <li>Panel discussions on emerging technologies</li>
                    <li>Career guidance and recruitment opportunities</li>
                </ul>
                <p class="mt-3">
                    Whether you're a seasoned developer, a curious student, or a tech enthusiast, this conference 
                    offers something for everyone. Don't miss this opportunity to learn, connect, and be inspired!
                </p>
                <p class="mt-3">
                    <strong>Note:</strong> Registration is free for all club members. Light refreshments will be provided.
                </p>
            </div>
        </div>

        <!-- Event Coordinator -->
        <div class="content-card">
            <h2 class="section-title">
                <i class="fas fa-user-tie me-2"></i>Event Coordinator
            </h2>
            <div class="coordinator-card">
                <div class="coordinator-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="coordinator-info">
                    <h5>Sarah Williams</h5>
                    <p>Club President - Tech Innovators Club</p>
                    <p class="mt-2">
                        <i class="fas fa-envelope me-2 text-primary"></i>sarah.williams@clubsphere.com
                    </p>
                    <p>
                        <i class="fas fa-phone me-2 text-primary"></i>+1 (555) 123-4567
                    </p>
                </div>
                <div class="coordinator-contact">
                    <button class="btn btn-contact">
                        <i class="fas fa-paper-plane me-2"></i>Contact
                    </button>
                </div>
            </div>
        </div>

        <!-- Comments Section -->
        <div class="content-card">
            <h2 class="section-title">
                <i class="fas fa-comments me-2"></i>Member Comments
            </h2>
            
            <!-- Comment Form -->
            <div class="comment-form">
                <form>
                    <div class="mb-3">
                        <label for="commentText" class="form-label fw-semibold">Leave a comment</label>
                        <textarea class="form-control" id="commentText" rows="3" 
                                  placeholder="Share your thoughts about this event..."></textarea>
                    </div>
                    <button type="submit" class="btn btn-comment">
                        <i class="fas fa-paper-plane me-2"></i>Post Comment
                    </button>
                </form>
            </div>
            
            <!-- Comment List -->
            <div class="comment-list">
                <div class="comment-item">
                    <div class="comment-header">
                        <div class="comment-avatar">JD</div>
                        <div class="comment-author">
                            <h6>John Doe</h6>
                            <span class="comment-time">2 hours ago</span>
                        </div>
                    </div>
                    <p class="comment-text">
                        Really excited for this conference! The lineup of speakers looks amazing. 
                        Can't wait to learn about the latest AI developments.
                    </p>
                </div>
                
                <div class="comment-item">
                    <div class="comment-header">
                        <div class="comment-avatar">EM</div>
                        <div class="comment-author">
                            <h6>Emily Martinez</h6>
                            <span class="comment-time">5 hours ago</span>
                        </div>
                    </div>
                    <p class="comment-text">
                        Will there be any beginner-friendly sessions? I'm new to the tech field and 
                        would love to attend workshops that match my skill level.
                    </p>
                </div>
                
                <div class="comment-item">
                    <div class="comment-header">
                        <div class="comment-avatar">MJ</div>
                        <div class="comment-author">
                            <h6>Michael Johnson</h6>
                            <span class="comment-time">1 day ago</span>
                        </div>
                    </div>
                    <p class="comment-text">
                        Attended last year's conference and it was incredible! The networking opportunities 
                        alone made it worth it. Highly recommend everyone to RSVP!
                    </p>
                </div>
                
                <div class="comment-item">
                    <div class="comment-header">
                        <div class="comment-avatar">LC</div>
                        <div class="comment-author">
                            <h6>Lisa Chen</h6>
                            <span class="comment-time">2 days ago</span>
                        </div>
                    </div>
                    <p class="comment-text">
                        Is parking available at the venue? Also, will the sessions be recorded for 
                        those who might miss certain parts?
                    </p>
                </div>
            </div>
            
            <div class="text-center mt-4">
                <button class="btn btn-outline-primary">
                    <i class="fas fa-chevron-down me-2"></i>Load More Comments
                </button>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="JS/event_template.js"></script>
</body>
</html>