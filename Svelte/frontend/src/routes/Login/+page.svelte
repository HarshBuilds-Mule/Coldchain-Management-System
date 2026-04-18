<!--
  Component: src/routes/login/+page.svelte
  Description: A graphically rich and interactive login page that authenticates against a live API endpoint.
-->
<script lang="ts">
    import { fly, fade } from "svelte/transition";
    import { goto } from "$app/navigation";
    import Navbar from "../../components/Navbar/Navbar.svelte";

    // Form state
    let email = "";
    let password = "";
    let rememberMe = false;
    let isSubmitting = false;
    let errorMessage = "";

    // --- API Authentication ---
    async function handleSubmit() {
        isSubmitting = true;
        errorMessage = "";

        try {
            const response = await fetch(
                "http://localhost:8088/exp/auth/login",
                {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify({ email, password }),
                },
            );

            if (response.ok) {
                // Handle successful login
                // In a real app, you would store the received token (e.g., in localStorage or a cookie)
                // const data = await response.json();
                // storeAuthToken(data.token);

                // For now, we'll just redirect
                goto("/Dashboard");
            } else {
                // Handle other server errors
                errorMessage = "You entered the wrong Credentials!!.";
            }
        } catch (error) {
            // Handle network errors (CORS, server down, etc.)
            console.error("Login API call failed:", error);
            errorMessage =
                "Could not connect to the server. Please check your connection.";
        } finally {
            isSubmitting = false;
        }
    }
</script>

<Navbar />

<div class="page-container">
    <!-- Animated Background Bubbles -->
    <div class="animated-bg">
        <div class="bubble bubble1"></div>
        <div class="bubble bubble2"></div>
        <div class="bubble bubble3"></div>
        <div class="bubble bubble4"></div>
    </div>

    <div class="login-card" in:fly={{ y: -40, duration: 600 }}>
        <div class="card-header">
            <div class="logo-circle">
                <span class="logo-icon">❄️</span>
            </div>
            <h2>Welcome Back!</h2>
            <p>Sign in to access your dashboard.</p>
        </div>

        <form on:submit|preventDefault={handleSubmit}>
            <div class="form-group floating-label-group">
                <input
                    type="email"
                    id="email"
                    bind:value={email}
                    required
                    placeholder=" "
                />
                <label for="email">Email Address</label>
            </div>

            <div class="form-group floating-label-group">
                <input
                    type="password"
                    id="password"
                    bind:value={password}
                    required
                    placeholder=" "
                />
                <label for="password">Password</label>
            </div>

            <div class="form-options">
                <label class="checkbox-container">
                    <input type="checkbox" bind:checked={rememberMe} />
                    <span class="checkmark"></span>
                    Remember me
                </label>
                <a href="/ResetPass" class="forgot-password-link"
                    >Forgot Password?</a
                >
            </div>

            {#if errorMessage}
                <div class="error-banner" in:fade>
                    {errorMessage}
                </div>
            {/if}

            <button type="submit" class="login-btn" disabled={isSubmitting}>
                {#if isSubmitting}
                    <div class="spinner"></div>
                    <span>Signing In...</span>
                {:else}
                    <span>Sign In</span>
                {/if}
            </button>
        </form>

        <div class="signup-link">
            <span>Don't have an account?</span>
            <a href="/SignUp">Sign Up</a>
        </div>
    </div>
</div>

<style>
    :global(body) {
        margin: 0;
        font-family: "Quicksand", "Segoe UI", sans-serif;
        background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
        min-height: 100vh;
        overflow: hidden; /* Hide scrollbars from bubbles */
    }

    .page-container {
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
        padding: 2rem;
        position: relative;
        z-index: 1;
    }

    .login-card {
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: 1.5rem;
        box-shadow: 0 16px 40px rgba(0, 0, 0, 0.12);
        padding: 2.5rem 3rem;
        width: 100%;
        max-width: 450px;
        text-align: center;
    }

    .card-header {
        margin-bottom: 2rem;
    }
    .logo-circle {
        width: 70px;
        height: 70px;
        background: radial-gradient(
            circle at 30% 30%,
            #00c6fb 60%,
            #005bea 100%
        );
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 24px rgba(0, 0, 0, 0.08);
        margin: 0 auto 1rem auto;
    }
    .logo-icon {
        font-size: 2.2rem;
        color: #fff;
    }
    .card-header h2 {
        font-size: 2rem;
        font-weight: 800;
        color: #005bea;
        margin: 0 0 0.5rem 0;
    }
    .card-header p {
        font-size: 1.1rem;
        color: #555;
        margin: 0;
    }

    /* Floating Label Form */
    .form-group {
        text-align: left;
    }
    .floating-label-group {
        position: relative;
        margin-bottom: 1.5rem;
    }
    .floating-label-group input {
        width: 100%;
        padding: 1rem;
        border: 2px solid #ccc;
        border-radius: 0.5rem;
        font-size: 1rem;
        font-family: "Quicksand", sans-serif;
        background-color: #f8f9fa;
        box-sizing: border-box;
        transition: border-color 0.2s;
    }
    .floating-label-group label {
        position: absolute;
        left: 1rem;
        top: 1rem;
        color: #999;
        background: #f8f9fa;
        padding: 0 0.25rem;
        transition: all 0.2s ease-out;
        pointer-events: none;
    }
    .floating-label-group input:focus,
    .floating-label-group input:not(:placeholder-shown) {
        border-color: #005bea;
    }
    .floating-label-group input:focus + label,
    .floating-label-group input:not(:placeholder-shown) + label {
        top: -0.75rem;
        left: 0.75rem;
        font-size: 0.9rem;
        color: #005bea;
    }

    .form-options {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1.5rem;
        font-size: 0.9rem;
    }
    .forgot-password-link {
        color: #005bea;
        font-weight: 600;
        text-decoration: none;
    }
    .forgot-password-link:hover {
        text-decoration: underline;
    }

    /* Custom Checkbox */
    .checkbox-container {
        display: flex;
        align-items: center;
        cursor: pointer;
        user-select: none;
    }
    .checkbox-container input {
        opacity: 0;
        cursor: pointer;
        height: 0;
        width: 0;
    }
    .checkmark {
        height: 20px;
        width: 20px;
        background-color: #eee;
        border-radius: 4px;
        margin-right: 8px;
        border: 1px solid #ccc;
        position: relative;
    }
    .checkbox-container:hover .checkmark {
        background-color: #ddd;
    }
    .checkbox-container input:checked ~ .checkmark {
        background-color: #005bea;
    }
    .checkmark:after {
        content: "";
        position: absolute;
        display: none;
        left: 6px;
        top: 2px;
        width: 5px;
        height: 10px;
        border: solid white;
        border-width: 0 3px 3px 0;
        transform: rotate(45deg);
    }
    .checkbox-container input:checked ~ .checkmark:after {
        display: block;
    }

    .error-banner {
        padding: 0.75rem;
        background-color: #ffcdd2;
        color: #c62828;
        text-align: center;
        border-radius: 0.5rem;
        margin-bottom: 1.5rem;
        font-weight: 600;
    }

    .login-btn {
        background: linear-gradient(90deg, #00c6fb 0%, #005bea 100%);
        color: #fff;
        border: none;
        border-radius: 2rem;
        padding: 0.8rem 2rem;
        font-size: 1.1rem;
        font-weight: 700;
        cursor: pointer;
        box-shadow: 0 4px 20px rgba(0, 91, 234, 0.3);
        transition: all 0.2s;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
    }
    .login-btn:hover:not(:disabled) {
        transform: translateY(-3px);
        box-shadow: 0 6px 25px rgba(0, 91, 234, 0.4);
    }
    .login-btn:disabled {
        background: #ccc;
        cursor: not-allowed;
    }
    .spinner {
        width: 20px;
        height: 20px;
        border: 3px solid rgba(255, 255, 255, 0.3);
        border-top-color: #fff;
        border-radius: 50%;
        animation: spin 1s linear infinite;
    }
    @keyframes spin {
        to {
            transform: rotate(360deg);
        }
    }

    .signup-link {
        font-weight: 500;
        margin-top: 2rem;
    }
    .signup-link a {
        color: #005bea;
        font-weight: 700;
        text-decoration: none;
    }
    .signup-link a:hover {
        text-decoration: underline;
    }

    /* Animated Background */
    .animated-bg {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        z-index: 0;
        pointer-events: none;
        overflow: hidden;
    }
    .bubble {
        position: absolute;
        border-radius: 50%;
        opacity: 0.18;
        animation: bubbleMove 12s infinite alternate;
    }
    .bubble1 {
        width: 120px;
        height: 120px;
        background: #00c6fb;
        left: 10%;
        top: 18%;
        animation-delay: 0s;
    }
    .bubble2 {
        width: 80px;
        height: 80px;
        background: #ffd200;
        right: 12%;
        top: 30%;
        animation-delay: 2s;
    }
    .bubble3 {
        width: 60px;
        height: 60px;
        background: #f7971e;
        left: 25%;
        bottom: 15%;
        animation-delay: 4s;
    }
    .bubble4 {
        width: 100px;
        height: 100px;
        background: #fed6e3;
        right: 18%;
        bottom: 10%;
        animation-delay: 6s;
    }
    @keyframes bubbleMove {
        0% {
            transform: translateY(0) scale(1) rotate(0deg);
        }
        100% {
            transform: translateY(-50px) scale(1.1) rotate(45deg);
        }
    }
</style>
