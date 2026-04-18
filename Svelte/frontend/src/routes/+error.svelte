<!--
  Component: src/routes/+error.svelte
  Description: A user-friendly 404 "Page Not Found" page for the Coldchain Monitoring project.
-->
<script lang="ts">
	import { goto } from '$app/navigation';
	import { fly } from 'svelte/transition';
</script>

<div class="container">
	<div class="card" in:fly={{ y: 50, duration: 600 }}>
		<div class="icon">🧊</div>
		<h1 class="title">404 - Page Not Found</h1>
		<p class="message">
			Oops! The page you're looking for seems to have melted away or was never here.
		</p>
		<div class="actions">
			<button class="btn dashboard-btn" on:click={() => goto('/Dashboard')}>
				Go to Dashboard
			</button>
			<button class="btn login-btn" on:click={() => goto('/Login')}>
				Back to Login
			</button>
		</div>
	</div>
</div>

<style>
	:global(body) {
		margin: 0;
		font-family: 'Quicksand', 'Segoe UI', sans-serif;
		background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
		min-height: 100vh;
	}

	.container {
		display: flex;
		align-items: center;
		justify-content: center;
		min-height: 100vh;
		padding: 2rem;
		box-sizing: border-box;
	}

	.card {
		max-width: 500px;
		width: 100%;
		background: rgba(255, 255, 255, 0.9);
		border-radius: 1.5rem;
		box-shadow: 0 8px 40px rgba(0, 0, 0, 0.12);
		padding: 3rem;
		text-align: center;
		border: 1px solid rgba(255, 255, 255, 0.2);
	}

	.icon {
		font-size: 4rem;
		line-height: 1;
		animation: float 3s ease-in-out infinite;
	}

	@keyframes float {
		0% {
			transform: translateY(0px);
		}
		50% {
			transform: translateY(-10px);
		}
		100% {
			transform: translateY(0px);
		}
	}

	.title {
		font-size: 2.5rem;
		font-weight: 800;
		color: #005bea;
		margin: 1.5rem 0 1rem;
	}

	.message {
		font-size: 1.1rem;
		color: #333;
		line-height: 1.6;
		margin-bottom: 2.5rem;
	}

	.actions {
		display: flex;
		justify-content: center;
		gap: 1rem;
		flex-wrap: wrap;
	}

	.btn {
		border: none;
		border-radius: 2rem;
		padding: 0.8rem 2rem;
		font-size: 1rem;
		font-weight: 700;
		cursor: pointer;
		transition: transform 0.18s, box-shadow 0.18s;
	}

	.btn:hover {
		transform: scale(1.05);
		box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
	}

	.dashboard-btn {
		background: linear-gradient(90deg, #00c6fb 0%, #005bea 100%);
		color: white;
	}

	.login-btn {
		background: #e0e0e0;
		color: #333;
	}
</style>
