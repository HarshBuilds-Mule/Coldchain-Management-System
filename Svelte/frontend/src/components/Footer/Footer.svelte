<!--
  Component: src/lib/components/Footer.svelte
  Description: A global, responsive footer for the Coldchain Monitoring project.
-->
<script lang="ts">
	const currentYear = new Date().getFullYear();
</script>

<footer class="site-footer">
	<div class="footer-content">
		<!-- Section 1: Brand and Socials -->
		<div class="footer-section about">
			<div class="logo-text">
				<span class="logo-icon">❄️</span>
				<h2>Coldchain Monitor</h2>
			</div>
			<p class="tagline">
				Ensuring the integrity of your temperature-sensitive shipments, from start to finish.
			</p>
			<div class="social-links">
				<a href="#https://github.com/Code-HK?tab=repositories" aria-label="Twitter">X</a>
				<a href="https://in.linkedin.com/in/harsh-kori-b58836251?trk=people-guest_people_search-card" aria-label="LinkedIn">in</a>
				<a href="https://github.com/Code-HK?tab=repositories" aria-label="GitHub">
					<svg
						xmlns="http://www.w3.org/2000/svg"
						width="20"
						height="20"
						viewBox="0 0 24 24"
						fill="currentColor"
					>
						<path
							d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"
						/>
					</svg>
				</a>
			</div>
		</div>

		<!-- Section 2: Quick Links -->
		<div class="footer-section links">
			<h3>Quick Links</h3>
			<ul>
				<li><a href="/Dashboard">Dashboard</a></li>
				<li><a href="/faq">FAQ</a></li>
				<li><a href="/settings">Settings</a></li>
				<li><a href="/AboutUs">About Us</a></li>
			</ul>
		</div>

		<!-- Section 3: Legal -->
		<div class="footer-section links">
			<h3>Legal</h3>
			<ul>
				<li><a href="/Privacy">Privacy Policy</a></li>
				<li><a href="/Terms">Terms of Service</a></li>
				<li><a href="/Contact">Contact</a></li>
			</ul>
		</div>
	</div>

	<!-- Footer Bottom Bar -->
	<div class="footer-bottom">
		<p>&copy; {currentYear} Coldchain Monitor. All Rights Reserved.</p>
	</div>
</footer>

<style>
	.site-footer {
		background: linear-gradient(135deg, #1a2980, #26d0ce);
		color: #ffffff;
		font-family: 'Quicksand', 'Segoe UI', sans-serif;
		padding: 3rem 2rem 0;
		margin-top: 4rem; /* Add space above the footer */
		clip-path: polygon(0 5%, 100% 0, 100% 100%, 0% 100%);
	}

	.footer-content {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
		gap: 2rem;
		max-width: 1200px;
		margin: 0 auto;
		padding-bottom: 2rem;
	}

	.footer-section {
		padding: 1rem;
	}

	/* --- Brand Section --- */
	.logo-text {
		display: flex;
		align-items: center;
		gap: 0.75rem;
		margin-bottom: 1rem;
	}

	.logo-text .logo-icon {
		font-size: 1.8rem;
		display: inline-block;
		transform: translateY(-2px);
	}

	.logo-text h2 {
		margin: 0;
		font-size: 1.5rem;
		font-weight: 700;
	}

	.tagline {
		font-size: 0.95rem;
		line-height: 1.6;
		opacity: 0.8;
		margin-bottom: 1.5rem;
	}

	/* --- Social Links --- */
	.social-links {
		display: flex;
		gap: 1rem;
	}

	.social-links a {
		color: #ffffff;
		background-color: rgba(255, 255, 255, 0.15);
		width: 40px;
		height: 40px;
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;
		text-decoration: none;
		font-weight: 600;
		transition: background-color 0.3s ease, transform 0.3s ease;
	}

	.social-links a:hover {
		background-color: #00c6fb;
		transform: translateY(-3px) scale(1.05);
	}

	/* --- Links Sections --- */
	.links h3 {
		font-size: 1.2rem;
		margin-bottom: 1.25rem;
		position: relative;
		padding-bottom: 0.5rem;
	}

	.links h3::after {
		content: '';
		position: absolute;
		left: 0;
		bottom: 0;
		width: 40px;
		height: 3px;
		background-color: #26d0ce;
		border-radius: 3px;
	}

	.links ul {
		list-style: none;
		padding: 0;
		margin: 0;
	}

	.links ul li {
		margin-bottom: 0.75rem;
	}

	.links ul a {
		color: #ffffff;
		text-decoration: none;
		opacity: 0.8;
		transition: opacity 0.3s ease, padding-left 0.3s ease;
	}

	.links ul a:hover {
		opacity: 1;
		padding-left: 5px;
	}

	/* --- Footer Bottom --- */
	.footer-bottom {
		text-align: center;
		padding: 1.5rem 0;
		border-top: 1px solid rgba(255, 255, 255, 0.1);
		margin-top: 2rem;
	}

	.footer-bottom p {
		margin: 0;
		font-size: 0.9rem;
		opacity: 0.7;
	}

	/* --- Responsive Design --- */
	@media (max-width: 768px) {
		.site-footer {
			clip-path: polygon(0 2%, 100% 0, 100% 100%, 0% 100%);
			padding-top: 4rem;
		}
		.footer-content {
			grid-template-columns: 1fr;
			text-align: center;
		}
		.logo-text,
		.social-links {
			justify-content: center;
		}
		.links h3::after {
			left: 50%;
			transform: translateX(-50%);
		}
	}
</style>
