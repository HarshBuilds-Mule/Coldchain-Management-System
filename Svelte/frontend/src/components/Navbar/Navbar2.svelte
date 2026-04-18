<!-- 
  Component: Navbar.svelte
  Description: A reusable, collapsible sidebar navigation for the Coldchain Monitoring project.
-->
<script lang="ts">
	import { goto } from '$app/navigation';
	import { fly, fade } from 'svelte/transition';

	// State to control the visibility of the navbar
	let isOpen = false;

	// Function to toggle the navbar state
	function toggleNav() {
		isOpen = !isOpen;
	}

    // Function to navigate to a new page and close the nav
    function navigate(path: string) {
        isOpen = false;
        goto(path);
    }
</script>

<!-- 
  The menu toggle button is positioned at the top-left of the viewport.
  It's always visible and sits above other content.
-->
<button
	on:click={toggleNav}
	class="menu-toggle"
	aria-label="Toggle navigation"
	aria-expanded={isOpen}
>
	<!-- Simple animated hamburger icon -->
	<div class="hamburger-box">
		<div class="hamburger-inner"></div>
	</div>
</button>

<!-- 
  A semi-transparent backdrop that covers the main content when the nav is open.
  Clicking it will close the navigation.
-->
{#if isOpen}
	<button
		type="button"
		class="backdrop"
		aria-label="Close navigation"
		tabindex="0"
		on:click={() => (isOpen = false)}
		on:keydown={(e) => { if (e.key === 'Enter' || e.key === ' ') { isOpen = false; } }}
		transition:fade={{ duration: 300 }}
	></button>
{/if}

<!-- 
  The main sidebar element. It uses a Svelte class directive to toggle
  the 'open' class based on the `isOpen` state, which triggers the CSS transition.
-->
<aside class="sidenav" class:open={isOpen}>
	<!-- Header section of the navbar -->
	<div class="nav-header">
		<h1 class="nav-title">Coldchain</h1>
	</div>

	<!-- Main navigation links -->
	<nav class="nav-links">
		<ul>
			<li><button on:click={() => navigate('/Landing_Page')}>Home</button></li>
			<li><button on:click={() => navigate('/Dashboard')}>Dashboard</button></li>
			<li><button on:click={() => goto('/Shipment')}>Shipments</button></li>
			<li><button on:click={() => goto('/Alerts')}>Alerts</button></li>
			<li><button on:click={() => goto('/Admin')}>Admin</button></li>
		</ul>
	</nav>

	<!-- Footer section with authentication buttons -->
	<div class="nav-footer">
		<button class="btn" on:click={() => navigate('/ProfileSettings')}>Profile Settings</button>
	</div>
</aside>

<style>
	/* --- Toggle Button Styles --- */
	.menu-toggle {
		position: fixed;
		top: 1.5rem;
		left: 1.5rem;
		z-index: 1100; /* Ensures it's above the navbar and content */
		background: #fff;
		border-radius: 50%;
		width: 50px;
		height: 50px;
		border: none;
		cursor: pointer;
		box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
		display: flex;
		align-items: center;
		justify-content: center;
		transition: transform 0.3s ease;
	}

	.menu-toggle:hover {
		transform: scale(1.1);
	}

	.hamburger-box {
		width: 24px;
		height: 18px;
		position: relative;
	}

	.hamburger-inner,
	.hamburger-inner::before,
	.hamburger-inner::after {
		content: '';
		position: absolute;
		width: 24px;
		height: 3px;
		background-color: #005bea;
		border-radius: 3px;
		transition: transform 0.3s ease;
	}

	.hamburger-inner {
		top: 50%;
		transform: translateY(-50%);
	}

	.hamburger-inner::before {
		top: -8px;
	}

	.hamburger-inner::after {
		bottom: -8px;
	}

    /* --- Animation for the hamburger icon when nav is open --- */
	:global(.open) + .menu-toggle .hamburger-inner {
		transform: rotate(45deg);
	}
	:global(.open) + .menu-toggle .hamburger-inner::before {
		top: 0;
		transform: rotate(90deg);
	}
	:global(.open) + .menu-toggle .hamburger-inner::after {
		bottom: 0;
		transform: rotate(90deg);
        opacity: 0; /* Hide bottom bar for a cleaner 'X' */
	}


	/* --- Backdrop Styles --- */
	.backdrop {
		position: fixed;
		top: 0;
		left: 0;
		width: 100vw;
		height: 100vh;
		background: rgba(0, 0, 0, 0.5);
		z-index: 999; /* Below the navbar, above the content */
	}

	/* --- Sidenav Styles --- */
	.sidenav {
		position: fixed;
		top: 0;
		left: 0;
		height: 100%;
		width: 280px;
		background: linear-gradient(180deg, #ffffff 0%, #f0f8ff 100%);
		box-shadow: 4px 0px 20px rgba(0, 0, 0, 0.1);
		z-index: 1000;
		display: flex;
		flex-direction: column;
		/* Hide by default */
		transform: translateX(-100%);
		transition: transform 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
        font-family: 'Quicksand', 'Segoe UI', sans-serif;
	}

	.sidenav.open {
		/* Show when open class is applied */
		transform: translateX(0);
	}

	/* --- Navbar Header --- */
	.nav-header {
		display: flex;
		align-items: center;
		padding: 1.5rem;
		gap: 1rem;
		border-bottom: 1px solid #e0e0e0;
	}

	.nav-title {
		font-size: 1.5rem;
		font-weight: 700;
		color: #005bea;
		margin: 0;
        padding-left: 60px;
        padding-top: 9px;
	}

	/* --- Navbar Links --- */
	.nav-links {
		flex-grow: 1; /* Pushes the footer to the bottom */
		padding-top: 1rem;
	}

	.nav-links ul {
		list-style: none;
		padding: 0;
		margin: 0;
	}

	.nav-links button {
		display: block;
		width: 100%;
		text-align: left;
		padding: 1rem 1.5rem;
		font-size: 1.1rem;
		color: #333;
		border: none;
		background: transparent;
		cursor: pointer;
		transition: background-color 0.2s ease, color 0.2s ease;
        font-weight: 600;
	}

	.nav-links button:hover {
		background-color: #e3f2fd;
		color: #005bea;
	}

	/* --- Navbar Footer --- */
	.nav-footer {
		padding: 1.5rem;
		display: flex;
		flex-direction: column;
		gap: 0.75rem;
		border-top: 1px solid #e0e0e0;
	}

	.btn {
		background: linear-gradient(90deg, #f7971e 0%, #ffd200 100%);
		color: #fff;
		border: none;
		border-radius: 2rem;
		padding: 0.7rem 1.5rem;
		font-size: 1rem;
		font-weight: 600;
		cursor: pointer;
		box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
		transition: transform 0.18s, background 0.18s;
		text-align: center;
	}

	.btn:hover {
		transform: scale(1.05);
		background: linear-gradient(90deg, #ffd200 0%, #f7971e 100%);
	}
</style>
