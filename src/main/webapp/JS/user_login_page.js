document.addEventListener('DOMContentLoaded', function () {
    // Get form elements
    const form = document.getElementById('loginForm');
    const email = document.getElementById('email');
    const password = document.getElementById('password');
    const togglePassword = document.getElementById('toggle-password');
    const loginBtn = document.getElementById('login-btn');
    const googleBtn = document.getElementById('google-btn'); // Get Google button
    const toast = document.getElementById('toast');

    // --- HELPER FUNCTIONS ---
    const showError = (input, message) => { const inputGroup = input.closest('.input-group'); inputGroup.classList.add('error'); const errorMessage = inputGroup.querySelector('.error-message'); errorMessage.textContent = message; };
    const showSuccess = (input) => { const inputGroup = input.closest('.input-group'); inputGroup.classList.remove('error'); const errorMessage = inputGroup.querySelector('.error-message'); errorMessage.textContent = ''; };
    const isEmailValid = (emailValue) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailValue);
    const isRequired = value => value.trim() !== '';

    // --- VALIDATION LOGIC ---
    const checkEmail = () => { let valid = false; const emailValue = email.value.trim(); if (!isRequired(emailValue)) { showError(email, 'Email address is required.'); } else if (!isEmailValid(emailValue)) { showError(email, 'Please enter a valid email address.'); } else { showSuccess(email); valid = true; } return valid; };
    const checkPassword = () => { let valid = false; const passwordValue = password.value; if (!isRequired(passwordValue)) { showError(password, 'Password is required.'); } else { showSuccess(password); valid = true; } return valid; };

    // --- SHOW/HIDE PASSWORD ---
    togglePassword.addEventListener('click', function () { const type = password.getAttribute('type') === 'password' ? 'text' : 'password'; password.setAttribute('type', type); this.classList.toggle('fa-eye'); this.classList.toggle('fa-eye-slash'); });

    // --- REAL-TIME VALIDATION ---
    const debounce = (fn, delay = 500) => { let timeoutId; return (...args) => { if (timeoutId) clearTimeout(timeoutId); timeoutId = setTimeout(() => { fn(...args); }, delay); }; };
    form.addEventListener('input', debounce((e) => { if (e.target.id === 'email') checkEmail(); if (e.target.id === 'password') checkPassword(); }));

    // --- FORM SUBMISSION ---
    form.addEventListener('submit', function () {
        const isEmailValid = checkEmail();
        const isPasswordValid = checkPassword();
        const isFormValid = isEmailValid && isPasswordValid;

        if (isFormValid) {
            loginBtn.classList.add('loading'); loginBtn.disabled = true;
            setTimeout(() => {
                showToast('Login Successful! Welcome back.', 'success');
                form.reset();
                document.querySelectorAll('.input-group.success').forEach(group => group.classList.remove('success'));
                loginBtn.classList.remove('loading'); loginBtn.disabled = false;
            }, 2000);
        } else {
            showToast('Please correct the errors and try again.', 'error');
        }
    });

    // START: Google Button Validation
	googleBtn.addEventListener('click', function () {
	    googleBtn.classList.add('loading');
	    googleBtn.disabled = true;
	    // Redirect to servlet that starts Google OAuth
		window.location.href = `google-login`;
	});

    // END: Google Button Validation

    // --- TOAST NOTIFICATION ---
    const showToast = (message, type) => { toast.textContent = message; toast.className = `show ${type}`; setTimeout(() => { toast.className = toast.className.replace('show', ''); }, 3000); };
});