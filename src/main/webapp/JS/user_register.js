document.addEventListener('DOMContentLoaded', function () {
    // Form and input elements
    const form = document.getElementById('signupForm');
    const fullname = document.getElementById('fullname');
    const email = document.getElementById('email');
    const password = document.getElementById('password');
    const confirmPassword = document.getElementById('confirm_password');
    const terms = document.getElementById('terms');
    const toast = document.getElementById('toast');
    const submitBtn = document.getElementById('submit-btn');
    
    // Social Login Buttons
    const googleBtn = document.getElementById('google-btn');
    const facebookBtn = document.getElementById('facebook-btn');

    // Password Strength Indicator
    const strengthIndicator = document.getElementById('password-strength-indicator');
    const strengthText = strengthIndicator.querySelector('.strength-text');

    // State variable to prevent multiple social logins at once
    let isSocialLoginInProgress = false;

    // --- HELPER FUNCTIONS ---
    const showError = (input, message) => { const group = input.closest('.input-group, .terms'); if (!group) return; group.classList.remove('success'); group.classList.add('error'); const errorEl = group.querySelector('.error-message'); if (errorEl) errorEl.textContent = message; };
    const showSuccess = (input) => { const group = input.closest('.input-group, .terms'); if (!group) return; group.classList.remove('error'); group.classList.add('success'); const errorEl = group.querySelector('.error-message'); if (errorEl) errorEl.textContent = ''; };
    const isRequired = value => value.trim() !== '';
    const isBetween = (length, min, max) => length >= min && length <= max;
    const isEmailValid = email => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(String(email).toLowerCase());
    const isPasswordSecure = password => /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})/.test(password);

    // --- VALIDATION LOGIC ---
    const checkFullname = () => { let valid = false; const min = 3, max = 30; const nameValue = fullname.value.trim(); if (!isRequired(nameValue)) { showError(fullname, 'Full name cannot be blank.'); } else if (!isBetween(nameValue.length, min, max)) { showError(fullname, `Full name must be between ${min} and ${max} characters.`); } else { showSuccess(fullname); valid = true; } return valid; };
    const checkEmail = () => { let valid = false; const emailValue = email.value.trim(); if (!isRequired(emailValue)) { showError(email, 'Email cannot be blank.'); } else if (!isEmailValid(emailValue)) { showError(email, 'Please enter a valid email address.'); } else { showSuccess(email); valid = true; } return valid; };
    const checkPassword = () => { let valid = false; const passwordValue = password.value; if (!isRequired(passwordValue)) { showError(password, 'Password cannot be blank.'); } else if (!isPasswordSecure(passwordValue)) { showError(password, 'Use 8+ chars with uppercase, lowercase, numbers, & symbols.'); } else { showSuccess(password); valid = true; } return valid; };
    const isPasswordNameSafe = () => { const nameValue = fullname.value.trim().toLowerCase(); const passwordValue = password.value.toLowerCase(); if (nameValue.length < 3 || !passwordValue) return true; const nameParts = nameValue.split(' ').filter(part => part.length >= 3); const nameInPassword = nameParts.some(part => passwordValue.includes(part)); if (nameInPassword) { showError(password, "Password cannot contain your name."); return false; } return true; };
    const checkConfirmPassword = () => { let valid = false; const confirmPasswordValue = confirmPassword.value; const passwordValue = password.value; if (!isRequired(confirmPasswordValue)) { showError(confirmPassword, 'Please confirm your password.'); } else if (passwordValue !== confirmPasswordValue) { showError(confirmPassword, 'Passwords do not match.'); } else { showSuccess(confirmPassword); valid = true; } return valid; };
    const checkTerms = () => { let valid = false; if (!terms.checked) { showError(terms, 'You must accept the terms and conditions.'); } else { showSuccess(terms); valid = true; } return valid; };
    
    const updatePasswordStrength = () => { const passwordValue = password.value; let strength = 0; if (passwordValue.length > 0) { if (passwordValue.length >= 8) strength++; if (passwordValue.match(/[a-z]/)) strength++; if (passwordValue.match(/[A-Z]/)) strength++; if (passwordValue.match(/[0-9]/)) strength++; if (passwordValue.match(/[^a-zA-Z0-9]/)) strength++; } strengthIndicator.className = ''; if (passwordValue.length === 0) { strengthText.textContent = ''; } else if (strength <= 2) { strengthIndicator.classList.add('weak'); strengthText.textContent = 'Weak'; } else if (strength <= 4) { strengthIndicator.classList.add('medium'); strengthText.textContent = 'Medium'; } else { strengthIndicator.classList.add('strong'); strengthText.textContent = 'Strong'; } };

    // --- UI FEEDBACK ---
    const showToast = (message, type) => { toast.textContent = message; toast.className = `show ${type}`; setTimeout(() => { toast.className = toast.className.replace('show', ''); }, 3000); };
    const debounce = (fn, delay = 500) => { let timeoutId; return (...args) => { if (timeoutId) clearTimeout(timeoutId); timeoutId = setTimeout(() => { fn(...args); }, delay); }; };

    // --- REAL-TIME EVENT LISTENERS ---
    form.addEventListener('input', debounce((e) => {
        switch (e.target.id) {
            case 'fullname': checkFullname(); break;
            case 'email': checkEmail(); break;
            case 'password': updatePasswordStrength(); checkPassword(); if (confirmPassword.value) checkConfirmPassword(); break;
            case 'confirm_password': checkConfirmPassword(); break;
            case 'terms': checkTerms(); break;
        }
    }));
    
    // --- FORM SUBMISSION (AFTER CLICK) ---
    form.addEventListener('submit', function (e) {
		form.submit()

        // Run all validations
        const validations = [
            checkFullname(),
            checkEmail(),
            checkPassword(),
            checkConfirmPassword(),
            isPasswordNameSafe(), // Final security check
            checkTerms()
        ];
        
        const isFormValid = validations.every(isValid => isValid);

        if (isFormValid) {
            // --- Handle successful submission ---
            submitBtn.classList.add('loading');
            submitBtn.disabled = true;

            // Simulate network request
            setTimeout(() => {
                showToast('Success! Account created.', 'success');
                form.reset();
                document.querySelectorAll('.input-group.success, .terms.success').forEach(group => group.classList.remove('success'));
                updatePasswordStrength();
                
                // Reset button
                submitBtn.classList.remove('loading');
                submitBtn.disabled = false;
            }, 2000);

        } else {
            // --- Handle validation failure ---
            showToast('Please fix the highlighted errors.', 'error');
            
            // Find all invalid groups, shake them, and find the first one
            const invalidGroups = form.querySelectorAll('.input-group.error, .terms.error');
            invalidGroups.forEach(group => {
                group.classList.add('shake');
                // Remove shake class after animation finishes to allow re-shaking
                setTimeout(() => {
                    group.classList.remove('shake');
                }, 500);
            });

            // Scroll the first invalid element into view
            if(invalidGroups.length > 0) {
                invalidGroups[0].scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        }
    });

    // --- SOCIAL LOGIN VALIDATION (no changes) ---
    const handleSocialLogin = (button, provider) => { if (isSocialLoginInProgress) { showToast('Please wait, another login is in progress.', 'error'); return; } isSocialLoginInProgress = true; button.classList.add('loading'); googleBtn.disabled = true; facebookBtn.disabled = true; setTimeout(() => { const isSuccess = Math.random() > 0.2; if (isSuccess) { showToast(`Successfully authenticated with ${provider}!`, 'success'); form.reset(); document.querySelectorAll('.input-group, .terms').forEach(group => group.classList.remove('success', 'error')); updatePasswordStrength(); } else { showToast(`Authentication with ${provider} failed. Please try again.`, 'error'); } button.classList.remove('loading'); googleBtn.disabled = false; facebookBtn.disabled = false; isSocialLoginInProgress = false; }, 2000); };
    googleBtn.addEventListener('click', () => handleSocialLogin(googleBtn, 'Google'));
    facebookBtn.addEventListener('click', () => handleSocialLogin(facebookBtn, 'Facebook'));
});
document.addEventListener('DOMContentLoaded', function () {
    // Get all elements
    const container = document.querySelector('.container');
    const form = document.getElementById('signupForm');
    const formPanel = document.getElementById('form-panel');
    const fullname = document.getElementById('fullname');
    // ... (rest of the element declarations are the same)

    // --- (All helper and validation functions are the same) ---
    const showError = (input, message) => { const group = input.closest('.input-group, .terms'); if (!group) return; group.classList.remove('success'); group.classList.add('error'); const errorEl = group.querySelector('.error-message'); if (errorEl) errorEl.textContent = message; }; const showSuccess = (input) => { const group = input.closest('.input-group, .terms'); if (!group) return; group.classList.remove('error'); group.classList.add('success'); const errorEl = group.querySelector('.error-message'); if (errorEl) errorEl.textContent = ''; }; const isRequired = value => value.trim() !== ''; const isBetween = (length, min, max) => length >= min && length <= max; const isEmailValid = email => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(String(email).toLowerCase()); const isPasswordSecure = password => /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})/.test(password); const checkFullname = () => { let valid = false; const min = 3, max = 30; const nameValue = fullname.value.trim(); if (!isRequired(nameValue)) { showError(fullname, 'Full name cannot be blank.'); } else if (!isBetween(nameValue.length, min, max)) { showError(fullname, `Full name must be between ${min} and ${max} characters.`); } else { showSuccess(fullname); valid = true; } return valid; }; const checkEmail = () => { let valid = false; const emailValue = email.value.trim(); if (!isRequired(emailValue)) { showError(email, 'Email cannot be blank.'); } else if (!isEmailValid(emailValue)) { showError(email, 'Please enter a valid email address.'); } else { showSuccess(email); valid = true; } return valid; }; const checkPassword = () => { let valid = false; const passwordValue = password.value; if (!isRequired(passwordValue)) { showError(password, 'Password cannot be blank.'); } else if (!isPasswordSecure(passwordValue)) { showError(password, 'Use 8+ chars with uppercase, lowercase, numbers, & symbols.'); } else { showSuccess(password); valid = true; } return valid; }; const isPasswordNameSafe = () => { const nameValue = fullname.value.trim().toLowerCase(); const passwordValue = password.value.toLowerCase(); if (nameValue.length < 3 || !passwordValue) return true; const nameParts = nameValue.split(' ').filter(part => part.length >= 3); const nameInPassword = nameParts.some(part => passwordValue.includes(part)); if (nameInPassword) { showError(password, "Password cannot contain your name."); return false; } return true; }; const checkConfirmPassword = () => { let valid = false; const confirmPasswordValue = confirmPassword.value; const passwordValue = password.value; if (!isRequired(confirmPasswordValue)) { showError(confirmPassword, 'Please confirm your password.'); } else if (passwordValue !== confirmPasswordValue) { showError(confirmPassword, 'Passwords do not match.'); } else { showSuccess(confirmPassword); valid = true; } return valid; }; const checkTerms = () => { let valid = false; if (!terms.checked) { showError(terms, 'You must accept the terms and conditions.'); } else { showSuccess(terms); valid = true; } return valid; }; const updatePasswordStrength = () => { const passwordValue = password.value; let strength = 0; if (passwordValue.length > 0) { if (passwordValue.length >= 8) strength++; if (passwordValue.match(/[a-z]/)) strength++; if (passwordValue.match(/[A-Z]/)) strength++; if (passwordValue.match(/[0-9]/)) strength++; if (passwordValue.match(/[^a-zA-Z0-9]/)) strength++; } strengthIndicator.className = ''; if (passwordValue.length === 0) { strengthIndicator.querySelector('.strength-text').textContent = ''; } else if (strength <= 2) { strengthIndicator.classList.add('weak'); strengthIndicator.querySelector('.strength-text').textContent = 'Weak'; } else if (strength <= 4) { strengthIndicator.classList.add('medium'); strengthIndicator.querySelector('.strength-text').textContent = 'Medium'; } else { strengthIndicator.classList.add('strong'); strengthIndicator.querySelector('.strength-text').textContent = 'Strong'; } }; const showToast = (message, type) => { toast.textContent = message; toast.className = `show ${type}`; setTimeout(() => { toast.className = toast.className.replace('show', ''); }, 3000); }; const debounce = (fn, delay = 500) => { let timeoutId; return (...args) => { if (timeoutId) clearTimeout(timeoutId); timeoutId = setTimeout(() => { fn(...args); }, delay); }; };

    // ... (rest of the script is the same)

    // START: Add Page Load Animation Trigger
    // Use a small timeout to ensure the browser has rendered the initial state
    setTimeout(() => {
        container.classList.add('visible');
    }, 100);
    // END: Add Page Load Animation Trigger

});
