<!--
  Component: src/routes/admin/+page.svelte
  Description: A read-only admin page for viewing users with color-coded roles.
-->
<script lang="ts">
	import { fly, fade } from "svelte/transition";
	import { onMount } from "svelte";
	import Navbar2 from "../../components/Navbar/Navbar2.svelte";

	// --- TYPE DEFINITIONS (Matches API structure) ---
	type UserRole = "admin" | "viewer" | "user";
	type User = {
		id: number;
		fullname: string;
		email: string;
		role: UserRole;
		created_at: string;
	};

	// --- COMPONENT STATE ---
	let users: User[] = [];
	let isLoading = true;
	let fetchError: string | null = null;

	// --- DATA FETCHING ---
	async function fetchUsers() {
		isLoading = true;
		fetchError = null;
		try {
			// Updated API endpoint as requested
			const response = await fetch("http://localhost:8085/exp/admin");
			if (!response.ok) {
				throw new Error(
					`API call failed with status: ${response.status}`,
				);
			}
			const data = await response.json();
			users = Array.isArray(data) ? data : [];
		} catch (error) {
			console.error("Failed to fetch users:", error);
			fetchError =
				"Could not load user data. Please check the API connection.";
			// For demonstration, falling back to mock data on error.
			users = [
				{
					id: 1,
					fullname: "Adam Marakov (Demo)",
					email: "admin@coldchain.com",
					role: "admin",
					created_at: "2025-07-23T21:55:58",
				},
				{
					id: 2,
					fullname: "Venus Trap (Demo)",
					email: "viewer@coldchain.com",
					role: "viewer",
					created_at: "2025-07-23T21:55:58",
				},
			];
		} finally {
			isLoading = false;
		}
	}

	onMount(fetchUsers);

	// --- HELPER FUNCTION ---
	/**
	 * Generates initials from a full name for the avatar.
	 */
	function getInitials(fullname: string): string {
		if (!fullname) return "?";
		const names = fullname.split(" ");
		const initials = names.map((n) => n[0]).join("");
		return initials.length > 2 ? initials.substring(0, 2) : initials;
	}
</script>

<Navbar2 />

<div class="page-container">
	<header class="page-header" in:fly={{ y: -30, duration: 500 }}>
		<h1>User Directory</h1>
		<p>A read-only list of all users and their assigned roles.</p>
	</header>

	<div class="table-container" in:fade={{ duration: 500, delay: 100 }}>
		{#if isLoading}
			<div class="state-message">Loading user data...</div>
		{:else if fetchError}
			<div class="state-message error">{fetchError}</div>
		{:else if users.length > 0}
			<table>
				<thead>
					<tr>
						<th>User</th>
						<th>Email</th>
						<th>Role</th>
					</tr>
				</thead>
				<tbody>
					{#each users as user (user.id)}
						<tr transition:fly={{ y: 20, duration: 300 }}>
							<td data-label="User">
								<div class="user-info">
									<div class="avatar">
										{getInitials(user.fullname)}
									</div>
									<span>{user.fullname}</span>
								</div>
							</td>
							<td data-label="Email">{user.email}</td>
							<td data-label="Role">
								<span class="role-badge {user.role}">
									{user.role}
								</span>
							</td>
						</tr>
					{/each}
				</tbody>
			</table>
		{:else}
			<div class="state-message">No users found.</div>
		{/if}
	</div>
</div>

<style>
	:global(body) {
		margin: 0;
		font-family: "Quicksand", "Segoe UI", sans-serif;
		background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
		min-height: 100vh;
	}

	.page-container {
		padding: 2rem 3rem;
		max-width: 1400px;
		margin: 0 auto;
	}

	.page-header {
		margin-bottom: 2rem;
		color: #005bea;
		padding-left: 30px;
	}

	.page-header h1 {
		font-size: 2.5rem;
		margin: 0 0 0.5rem 0;
		font-weight: 800;
	}

	.page-header p {
		font-size: 1.2rem;
		margin: 0;
		color: #333;
	}

	.table-container {
		background: #ffffff;
		border-radius: 1rem;
		box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
		overflow-x: auto;
	}

	table {
		width: 100%;
		border-collapse: collapse;
		text-align: left;
	}

	th,
	td {
		padding: 1rem 1.5rem;
		border-bottom: 1px solid #f0f0f0;
		vertical-align: middle;
	}

	th {
		font-weight: 700;
		color: #005bea;
		background-color: #f8f9fa;
	}

	.user-info {
		display: flex;
		align-items: center;
		gap: 1rem;
		font-weight: 600;
	}

	.avatar {
		width: 40px;
		height: 40px;
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;
		background-color: #005bea;
		color: white;
		font-weight: 700;
		text-transform: uppercase;
	}

	.role-badge {
		padding: 0.3rem 0.8rem;
		border-radius: 1rem;
		font-weight: 700;
		font-size: 0.9rem;
		text-transform: capitalize;
	}

	.role-badge.admin {
		background-color: #e3f2fd;
		color: #0d47a1;
	}

	.role-badge.viewer {
		background-color: #fff9c4;
		color: #f57f17;
	}

	.role-badge.user {
		background-color: #e8f5e9;
		color: #1b5e20;
	}

	.state-message {
		text-align: center;
		padding: 4rem 2rem;
		color: #555;
		font-size: 1.2rem;
	}
	.state-message.error {
		color: #c62828;
		background-color: #ffcdd2;
		border-radius: 1rem;
	}

	/* --- Responsive Design --- */
	@media (max-width: 768px) {
		.page-container {
			padding: 1.5rem;
		}
		table {
			border: 0;
		}
		thead {
			display: none;
		}
		tr {
			display: block;
			margin-bottom: 1rem;
			border-bottom: 3px solid #005bea;
		}
		td {
			display: block;
			text-align: right;
			border-bottom: 1px dotted #ccc;
			padding: 0.75rem 1rem;
		}
		td:last-child {
			border-bottom: 0;
		}
		td::before {
			content: attr(data-label);
			float: left;
			font-weight: bold;
			color: #333;
			padding-top: 0.1rem;
		}
		.user-info {
			justify-content: flex-end;
		}
		.user-info span {
			display: none;
		}
	}
</style>
