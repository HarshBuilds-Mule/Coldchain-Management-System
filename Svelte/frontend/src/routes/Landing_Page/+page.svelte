<script lang="ts">
    import { goto } from '$app/navigation';
    import { fly, scale, fade } from 'svelte/transition';
    import Navbar from '../../components/Navbar/Navbar.svelte';
    import Footer from '../../components/Footer/Footer.svelte';
    let showInfo = false;

</script>

<style>
    :global(body) {
        margin: 0;
        font-family: 'Quicksand', 'Segoe UI', sans-serif;
        background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
        min-height: 100vh;
    }
    .container {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: stretch;
        position: relative;
        overflow: hidden;
    }
    .header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        padding: 2rem 3rem 0 3rem;
        padding-left: 90px;
        position: relative;
        z-index: 2;
    }
    .logo-circle {
        width: 70px;
        height: 70px;
        background: radial-gradient(circle at 30% 30%, #00c6fb 60%, #005bea 100%);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 24px rgba(0,0,0,0.08);
        animation: bounce 1.2s infinite alternate;
        cursor: pointer;
        transition: box-shadow 0.2s;
        
    }
    .logo-circle:hover {
        box-shadow: 0 8px 32px rgba(0,0,0,0.18);
    }
    @keyframes bounce {
        to { transform: translateY(-10px) scale(1.05);}
    }
    .logo-icon {
        font-size: 2.2rem;
        color: #fff;
        user-select: none;
        
    }
    .auth-buttons {
        display: flex;
        gap: 1rem;
    }
    .btn {
        background: linear-gradient(90deg, #f7971e 0%, #ffd200 100%);
        color: #fff;
        border: none;
        border-radius: 2rem;
        padding: 0.7rem 1.7rem;
        font-size: 1.1rem;
        font-weight: 600;
        cursor: pointer;
        box-shadow: 0 2px 12px rgba(0,0,0,0.08);
        transition: transform 0.18s, background 0.18s;
        outline: none;
        position: relative;
        overflow: hidden;
    }
    .btn:hover {
        transform: scale(1.08) rotate(-2deg);
        background: linear-gradient(90deg, #ffd200 0%, #f7971e 100%);
    }
    .main-content {
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        position: relative;
        z-index: 1;
        margin-top: 2rem;
    }
    .title {
        font-size: 3rem;
        font-weight: 800;
        color: #005bea;
        text-shadow: 0 2px 12px #a8edea;
        margin-bottom: 1rem;
        letter-spacing: 2px;
        animation: popIn 1.2s cubic-bezier(.68,-0.55,.27,1.55);
    }
    @keyframes popIn {
        0% { transform: scale(0.7); opacity: 0;}
        80% { transform: scale(1.1);}
        100% { transform: scale(1); opacity: 1;}
    }
    .subtitle {
        font-size: 1.5rem;
        color: #333;
        margin-bottom: 2rem;
        animation: fadeInUp 1.2s 0.5s both;
    }
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(30px);}
        to { opacity: 1; transform: translateY(0);}
    }
    .info-card {
        background: rgba(255,255,255,0.85);
        border-radius: 1.5rem;
        box-shadow: 0 4px 32px rgba(0,0,0,0.08);
        padding: 2rem 2.5rem;
        max-width: 480px;
        text-align: center;
        font-size: 1.15rem;
        color: #005bea;
        margin-bottom: 2rem;
        cursor: pointer;
        transition: box-shadow 0.2s;
        animation: floatCard 2s infinite alternate;
    }
    .info-card:hover {
        box-shadow: 0 8px 40px rgba(0,0,0,0.18);
    }
    @keyframes floatCard {
        to { transform: translateY(-8px);}
    }
    .animated-bg {
        position: absolute;
        top: 0; left: 0; right: 0; bottom: 0;
        z-index: 0;
        pointer-events: none;
        overflow: hidden;
    }
    .bubble {
        position: absolute;
        border-radius: 50%;
        opacity: 0.18;
        animation: bubbleMove 8s infinite alternate;
    }
    .bubble1 { width: 120px; height: 120px; background: #00c6fb; left: 10%; top: 18%; animation-delay: 0s;padding-left: 10px;}
    .bubble2 { width: 80px; height: 80px; background: #ffd200; right: 12%; top: 30%; animation-delay: 2s;}
    .bubble3 { width: 60px; height: 60px; background: #f7971e; left: 25%; bottom: 15%; animation-delay: 1s;}
    .bubble4 { width: 100px; height: 100px; background: #15d95a; right: 18%; bottom: 10%; animation-delay: 3s;}
    @keyframes bubbleMove {
        0% { transform: translateY(0) scale(1);}
        100% { transform: translateY(-30px) scale(1.08);}
    }
    .get-started-btn {
        background: linear-gradient(90deg, #00c6fb 0%, #005bea 100%);
        color: #fff;
        border: none;
        border-radius: 2rem;
        padding: 1rem 2.5rem;
        font-size: 1.3rem;
        font-weight: 700;
        cursor: pointer;
        box-shadow: 0 2px 16px rgba(0,0,0,0.12);
        transition: transform 0.18s, background 0.18s;
        outline: none;
        margin-top: 1rem;
        animation: popIn 1.2s 0.7s both;
    }
    .get-started-btn:hover {
        transform: scale(1.09) rotate(2deg);
        background: linear-gradient(90deg, #005bea 0%, #00c6fb 100%);
    }
</style>

<Navbar />

<div class="container">
    <div class="header">
        <button type="button" class="logo-circle" on:click={() => showInfo = !showInfo} aria-label="Coldchain Logo" title="About Coldchain">
            <span class="logo-icon">❄️</span>
        </button>
        <div class="auth-buttons">
            <button class="btn" on:click={() => goto('/Login')}>Sign In</button>
            <button class="btn" on:click={() => goto('/SignUp')}>Sign Up</button>
        </div>
    </div>

    <div class="main-content">
        <div class="title" in:fly={{y: -40, duration: 700}}>Coldchain Monitor</div>
        <div class="subtitle" in:fade={{duration: 900}}>
            Playful, interactive monitoring for your temperature-sensitive shipments!
        </div>
        {#if showInfo}
            <div class="info-card" in:scale={{duration: 400}} out:fade={{duration: 300}}>
                <strong>What is Coldchain Monitor?</strong><br>
                Track, visualize and get instant alerts for your coldchain logistics.<br>
                <span style="color:#f7971e;">Live temperature, humidity, and location updates.</span><br>
                <span style="color:#005bea;">Smart notifications. Animated dashboards. Easy integration.</span>
            </div>
        {/if}
        <button class="get-started-btn" on:click={() => showInfo = true}>
            Get Started !!
        </button>
    </div>

    <div class="animated-bg">
        <div class="bubble bubble1"></div>
        <div class="bubble bubble2"></div>
        <div class="bubble bubble3"></div>
        <div class="bubble bubble4"></div>
    </div>
</div>
<Footer />
