<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("role");
    if (session.getAttribute("userId") == null || role == null || role.equals("admin")) {
        response.sendRedirect("user_login_page.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ClubSphere - Student Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="CSS/homepage.css">
</head>
<body class="bg-gray-50">
    <!-- Professional Navigation Bar -->
    <nav class="bg-white shadow-sm border-b border-gray-200 sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <div class="flex-shrink-0 flex items-center">
                        <div class="bg-gradient-to-r from-indigo-600 to-purple-600 p-2 rounded-lg mr-3">
                            <i class="fas fa-users-cog text-white text-xl"></i>
                        </div>
                        <span class="text-2xl font-bold bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">ClubSphere</span>
                    </div>
                    <div class="hidden md:ml-10 md:flex md:space-x-1">
                        <a href="#" class="nav-link active text-gray-900 hover:text-indigo-600 px-4 py-2 text-sm font-medium transition">Dashboard</a>
                        <div class="relative group">
                            <button class="nav-link text-gray-900 hover:text-indigo-600 px-4 py-2 text-sm font-medium transition flex items-center">
                                Explore <i class="fas fa-chevron-down ml-1 text-xs"></i>
                            </button>
                            <div class="mega-menu absolute left-0 mt-2 w-64 bg-white rounded-lg shadow-lg border border-gray-200 p-4 group-hover:show">
                                <div class="space-y-2">
                                    <a href="Clublist.jsp" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 rounded-md transition">
                                        <i class="fas fa-th-large mr-2 text-gray-400"></i> All Clubs
                                    </a>
                                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 rounded-md transition">
                                        <i class="fas fa-fire mr-2 text-gray-400"></i> Trending Clubs
                                    </a>
                                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 rounded-md transition">
                                        <i class="fas fa-star mr-2 text-gray-400"></i> Recommended for You
                                    </a>
                                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 rounded-md transition">
                                        <i class="fas fa-clock mr-2 text-gray-400"></i> Recently Added
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="relative group">
                        <a href="view_event.jsp">
                            <button class="nav-link text-gray-900 hover:text-indigo-600 px-4 py-2 text-sm font-medium transition flex items-center">
                                Events
                            </button>
                            </a>
                        </div>
                        <a href="#" class="nav-link text-gray-900 hover:text-indigo-600 px-4 py-2 text-sm font-medium transition">My Clubs</a>
                    </div>
                </div>
                <div class="flex items-center space-x-4">
                    <div class="relative hidden md:block">
                        <input type="text" placeholder="Search clubs, events..." 
                               class="w-80 px-4 py-2.5 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition text-sm">
                        <i class="fas fa-search absolute right-3 top-3 text-gray-400"></i>
                    </div>
                    <a href="student_notification.jsp">
                    <button class="relative p-2 text-gray-600 hover:text-indigo-600 transition">
                        <i class="fas fa-bell text-xl"></i>
                        <span class="notification-badge absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">3</span>
                    </button>
                    </a>
                    
                    <!-- Professional Profile Dropdown -->
                    <div class="relative">
                        <button id="profileButton" class="flex items-center space-x-3 hover:bg-gray-50 rounded-lg p-2 transition">
                            <img src="data:image/jpeg;base64,${profileImage}" alt="Profile" class="h-10 w-10 rounded-full ring-2 ring-gray-200">
                            <div class="hidden md:block text-left">
                                <p class="text-sm font-semibold text-gray-800">${first_name} ${last_name}</p>
                                <p class="text-xs text-gray-500">Student</p>
                            </div>
                            <i class="fas fa-chevron-down text-gray-400 text-sm"></i>
                        </button>
                        
                        <div id="profileDropdown" class="dropdown-menu absolute right-0 mt-2 w-72 bg-white rounded-xl shadow-lg border border-gray-200 py-1">
                            <div class="px-6 py-4 border-b border-gray-100">
                                <div class="flex items-center space-x-4">
                                    <img src="data:image/jpeg;base64,${profileImage}" alt="Profile" class="h-14 w-14 rounded-full">
                                    <div>
                                        <p class="text-base font-semibold text-gray-900">${first_name} ${last_name}</p>
                                        <p class="text-sm text-gray-500">${rgukt_email}</p>
                                        <div class="flex items-center mt-1">
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-indigo-100 text-indigo-800">
                                                <i class="fas fa-star mr-1"></i>850 Points
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="py-2">
                                <a href="profile" class="flex items-center px-6 py-3 text-sm text-gray-700 hover:bg-gray-50 transition">
                                    <i class="fas fa-user-circle mr-3 text-gray-400 w-5"></i>My Profile
                                </a>
                                <a href="changepassword" class="flex items-center px-6 py-3 text-sm text-gray-700 hover:bg-gray-50 transition">
                                    <i class="fas fa-cog mr-3 text-gray-400 w-5"></i>Account Settings
                                </a>
                                <a href="#" class="flex items-center px-6 py-3 text-sm text-gray-700 hover:bg-gray-50 transition">
                                    <i class="fas fa-chart-line mr-3 text-gray-400 w-5"></i>Activity Dashboard
                                </a>
                                <a href="#" class="flex items-center px-6 py-3 text-sm text-gray-700 hover:bg-gray-50 transition">
                                    <i class="fas fa-shield-alt mr-3 text-gray-400 w-5"></i>Privacy & Security
                                </a>
                            </div>
                            <div class="border-t border-gray-100 my-1"></div>
                            <div class="py-2">
                                <a href="#" class="flex items-center px-6 py-3 text-sm text-gray-700 hover:bg-gray-50 transition">
                                    <i class="fas fa-question-circle mr-3 text-gray-400 w-5"></i>Help & Support
                                </a>
                                <a href="#" class="flex items-center px-6 py-3 text-sm text-gray-700 hover:bg-gray-50 transition">
                                    <i class="fas fa-book mr-3 text-gray-400 w-5"></i>Documentation
                                </a>
                            </div>
                            <div class="border-t border-gray-100 my-1"></div>
                            <a href="LogoutServlet" class="flex items-center px-6 py-3 text-sm text-red-600 hover:bg-red-50 transition">
                                <i class="fas fa-sign-out-alt mr-3 w-5"></i>Sign Out
                            </a>
                        </div>
                    </div>
                    
                    <!-- Mobile menu button -->
                    <button id="mobileMenuButton" class="md:hidden p-2 rounded-md text-gray-600 hover:text-indigo-600 hover:bg-gray-50 transition">
                        <i class="fas fa-bars text-xl"></i>
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Mobile Search Bar -->
        <div class="md:hidden px-4 pb-3">
            <div class="relative">
                <input type="text" placeholder="Search clubs, events..." 
                       class="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition text-sm">
                <i class="fas fa-search absolute right-3 top-3 text-gray-400"></i>
            </div>
        </div>
    </nav>

    <!-- Mobile Menu -->
    <div id="mobileMenu" class="mobile-menu fixed inset-y-0 right-0 max-w-xs w-full bg-white shadow-xl z-50 md:hidden">
        <div class="p-6">
            <div class="flex justify-between items-center mb-8">
                <span class="text-xl font-bold text-gray-900">Menu</span>
                <button id="closeMobileMenu" class="p-2 rounded-md text-gray-500 hover:text-gray-700 hover:bg-gray-100 transition">
                    <i class="fas fa-times text-xl"></i>
                </button>
            </div>
            <nav class="space-y-1">
                <a href="#" class="block px-4 py-3 text-base font-medium text-indigo-600 bg-indigo-50 rounded-lg">Dashboard</a>
                <a href="#" class="block px-4 py-3 text-base font-medium text-gray-900 hover:bg-gray-50 rounded-lg transition">Explore Clubs</a>
                <a href="#" class="block px-4 py-3 text-base font-medium text-gray-900 hover:bg-gray-50 rounded-lg transition">Events</a>
                <a href="#" class="block px-4 py-3 text-base font-medium text-gray-900 hover:bg-gray-50 rounded-lg transition">My Clubs</a>
                <div class="pt-4 mt-4 border-t border-gray-200">
                    <a href="profile_page.jsp" class="block px-4 py-3 text-base font-medium text-gray-900 hover:bg-gray-50 rounded-lg transition">Profile</a>
                    <a href="#" class="block px-4 py-3 text-base font-medium text-gray-900 hover:bg-gray-50 rounded-lg transition">Settings</a>
                    <a href="#" class="block px-4 py-3 text-base font-medium text-gray-900 hover:bg-gray-50 rounded-lg transition">Help & Support</a>
                    <a href="#" class="block px-4 py-3 text-base font-medium text-red-600 hover:bg-red-50 rounded-lg transition">Sign Out</a>
                </div>
            </nav>
        </div>
    </div>

    <!-- Hero Section -->
    <section class="gradient-bg text-white py-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="fade-in">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-4xl md:text-5xl font-bold mb-4">Welcome back, ${first_name}!</h1>
                        <p class="text-xl mb-8 opacity-90 max-w-2xl">Discover new opportunities, join exciting events, and connect with your campus community</p>
                        <div class="flex flex-wrap gap-4">
                            <a href="Clublist.jsp">
                            <button class="bg-white text-indigo-600 px-8 py-3.5 rounded-lg font-semibold hover:bg-gray-50 transition transform hover:scale-105 shadow-lg">
                                <i class="fas fa-plus mr-2"></i>Explore Clubs
                            </button>
                            </a>
                            <a href="view_event.jsp">
                            <button class="border-2 border-white text-white px-8 py-3.5 rounded-lg font-semibold hover:bg-white hover:text-indigo-600 transition">
                                <i class="fas fa-calendar mr-2"></i>View Events
                            </button>
                            </a>
                        </div>
                    </div>
                    <div class="hidden lg:block">
                        <div class="bg-white/10 backdrop-blur-sm rounded-2xl p-8">
                            <div class="text-center">
                                <p class="text-6xl font-bold mb-2">850</p>
                                <p class="text-lg opacity-90">Club Points</p>
                                <div class="mt-4 flex justify-center">
                                    <i class="fas fa-trophy text-4xl text-yellow-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Stats -->
    <section class="py-8 -mt-8">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                <div class="stat-card rounded-xl shadow-sm p-6 card-hover">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-gray-500 text-sm font-medium">My Clubs</p>
                            <p class="text-3xl font-bold text-gray-900 mt-1">5</p>
                            <p class="text-xs text-green-600 mt-2">
                                <i class="fas fa-arrow-up mr-1"></i>12% this month
                            </p>
                        </div>
                        <div class="bg-indigo-100 p-3 rounded-xl">
                            <i class="fas fa-users text-indigo-600 text-xl"></i>
                        </div>
                    </div>
                </div>
                <div class="stat-card rounded-xl shadow-sm p-6 card-hover">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-gray-500 text-sm font-medium">Upcoming Events</p>
                            <p class="text-3xl font-bold text-gray-900 mt-1">12</p>
                            <p class="text-xs text-blue-600 mt-2">
                                <i class="fas fa-clock mr-1"></i>3 this week
                            </p>
                        </div>
                        <div class="bg-blue-100 p-3 rounded-xl">
                            <i class="fas fa-calendar-check text-blue-600 text-xl"></i>
                        </div>
                    </div>
                </div>
                <div class="stat-card rounded-xl shadow-sm p-6 card-hover">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-gray-500 text-sm font-medium">Points Earned</p>
                            <p class="text-3xl font-bold text-gray-900 mt-1">850</p>
                            <p class="text-xs text-green-600 mt-2">
                                <i class="fas fa-arrow-up mr-1"></i>+50 today
                            </p>
                        </div>
                        <div class="bg-green-100 p-3 rounded-xl">
                            <i class="fas fa-star text-green-600 text-xl"></i>
                        </div>
                    </div>
                </div>
                <div class="stat-card rounded-xl shadow-sm p-6 card-hover">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-gray-500 text-sm font-medium">Achievements</p>
                            <p class="text-3xl font-bold text-gray-900 mt-1">8</p>
                            <p class="text-xs text-yellow-600 mt-2">
                                <i class="fas fa-medal mr-1"></i>2 new
                            </p>
                        </div>
                        <div class="bg-yellow-100 p-3 rounded-xl">
                            <i class="fas fa-trophy text-yellow-600 text-xl"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Left Column -->
            <div class="lg:col-span-2 space-y-8">
                <!-- Featured Clubs -->
                <section>
                    <div class="flex justify-between items-center mb-6">
                        <h2 class="text-2xl font-bold text-gray-900">Featured Clubs</h2>
                        <a href="Clublist.jsp" class="text-indigo-600 hover:text-indigo-700 font-medium flex items-center">
                            View All <i class="fas fa-arrow-right ml-1 text-sm"></i>
                        </a>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden card-hover">
                            <div class="relative">
                                <img src="https://picsum.photos/seed/club1/400/200" alt="Coding Club" class="w-full h-48 object-cover">
                                <div class="absolute top-4 right-4">
                                    <span class="bg-indigo-600 text-white px-3 py-1 rounded-full text-xs font-medium">Technology</span>
                                </div>
                            </div>
                            <div class="p-6">
                                <h3 class="text-xl font-bold text-gray-900 mb-2">TechXcel</h3>
                                <p class="text-gray-600 mb-4 text-sm leading-relaxed">Learn programming, participate in hackathons, and build amazing projects together!</p>
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center space-x-4 text-sm text-gray-500">
                                        <span class="flex items-center">
                                            <i class="fas fa-users mr-1"></i>245 members
                                        </span>
                                        <span class="flex items-center">
                                            <i class="fas fa-star mr-1 text-yellow-500"></i>4.8
                                        </span>
                                    </div>
                                    <button class="bg-indigo-600 text-white px-4 py-2 rounded-lg hover:bg-indigo-700 transition text-sm font-medium">
                                        Join Club
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden card-hover">
                            <div class="relative">
                                <img src="https://picsum.photos/seed/club2/400/200" alt="Photography Club" class="w-full h-48 object-cover">
                                <div class="absolute top-4 right-4">
                                    <span class="bg-blue-600 text-white px-3 py-1 rounded-full text-xs font-medium">Arts</span>
                                </div>
                            </div>
                            <div class="p-6">
                                <h3 class="text-xl font-bold text-gray-900 mb-2">PixelRO</h3>
                                <p class="text-gray-600 mb-4 text-sm leading-relaxed">Capture moments, learn photography skills, and showcase your creative vision!</p>
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center space-x-4 text-sm text-gray-500">
                                        <span class="flex items-center">
                                            <i class="fas fa-users mr-1"></i>189 members
                                        </span>
                                        <span class="flex items-center">
                                            <i class="fas fa-star mr-1 text-yellow-500"></i>4.9
                                        </span>
                                    </div>
                                    <button class="bg-indigo-600 text-white px-4 py-2 rounded-lg hover:bg-indigo-700 transition text-sm font-medium">
                                        Join Club
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Upcoming Events -->
                <section>
                    <div class="flex justify-between items-center mb-6">
                        <h2 class="text-2xl font-bold text-gray-900">Upcoming Events</h2>
                        <a href="view_event.jsp" class="text-indigo-600 hover:text-indigo-700 font-medium flex items-center">
                            View Calendar <i class="fas fa-arrow-right ml-1 text-sm"></i>
                        </a>
                    </div>
                                    </section>
            </div>

            <!-- Right Column -->
            <div class="space-y-6">
                <!-- My Clubs -->
                <section class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div class="flex justify-between items-center mb-4">
                        <h3 class="text-lg font-bold text-gray-900">My Clubs</h3>
                        <a href="#" class="text-indigo-600 hover:text-indigo-700 text-sm font-medium">Manage</a>
                    </div>
                    <div class="space-y-3">
                        <div class="flex items-center space-x-3 p-3 hover:bg-gray-50 rounded-lg transition cursor-pointer">
                            <img src="https://picsum.photos/seed/myclub1/40/40" alt="Debate Club" class="w-10 h-10 rounded-lg">
                            <div class="flex-1">
                                <p class="font-medium text-gray-900 text-sm">Debate Club</p>
                                <p class="text-xs text-gray-500">Next meeting: Tomorrow, 4PM</p>
                            </div>
                            <span class="bg-green-100 text-green-700 px-2 py-1 rounded-full text-xs font-medium">Active</span>
                        </div>
                        <div class="flex items-center space-x-3 p-3 hover:bg-gray-50 rounded-lg transition cursor-pointer">
                            <img src="https://picsum.photos/seed/myclub2/40/40" alt="Music Club" class="w-10 h-10 rounded-lg">
                            <div class="flex-1">
                                <p class="font-medium text-gray-900 text-sm">Music Club</p>
                                <p class="text-xs text-gray-500">Practice session: Fri, 4PM</p>
                            </div>
                            <span class="bg-green-100 text-green-700 px-2 py-1 rounded-full text-xs font-medium">Active</span>
                        </div>
                        <div class="flex items-center space-x-3 p-3 hover:bg-gray-50 rounded-lg transition cursor-pointer">
                            <img src="https://picsum.photos/seed/myclub3/40/40" alt="Book Club" class="w-10 h-10 rounded-lg">
                            <div class="flex-1">
                                <p class="font-medium text-gray-900 text-sm">Book Club</p>
                                <p class="text-xs text-gray-500">Reading: The Great Gatsby</p>
                            </div>
                            <span class="bg-yellow-100 text-yellow-700 px-2 py-1 rounded-full text-xs font-medium">Reading</span>
                        </div>
                    </div>
                </section>

                <!-- Recent Activity -->
                <section class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <h3 class="text-lg font-bold text-gray-900 mb-4">Recent Activity</h3>
                    <div class="space-y-4">
                        <div class="flex space-x-3">
                            <div class="bg-indigo-100 rounded-full p-2 h-10 w-10 flex items-center justify-center flex-shrink-0">
                                <i class="fas fa-trophy text-indigo-600 text-sm"></i>
                            </div>
                            <div>
                                <p class="text-sm text-gray-900">You earned <span class="font-semibold text-indigo-600">50 points</span> for attending the Coding Workshop!</p>
                                <p class="text-xs text-gray-500 mt-1">2 hours ago</p>
                            </div>
                        </div>
                        <div class="flex space-x-3">
                            <div class="bg-blue-100 rounded-full p-2 h-10 w-10 flex items-center justify-center flex-shrink-0">
                                <i class="fas fa-user-plus text-blue-600 text-sm"></i>
                            </div>
                            <div>
                                <p class="text-sm text-gray-900">New member joined <span class="font-semibold">Debate Club</span></p>
                                <p class="text-xs text-gray-500 mt-1">5 hours ago</p>
                            </div>
                        </div>
                        <div class="flex space-x-3">
                            <div class="bg-green-100 rounded-full p-2 h-10 w-10 flex items-center justify-center flex-shrink-0">
                                <i class="fas fa-calendar-check text-green-600 text-sm"></i>
                            </div>
                            <div>
                                <p class="text-sm text-gray-900">Event reminder: <span class="font-semibold">Photography Exhibition</span> in 3 days</p>
                                <p class="text-xs text-gray-500 mt-1">Yesterday</p>
                            </div>
                        </div>
                    </div>
                </sect	ion>

                <!-- Club Categories -->
                <section class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <h3 class="text-lg font-bold text-gray-900 mb-4">Browse by Category</h3>
                    <div class="grid grid-cols-2 gap-3">
                        <button class="bg-indigo-50 text-indigo-700 p-4 rounded-lg hover:bg-indigo-100 transition text-sm font-medium">
                            <i class="fas fa-laptop-code mb-2 text-lg"></i><br>Technology
                        </button>
                        <button class="bg-blue-50 text-blue-700 p-4 rounded-lg hover:bg-blue-100 transition text-sm font-medium">
                            <i class="fas fa-palette mb-2 text-lg"></i><br>Arts
                        </button>
                        <button class="bg-green-50 text-green-700 p-4 rounded-lg hover:bg-green-100 transition text-sm font-medium">
                            <i class="fas fa-running mb-2 text-lg"></i><br>Sports
                        </button>
                        <button class="bg-yellow-50 text-yellow-700 p-4 rounded-lg hover:bg-yellow-100 transition text-sm font-medium">
                            <i class="fas fa-book mb-2 text-lg"></i><br>Academic
                        </button>
                    </div>
                </section>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-gray-900 text-gray-300 mt-16">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                <div>
                    <div class="flex items-center mb-4">
                        <div class="bg-gradient-to-r from-indigo-600 to-purple-600 p-2 rounded-lg mr-3">
                            <i class="fas fa-users-cog text-white text-xl"></i>
                        </div>
                        <span class="text-2xl font-bold text-white">ClubSphere</span>
                    </div>
                    <p class="text-sm leading-relaxed">Empowering students to discover, connect, and grow through campus clubs and activities.</p>
                </div>
                <div>
                    <h4 class="font-semibold text-white mb-4">Quick Links</h4>
                    <ul class="space-y-2 text-sm">
                        <li><a href="#" class="hover:text-white transition">About Us</a></li>
                        <li><a href="#" class="hover:text-white transition">Contact</a></li>
                        <li><a href="#" class="hover:text-white transition">Help Center</a></li>
                        <li><a href="#" class="hover:text-white transition">Privacy Policy</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-semibold text-white mb-4">Resources</h4>
                    <ul class="space-y-2 text-sm">
                        <li><a href="#" class="hover:text-white transition">Club Guidelines</a></li>
                        <li><a href="#" class="hover:text-white transition">Event Planning</a></li>
                        <li><a href="#" class="hover:text-white transition">Leadership Tips</a></li>
                        <li><a href="#" class="hover:text-white transition">FAQ</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="font-semibold text-white mb-4">Connect With Us</h4>
                    <div class="flex space-x-4 mb-4">
                        <a href="#" class="text-gray-400 hover:text-white transition text-xl"><i class="fab fa-facebook"></i></a>
                        <a href="#" class="text-gray-400 hover:text-white transition text-xl"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-gray-400 hover:text-white transition text-xl"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="text-gray-400 hover:text-white transition text-xl"><i class="fab fa-linkedin"></i></a>
                    </div>
                    <p class="text-sm">ro.clubsphere@gmail.com</p>
                </div>
            </div>
            <div class="border-t border-gray-800 mt-8 pt-8 text-center text-sm">
                <p>&copy; 2024 ClubSphere. All rights reserved. | Designed for students, by students.</p>
            </div>
        </div>
    </footer>
	<script src="JS/homepage.js"></script>
</body>
</html>