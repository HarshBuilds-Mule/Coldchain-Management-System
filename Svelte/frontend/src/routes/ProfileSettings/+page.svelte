<!--
  Component: src/routes/profile/+page.svelte
  Description: A user profile page where users can view and edit their information.
  The styling is consistent with the Coldchain Monitoring project theme.
-->
<script lang="ts">
	import { fly, fade } from 'svelte/transition';

	// --- Component State ---

	// Toggle between viewing and editing mode
	let isEditing = false;

	// Mock user data. In a real app, this would come from an API or a store.
	let userData = {
		firstName: 'Alex',
		lastName: 'Frost',
		email: 'alex.frost@coldchain.io',
		profilePictureUrl: 'https://placehold.co/200x200/00c6fb/FFFFFF?text=AF' // Placeholder image
	};

	// Store a copy of the original data to revert changes if the user cancels
	let originalUserData = { ...userData };

	// --- Event Handlers ---

	/**
	 * Toggles the editing state and saves the current data for cancellation.
	 */
	function handleEdit() {
		originalUserData = { ...userData };
		isEditing = true;
	}

	/**
	 * Simulates saving the user data and switches back to view mode.
	 */
	function handleSave() {
		console.log('Saving data:', userData);
		// In a real app, you would make an API call here.
		isEditing = false;
	}

	/**
	 * Cancels the edit and reverts the user data to its original state.
	 */
	function handleCancel() {
		userData = { ...originalUserData };
		isEditing = false;
	}

	/**
	 * Handles the file input change to show a preview of the new profile picture.
	 * @param {Event} e - The file input change event.
	 */
	function handleFileChange(e: Event) {
		const target = e.target as HTMLInputElement;
		const file = target.files?.[0];
		if (file) {
			const reader = new FileReader();
			reader.onload = (event) => {
				if (event.target?.result) {
					userData.profilePictureUrl = event.target.result as string;
				}
			};
			reader.readAsDataURL(file);
		}
	}
</script>

<div class="profile-container">
	<div class="profile-card" in:fly={{ y: 50, duration: 600 }}>
		<!-- Profile Header -->
		<div class="profile-header">
			<div class="profile-picture-wrapper">
				<img src={userData.profilePictureUrl} alt="User Profile" class="profile-picture" />
				{#if isEditing}
					<label for="file-upload" class="picture-edit-overlay" in:fade>
						<span>✏️</span>
						<input id="file-upload" type="file" on:change={handleFileChange} accept="image/*" />
					</label>
				{/if}
			</div>
			{#if !isEditing}
				<div class="user-details" in:fly={{ x: -20, delay: 200 }}>
					<h2>{userData.firstName} {userData.lastName}</h2>
					<p>{userData.email}</p>
				</div>
			{/if}
		</div>

		<!-- Form Section: Toggles between view and edit -->
		<div class="profile-body">
			{#if isEditing}
				<!-- Edit Mode -->
				<div class="form-grid" in:fade>
					<div class="form-group">
						<label for="firstName">First Name</label>
						<input id="firstName" type="text" bind:value={userData.firstName} />
					</div>
					<div class="form-group">
						<label for="lastName">Last Name</label>
						<input id="lastName" type="text" bind:value={userData.lastName} />
					</div>
					<div class="form-group full-width">
						<label for="email">Email Address</label>
						<input id="email" type="email" bind:value={userData.email} />
					</div>
				</div>
			{:else}
				<!-- View Mode -->
				<div class="info-section">
					<h3 class="section-title">Account Settings</h3>
					<button class="setting-btn">Change Password</button>
					<button class="setting-btn">Two-Factor Authentication</button>

					<h3 class="section-title">Notification Preferences</h3>
					<div class="notification-toggle">
						<span>Email Alerts for Temperature Spikes</span>
						<label class="switch">
							<input type="checkbox" checked />
							<span class="slider" ></span>
						</label>
					</div>
					<div class="notification-toggle">
						<span>SMS Alerts for Shipment Delays</span>
						<label class="switch">
							<input type="checkbox" />
							<span class="slider" ></span>
						</label>
					</div>
				</div>
			{/if}
		</div>

		<!-- Action Buttons -->
		<div class="profile-footer">
			{#if isEditing}
				<button class="btn cancel-btn" on:click={handleCancel}>Cancel</button>
				<button class="btn save-btn" on:click={handleSave}>Save Changes</button>
			{:else}
				<button class="btn edit-btn" on:click={handleEdit}>Edit Profile</button>
			{/if}
		</div>
	</div>
</div>

<style>
	/* --- Main Container & Theme --- */
	:global(body) {
		margin: 0;
		font-family: 'Quicksand', 'Segoe UI', sans-serif;
		background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
		min-height: 100vh;
	}

	.profile-container {
		display: flex;
		align-items: center;
		justify-content: center;
		min-height: 100vh;
		padding: 2rem;
		box-sizing: border-box;
	}

	/* --- Profile Card --- */
	.profile-card {
		width: 100%;
		max-width: 600px;
		background: rgba(255, 255, 255, 0.9);
		border-radius: 1.5rem;
		box-shadow: 0 8px 40px rgba(0, 0, 0, 0.12);
		overflow: hidden;
		display: flex;
		flex-direction: column;
	}

	/* --- Profile Header --- */
	.profile-header {
		background: linear-gradient(135deg, #00c6fb 0%, #005bea 100%);
		padding: 2rem;
		display: flex;
		align-items: center;
		gap: 1.5rem;
		color: white;
	}

	.profile-picture-wrapper {
		position: relative;
		flex-shrink: 0;
	}

	.profile-picture {
		width: 100px;
		height: 100px;
		border-radius: 50%;
		border: 4px solid white;
		object-fit: cover;
		box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
	}

	.picture-edit-overlay {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		border-radius: 50%;
		background: rgba(0, 0, 0, 0.5);
		color: white;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 2rem;
		cursor: pointer;
		opacity: 0;
		transition: opacity 0.3s ease;
	}

	.profile-picture-wrapper:hover .picture-edit-overlay {
		opacity: 1;
	}

	#file-upload {
		display: none;
	}

	.user-details h2 {
		margin: 0 0 0.25rem 0;
		font-weight: 700;
	}

	.user-details p {
		margin: 0;
		opacity: 0.9;
	}

	/* --- Profile Body & Form --- */
	.profile-body {
		padding: 2rem;
	}

	.form-grid {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 1.5rem;
	}

	.form-group {
		display: flex;
		flex-direction: column;
	}

	.form-group.full-width {
		grid-column: 1 / -1;
	}

	.form-group label {
		margin-bottom: 0.5rem;
		font-weight: 600;
		color: #005bea;
	}

	.form-group input {
		padding: 0.75rem 1rem;
		border: 1px solid #ccc;
		border-radius: 0.5rem;
		font-size: 1rem;
		font-family: 'Quicksand', sans-serif;
		transition: border-color 0.2s, box-shadow 0.2s;
	}

	.form-group input:focus {
		outline: none;
		border-color: #00c6fb;
		box-shadow: 0 0 0 3px rgba(0, 198, 251, 0.3);
	}

	/* --- View Mode Info Section --- */
	.info-section {
		color: #333;
	}

	.section-title {
		font-size: 1.2rem;
		color: #005bea;
		border-bottom: 2px solid #fed6e3;
		padding-bottom: 0.5rem;
		margin-top: 1.5rem;
		margin-bottom: 1rem;
	}
	.section-title:first-child {
		margin-top: 0;
	}

	.setting-btn {
		display: block;
		width: 100%;
		text-align: left;
		padding: 0.75rem 1rem;
		margin-bottom: 0.5rem;
		background-color: #f0f8ff;
		border: 1px solid #e0e0e0;
		border-radius: 0.5rem;
		cursor: pointer;
		font-size: 1rem;
		font-weight: 600;
		color: #333;
		transition: background-color 0.2s, color 0.2s;
	}
	.setting-btn:hover {
		background-color: #e3f2fd;
		color: #005bea;
	}

	.notification-toggle {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 0.75rem 0;
	}

	/* --- Toggle Switch --- */
	.switch {
		position: relative;
		display: inline-block;
		width: 50px;
		height: 28px;
	}
	.switch input {
		opacity: 0;
		width: 0;
		height: 0;
	}
	.slider {
		position: absolute;
		cursor: pointer;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: #ccc;
		transition: 0.4s;
		border-radius: 28px;
	}
	.slider:before {
		position: absolute;
		content: '';
		height: 20px;
		width: 20px;
		left: 4px;
		bottom: 4px;
		background-color: white;
		transition: 0.4s;
		border-radius: 50%;
	}
	input:checked + .slider {
		background-color: #00c6fb;
	}
	input:checked + .slider:before {
		transform: translateX(22px);
	}

	/* --- Footer & Buttons --- */
	.profile-footer {
		padding: 1.5rem 2rem;
		background-color: #f8f9fa;
		border-top: 1px solid #e0e0e0;
		display: flex;
		justify-content: flex-end;
		gap: 1rem;
	}

	.btn {
		border: none;
		border-radius: 2rem;
		padding: 0.7rem 1.7rem;
		font-size: 1rem;
		font-weight: 600;
		cursor: pointer;
		transition: transform 0.18s, box-shadow 0.18s;
	}
	.btn:hover {
		transform: scale(1.05);
		box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
	}

	.edit-btn {
		background: linear-gradient(90deg, #f7971e 0%, #ffd200 100%);
		color: white;
	}

	.save-btn {
		background: linear-gradient(90deg, #00c6fb 0%, #005bea 100%);
		color: white;
	}

	.cancel-btn {
		background: #e0e0e0;
		color: #333;
	}
</style>
