<!--
  Component: src/routes/reset-password/+page.svelte
  Description: A graphically rich and interactive page for users to request a password reset link via email.
-->
<script lang="ts">
    import { fly, fade, scale } from 'svelte/transition';
    import { goto } from '$app/navigation';
    import Navbar from '../../components/Navbar/Navbar.svelte';
    import Footer from '../../components/Footer/Footer.svelte';
    

    // Form state
    let email = '';
    let isSubmitting = false;
    let errorMessage = '';
    let successMessage = '';

    // --- API Call for Password Reset ---
    async function handleSubmit() {
        isSubmitting = true;
        errorMessage = '';
        successMessage = '';

        // Basic email validation
        if (!/^\S+@\S+\.\S+$/.test(email)) {
            errorMessage = 'Please enter a valid email address.';
            isSubmitting = false;
            return;
        }

        try {
            const response = await fetch('http://localhost:8085/exp/resetPass', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ email })
            });

            if (response.ok) {
                // On success, show the success message and hide the form.
                successMessage = `A password reset link will be sent to ${email}. Please check your inbox in sometime.`;
            } else {
                errorMessage = 'We got your request. Please check your inbox in sometime.';
            }

        } catch (error) {
            // Handle network errors (CORS, server down, etc.)
            console.error("Password reset API call failed:", error);
            errorMessage = 'Could not connect to the server. Please check your connection.';
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

    <div class="reset-card" in:fly={{ y: -40, duration: 600 }}>
        
        {#if !successMessage}
            <!-- Initial View: Form -->
            <div in:fade={{ duration: 300 }}>
                <div class="card-header">
                    <div class="logo-circle">
                        <span class="logo-icon">🔑</span>
                    </div>
                    <h2>Forgot Your Password?</h2>
                    <p>No problem! Enter your email below and we'll send you a reset link.</p>
                </div>

                <form on:submit|preventDefault={handleSubmit}>
                    <div class="form-group floating-label-group">
                        <input type="email" id="email" bind:value={email} required placeholder=" " />
                        <label for="email">Email Address</label>
                    </div>
                    
                    {#if errorMessage}
                        <div class="error-banner" in:fade>
                            {errorMessage}
                        </div>
                    {/if}

                    <button type="submit" class="submit-btn" disabled={isSubmitting}>
                        {#if isSubmitting}
                            <div class="spinner"></div>
                            <span>Sending...</span>
                        {:else}
                            <span>Send Reset Link</span>
                        {/if}
                    </button>
                </form>

                <div class="back-link">
                    <a href="/Login">← Back to Login</a>
                </div>
            </div>
        {:else}
            <!-- Success View -->
            <div class="success-state" in:scale={{ duration: 400, delay: 200 }}>
                <div class="success-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                </div>
                <h2>Check Your Email!</h2>
                <p>{successMessage}</p>
                 <div class="back-link">
                    <a href="/login">← Back to Login</a>
                </div>
            </div>
        {/if}
    </div>
</div>

<Footer />

<style>
    :global(body) {
        margin: 0;
        font-family: 'Quicksand', 'Segoe UI', sans-serif;
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

    .reset-card {
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: 1.5rem;
        box-shadow: 0 16px 40px rgba(0, 0, 0, 0.12);
        padding: 2.5rem 3rem;
        width: 100%;
        max-width: 480px;
        text-align: center;
    }

    .card-header { margin-bottom: 2rem; }
    .logo-circle {
        width: 70px; height: 70px;
        background: radial-gradient(circle at 30% 30%, #f7971e 60%, #ffd200 100%);
        border-radius: 50%; display: flex; align-items: center; justify-content: center;
        box-shadow: 0 4px 24px rgba(0,0,0,0.08); margin: 0 auto 1rem auto;
    }
    .logo-icon { font-size: 2.2rem; color: #fff; }
    .card-header h2 { font-size: 2rem; font-weight: 800; color: #005bea; margin: 0 0 0.5rem 0; }
    .card-header p { font-size: 1.1rem; color: #555; margin: 0; }

    /* Floating Label Form */
    .form-group { text-align: left; }
    .floating-label-group { position: relative; margin-bottom: 1.5rem; }
    .floating-label-group input {
        width: 100%; padding: 1rem; border: 2px solid #ccc;
        border-radius: 0.5rem; font-size: 1rem; font-family: 'Quicksand', sans-serif;
        background-color: #f8f9fa; box-sizing: border-box; transition: border-color 0.2s;
    }
    .floating-label-group label {
        position: absolute; left: 1rem; top: 1rem; color: #999;
        background: #f8f9fa; padding: 0 0.25rem; transition: all 0.2s ease-out;
        pointer-events: none;
    }
    .floating-label-group input:focus, .floating-label-group input:not(:placeholder-shown) {
        border-color: #005bea;
    }
    .floating-label-group input:focus + label, .floating-label-group input:not(:placeholder-shown) + label {
        top: -0.75rem; left: 0.75rem; font-size: 0.9rem; color: #005bea;
    }
    
    .error-banner {
        padding: 0.75rem; background-color: #ffcdd2; color: #c62828;
        text-align: center; border-radius: 0.5rem; margin-top: -0.5rem; margin-bottom: 1.5rem;
        font-weight: 600;
    }

    .submit-btn {
        background: linear-gradient(90deg, #f7971e 0%, #ffd200 100%);
        color: #fff; border: none; border-radius: 2rem; padding: 0.8rem 2rem;
        font-size: 1.1rem; font-weight: 700; cursor: pointer;
        box-shadow: 0 4px 20px rgba(247, 151, 30, 0.4); transition: all 0.2s;
        width: 100%; display: flex; align-items: center; justify-content: center; gap: 0.5rem;
    }
    .submit-btn:hover:not(:disabled) { transform: translateY(-3px); box-shadow: 0 6px 25px rgba(247, 151, 30, 0.5); }
    .submit-btn:disabled { background: #ccc; cursor: not-allowed; }
    .spinner { width: 20px; height: 20px; border: 3px solid rgba(255,255,255,0.3); border-top-color: #fff; border-radius: 50%; animation: spin 1s linear infinite; }
    @keyframes spin { to { transform: rotate(360deg); } }

    .back-link { font-weight: 500; margin-top: 2rem; }
    .back-link a { color: #005bea; font-weight: 700; text-decoration: none; }
    .back-link a:hover { text-decoration: underline; }

    /* Success State */
    .success-state {
        text-align: center;
        color: #1b5e20; /* Dark green */
    }
    .success-icon {
        width: 80px; height: 80px;
        background-color: #e8f5e9;
        color: #1b5e20;
        border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        margin: 0 auto 1.5rem auto;
    }
    .success-state h2 { font-size: 2rem; font-weight: 800; margin: 0 0 0.5rem 0; }
    .success-state p { font-size: 1.1rem; margin: 0; line-height: 1.6; }


    /* Animated Background */
    .animated-bg { position: absolute; top: 0; left: 0; right: 0; bottom: 0; z-index: 0; pointer-events: none; overflow: hidden; }
    .bubble { position: absolute; border-radius: 50%; opacity: 0.18; animation: bubbleMove 12s infinite alternate; }
    .bubble1 { width: 120px; height: 120px; background: #00c6fb; left: 10%; top: 18%; animation-delay: 0s; }
    .bubble2 { width: 80px; height: 80px; background: #ffd200; right: 12%; top: 30%; animation-delay: 2s; }
    .bubble3 { width: 60px; height: 60px; background: #f7971e; left: 25%; bottom: 15%; animation-delay: 4s; }
    .bubble4 { width: 100px; height: 100px; background: #fed6e3; right: 18%; bottom: 10%; animation-delay: 6s; }
    @keyframes bubbleMove {
        0% { transform: translateY(0) scale(1) rotate(0deg); }
        100% { transform: translateY(-50px) scale(1.1) rotate(45deg); }
    }
</style>
