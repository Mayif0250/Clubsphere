// Profile dropdown functionality
        const profileButton = document.getElementById('profileButton');
        const profileDropdown = document.getElementById('profileDropdown');

        profileButton.addEventListener('click', function(e) {
            e.stopPropagation();
            profileDropdown.classList.toggle('show');
        });

        // Close dropdown when clicking outside
        document.addEventListener('click', function() {
            profileDropdown.classList.remove('show');
        });

        // Prevent dropdown from closing when clicking inside
        profileDropdown.addEventListener('click', function(e) {
            e.stopPropagation();
        });

        // Mobile menu functionality
        const mobileMenuButton = document.getElementById('mobileMenuButton');
        const mobileMenu = document.getElementById('mobileMenu');
        const closeMobileMenu = document.getElementById('closeMobileMenu');

        mobileMenuButton.addEventListener('click', function() {
            mobileMenu.classList.add('show');
        });

        closeMobileMenu.addEventListener('click', function() {
            mobileMenu.classList.remove('show');
        });

        // Add smooth scroll behavior
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth' });
                }
            });
        });

        // Simulate real-time updates
        function updateNotificationBadge() {
            const badge = document.querySelector('.notification-badge');
            const currentCount = parseInt(badge.textContent);
            if (Math.random() > 0.7) {
                badge.textContent = currentCount + 1;
                badge.classList.add('animate-bounce');
                setTimeout(() => badge.classList.remove('animate-bounce'), 1000);
            }
        }

        // Update notifications every 30 seconds
        setInterval(updateNotificationBadge, 30000);

        // Add interactive search functionality
        const searchInput = document.querySelector('input[type="text"]');
        searchInput.addEventListener('focus', function() {
            this.parentElement.classList.add('ring-2', 'ring-indigo-500', 'rounded-lg');
        });
        searchInput.addEventListener('blur', function() {
            this.parentElement.classList.remove('ring-2', 'ring-indigo-500', 'rounded-lg');
        });

        // Animate elements on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('fade-in');
                }
            });
        }, observerOptions);

        document.querySelectorAll('.card-hover').forEach(el => {
            observer.observe(el);
        });