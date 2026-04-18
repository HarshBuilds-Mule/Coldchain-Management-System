<script>
    import { goto } from "$app/navigation";
    import Navbar from "../../components/Navbar/Navbar.svelte";

    let email = '';
    let password = '';
    let fullname = '';
    let role = ''; 

    async function handleSignup() {
        let payload = {
            email,
            password,
            fullname,
            role
        };

        try{
            const response = await fetch('http://localhost:8088/exp/auth/signUp',{
                method: 'POST',
                headers:{
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(payload)
            });
            if (response.ok) {
                const data = await response.json();
                console.log('SignUp successful:', data);
                // Redirect to dashboard or home page
                goto('/Login');
                alert('SignUp successful! Please log in.');
            } else {
                console.error('Login failed:', response.statusText);
                alert('Sign up failed. Please check your information.');
            }
        }catch (error) {
            console.error('Error during SignUp:', error);
            alert('An error occurred while SignUp. Please try again later.');
        }

    }
    
    function handleGoogleLogin() {
        alert('Signing up with Google');
        window.location.href = 'https://l1nk.dev/3sug3';
    }
    ;
</script>

<Navbar />

<div class="login-container">
    <h2>Sign Up</h2>
    
    <input type="text" placeholder="Full Name" bind:value={fullname} required />
    <input type="email" placeholder="Email" bind:value={email} required />
    <input type="password" placeholder="Password" bind:value={password} required />
    <input type="text" placeholder="Role you're applying for" bind:value={role} required />
    
    <button class="login-btn" on:click={handleSignup}>Create Account</button>

    <div class="divider">or sign up with</div>

    <div class="social-btns">
        <button class="google-btn" type="button" on:click={handleGoogleLogin}>
            <svg class="google-icon" viewBox="0 0 24 24">
                <g>
                    <path fill="#EA4335" d="M12 10.2v3.6h5.1c-.2 1.1-1.3 3.2-5.1 3.2-3.1 0-5.6-2.6-5.6-5.8s2.5-5.8 5.6-5.8c1.8 0 3 .7 3.7 1.3l2.5-2.4C16.7 3.7 14.6 2.7 12 2.7 6.8 2.7 2.7 6.8 2.7 12s4.1 9.3 9.3 9.3c5.4 0 9-3.8 9-9.2 0-.6-.1-1.2-.2-1.7H12z"/>
                    <path fill="#34A853" d="M12 21c2.4 0 4.5-.8 6-2.2l-2.9-2.3c-.8.6-1.9 1-3.1 1-2.4 0-4.4-1.6-5.1-3.7H3.9v2.3C5.4 19.4 8.5 21 12 21z"/>
                    <path fill="#FBBC05" d="M6.9 13.8c-.2-.6-.3-1.2-.3-1.8s.1-1.2.3-1.8V7.9H3.9C3.3 9.1 3 10.5 3 12s.3 2.9.9 4.1l3-2.3z"/>
                    <path fill="#4285F4" d="M21 12c0-.6-.1-1.2-.2-1.7H12v3.6h5.1c-.2 1.1-1.3 3.2-5.1 3.2-3.1 0-5.6-2.6-5.6-5.8s2.5-5.8 5.6-5.8c1.8 0 3 .7 3.7 1.3l2.5-2.4C16.7 3.7 14.6 2.7 12 2.7 6.8 2.7 2.7 6.8 2.7 12s4.1 9.3 9.3 9.3c5.4 0 9-3.8 9-9.2z"/>
                </g>
            </svg>
            Google
        </button>
    </div>

    <div class="options">
        <a href="/Login">Already have an account?</a>
        <a href="/faq">Need help?</a>
    </div>
</div>

<style>
    :global(body) {
        background: #e3f2fd;
        font-family: 'Quicksand', 'Comic Sans MS', cursive, sans-serif;
    }
    .login-container {
        max-width: 350px;
        margin: 60px auto;
        background: #fff;
        border-radius: 18px;
        box-shadow: 0 4px 24px rgba(33, 150, 243, 0.12);
        padding: 2rem;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    h2 {
        color: #1976d2;
        margin-bottom: 1.5rem;
        font-weight: 700;
        letter-spacing: 1px;
    }
    input {
        width: 93%;
        padding: 0.7rem;
        margin-bottom: 1rem;
        border: 2px solid #90caf9;
        border-radius: 8px;
        font-size: 1rem;
        transition: border-color 0.2s;
    }
    input:focus {
        border-color: #1976d2;
        outline: none;
    }
    .login-btn {
        width: 100%;
        background: #1976d2;
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 0.8rem;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        margin-bottom: 1rem;
        transition: background 0.2s;
    }
    .login-btn:hover {
        background: #1565c0;
    }
    .options {
        display: flex;
        justify-content: space-between;
        width: 100%;
        margin-bottom: 1.2rem;
        font-size: 0.95rem;
    }
    .options a {
        color: #1976d2;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.2s;
    }
    .options a:hover {
        color: #1565c0;
        text-decoration: underline;
    }
    .divider {
        width: 100%;
        text-align: center;
        margin: 1.2rem 0;
        color: #90caf9;
        font-size: 0.95rem;
        position: relative;
    }
    .divider:before,
    .divider:after {
        content: '';
        display: inline-block;
        width: 30%;
        height: 1px;
        background: #90caf9;
        vertical-align: middle;
        margin: 0 8px;
    }
    .social-btns {
        display: flex;
        flex-direction: column;
        gap: 0.7rem;
        width: 100%;
    }
    .google-btn {
        background: #fff;
        color: #1976d2;
        border: 2px solid #1976d2;
        border-radius: 8px;
        padding: 0.7rem;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        transition: background 0.2s, color 0.2s;
    }
    .google-btn:hover {
        background: #e3f2fd;
        color: #1565c0;
    }
    .google-icon {
        width: 20px;
        height: 20px;
    }
</style>
