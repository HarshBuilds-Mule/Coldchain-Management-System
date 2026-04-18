<script>
    import { goto } from "$app/navigation";
    import Footer from "../../components/Footer/Footer.svelte";
	import Navbar from "../../components/Navbar/Navbar.svelte";

	

	let faqs = [
		{
			question: "How do I create an account?",
			answer: "Click the 'Sign Up' button on this or home page, fill in your name, email, password, and the role you are applying for. Then click 'Create Account'.",
			open: false
		},
		{
			question: "I forgot my password. What should I do?",
			answer: "On the login page, click the 'Need help?' link. Follow the instructions to reset your password via email.",
			open: false
		},
		{
			question: "What role should I choose while signing up?",
			answer: "Choose the role that best fits your purpose for using the platform (e.g., Admin , Viewer or User).",
			open: false
		},
		{
			question: "Can I sign up with Google?",
			answer: "Yes! On the sign-up page, click the 'Sign up with Google' button and follow the prompts.",
			open: false
		},
		{
			question: "Why do I need to provide my full name?",
			answer: "Your full name helps personalize your account and allows for better communication within the platform.",
			open: false
		}
	];

	// @ts-ignore
	function toggleFAQ(index) {
		faqs = faqs.map((faq, i) => ({
			...faq,
			open: i === index ? !faq.open : faq.open
		}));
	}
</script>

<Navbar />

<div class="container">
	<div class="header">
		<div class="logo-circle">
			<div class="logo-icon">?</div>
		</div>
		<div class="auth-buttons">
			<button class="btn" on:click={() => goto('/Login')}>Login</button>
			<button class="btn" on:click={() => goto('/SignUp')}>Sign Up</button>
		</div>
	</div>

	<div class="main-content">
		<h1 class="title">Need Help?</h1>
		<p class="subtitle">Your FAQs for Login & Sign Up</p>

		{#each faqs as faq, i}
			<button
				type="button"
				class="info-card"
				aria-expanded={faq.open}
				aria-controls={"faq-answer-" + i}
				on:click={() => toggleFAQ(i)}
			>
				<strong>{faq.question}</strong>
				{#if faq.open}
					<p id={"faq-answer-" + i} style="margin-top: 1rem;">{faq.answer}</p>
				{/if}
			</button>
		{/each}

		<button class="get-started-btn" on:click={() => goto('/Landing_Page')}>Back to Home</button>
	</div>

	<div class="animated-bg">
		<div class="bubble bubble1"></div>
		<div class="bubble bubble2"></div>
		<div class="bubble bubble3"></div>
		<div class="bubble bubble4"></div>
	</div>
</div>

<Footer />

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
		position: relative;
	}
	.header {
		display: flex;
		justify-content: space-between;
		align-items: flex-start;
		padding: 2rem 3rem 0 3rem;
		z-index: 2;
		padding-left: 85px;
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
	}
	.btn:hover {
		transform: scale(1.08) rotate(-2deg);
		background: linear-gradient(90deg, #ffd200 0%, #f7971e 100%);
	}
	.main-content {
		display: flex;
		flex-direction: column;
		align-items: center;
		margin-top: 2rem;
		z-index: 1;
	}
	.title {
		font-size: 3rem;
		font-weight: 800;
		color: #005bea;
		text-shadow: 0 2px 12px #a8edea;
		margin-bottom: 1rem;
		letter-spacing: 2px;
		animation: popIn 1.2s ease-out;
	}
	.subtitle {
		font-size: 1.5rem;
		color: #333;
		margin-bottom: 2rem;
		animation: fadeInUp 1.2s ease-out;
	}
	.info-card {
		background: rgba(255,255,255,0.85);
		border-radius: 1.5rem;
		box-shadow: 0 4px 32px rgba(0,0,0,0.08);
		padding: 1.5rem 2rem;
		max-width: 480px;
		text-align: left;
		font-size: 1.1rem;
		color: #005bea;
		margin-bottom: 1.2rem;
		cursor: pointer;
		transition: box-shadow 0.2s, transform 0.2s;
	}
	.info-card:hover {
		box-shadow: 0 8px 40px rgba(0,0,0,0.18);
		transform: translateY(-4px);
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
		margin-top: 1.5rem;
	}
	.get-started-btn:hover {
		transform: scale(1.09) rotate(2deg);
		background: linear-gradient(90deg, #005bea 0%, #00c6fb 100%);
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
	.bubble1 { width: 120px; height: 120px; background: #00c6fb; left: 10%; top: 18%; animation-delay: 0s;}
	.bubble2 { width: 80px; height: 80px; background: #ffd200; right: 12%; top: 30%; animation-delay: 2s;}
	.bubble3 { width: 60px; height: 60px; background: #f7971e; left: 25%; bottom: 15%; animation-delay: 1s;}
	.bubble4 { width: 100px; height: 100px; background: #fed6e3; right: 18%; bottom: 10%; animation-delay: 3s;}

	@keyframes bounce {
		to { transform: translateY(-10px) scale(1.05);}
	}
	@keyframes popIn {
		0% { transform: scale(0.7); opacity: 0;}
		80% { transform: scale(1.1);}
		100% { transform: scale(1); opacity: 1;}
	}
	@keyframes fadeInUp {
		from { opacity: 0; transform: translateY(30px);}
		to { opacity: 1; transform: translateY(0);}
	}
	@keyframes bubbleMove {
		0% { transform: translateY(0) scale(1);}
		100% { transform: translateY(-30px) scale(1.08);}
	}
</style>
