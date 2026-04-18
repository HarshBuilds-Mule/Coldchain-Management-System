<!--
  Component: src/routes/shipments/+page.svelte
  Description: A page for viewing, searching, and filtering all user shipments,
               adapted for the new API payload.
-->
<script lang="ts">
	import { fly, fade } from "svelte/transition";
	import { onMount } from "svelte";
    import Navbar2 from "../../components/Navbar/Navbar2.svelte";

	// --- TYPE DEFINITION (Updated to match the new API payload) ---
	type ApiShipment = {
		id: number;
		shipment_code: string;
		origin: string;
		destination: string;
		status: "in_transit" | "delivered" | "delayed" | "pending";
		start_time: string;
		end_time: string | null;
		created_at: string;
	};

	// --- COMPONENT STATE ---
	let allShipments: ApiShipment[] = [];
	let searchTerm = "";
	let statusFilter: ApiShipment["status"] | "All" = "All";
	let dateFilter = "";
	let isLoading = true;
	let fetchError: string | null = null;

	// --- DATA FETCHING (Now fetches from the live API) ---
	async function fetchShipments() {
		isLoading = true;
		fetchError = null;
		try {
			const res = await fetch("http://localhost:8085/exp/shipment");
			if (!res.ok) {
				throw new Error(
					`Failed to load data. Server responded with status: ${res.status}`,
				);
			}
			const data = await res.json();
			allShipments = Array.isArray(data) ? data : [];
		} catch (error: any) {
			fetchError =
				"A network error occurred. Please check your connection and ensure the API server is running.";
			console.error("Error fetching shipments:", error);
		} finally {
			isLoading = false;
		}
	}

	// --- LIFECYCLE HOOK ---
	onMount(fetchShipments);

	// --- REACTIVE FILTERING LOGIC ---
	$: filteredShipments = allShipments.filter((shipment) => {
		if (!shipment) return false;

		const matchesSearch =
			(shipment.shipment_code || "")
				.toLowerCase()
				.includes(searchTerm.toLowerCase()) ||
			(shipment.origin || "")
				.toLowerCase()
				.includes(searchTerm.toLowerCase()) ||
			(shipment.destination || "")
				.toLowerCase()
				.includes(searchTerm.toLowerCase());

		const matchesStatus =
			statusFilter === "All" || shipment.status === statusFilter;

		const matchesDate =
			!dateFilter || (shipment.created_at || "").startsWith(dateFilter);

		return matchesSearch && matchesStatus && matchesDate;
	});

	// --- UTILITY FUNCTIONS ---
	function formatTimestamp(isoString: string): string {
		if (!isoString) return "N/A";
		const date = new Date(isoString);
		return date.toLocaleString("en-US", {
			month: "short",
			day: "numeric",
			year: "numeric",
			hour: "2-digit",
			minute: "2-digit",
			hour12: true,
		});
	}

	function formatStatus(status: ApiShipment["status"]): string {
		if (!status) return "Unknown";
		return status
			.replace("_", " ")
			.replace(/\b\w/g, (char) => char.toUpperCase());
	}
</script>

<Navbar2 />

<div class="page-container">
	<header class="page-header" in:fly={{ y: -30, duration: 500 }}>
		<h1>Shipment Tracking</h1>
		<p>Search, filter, and monitor all your active and past shipments.</p>
	</header>

	<div class="filters-bar" in:fly={{ y: -20, duration: 500, delay: 100 }}>
		<div class="filter-group search-group">
			<span class="icon">🔍</span>
			<input
				type="text"
				placeholder="Search by Code, Origin, Destination..."
				bind:value={searchTerm}
			/>
		</div>
		<div class="filter-group">
			<label for="status-filter">Status:</label>
			<select id="status-filter" bind:value={statusFilter}>
				<option value="All">All</option>
				<option value="in_transit">In Transit</option>
				<option value="delivered">Delivered</option>
				<option value="delayed">Delayed</option>
				<option value="pending">Pending</option>
			</select>
		</div>
		<div class="filter-group">
			<label for="date-filter">Creation Date:</label>
			<input type="date" id="date-filter" bind:value={dateFilter} />
		</div>
	</div>

	<div class="content-container" in:fade={{ duration: 500, delay: 200 }}>
		{#if isLoading}
			<div class="message-state">Loading shipments...</div>
		{:else if fetchError}
			<div class="message-state error-state">
				<h3>Oops! Something went wrong.</h3>
				<p>{fetchError}</p>
			</div>
		{:else if filteredShipments.length > 0}
			<div class="table-container">
				<table>
					<thead>
						<tr>
							<th>Shipment Code</th>
							<th>Status</th>
							<th>Origin</th>
							<th>Destination</th>
							<th>Start Time</th>
							<th>Created At</th>
						</tr>
					</thead>
					<tbody>
						{#each filteredShipments as shipment (shipment.id)}
							<tr in:fade={{ duration: 300 }}>
								<td data-label="Code"
									>{shipment.shipment_code}</td
								>
								<td data-label="Status">
									<span
										class="status-badge {shipment.status}"
									>
										{formatStatus(shipment.status)}
									</span>
								</td>
								<td data-label="Origin">{shipment.origin}</td>
								<td data-label="Destination"
									>{shipment.destination}</td
								>
								<td data-label="Start Time"
									>{formatTimestamp(shipment.start_time)}</td
								>
								<td data-label="Created At"
									>{formatTimestamp(shipment.created_at)}</td
								>
							</tr>
						{/each}
					</tbody>
				</table>
			</div>
		{:else}
			<div class="message-state">
				<h3>No Shipments Found</h3>
				<p>Try adjusting your search or filter criteria.</p>
			</div>
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
	.filters-bar {
		display: flex;
		flex-wrap: wrap;
		gap: 1.5rem;
		align-items: center;
		padding: 1.5rem;
		background: rgba(255, 255, 255, 0.9);
		border-radius: 1rem;
		box-shadow: 0 4px 24px rgba(0, 0, 0, 0.08);
		margin-bottom: 2rem;
	}
	.filter-group {
		display: flex;
		align-items: center;
		gap: 0.75rem;
	}
	.filter-group.search-group {
		flex-grow: 1;
	}
	.filter-group label {
		font-weight: 600;
		color: #005bea;
	}
	.filter-group input,
	.filter-group select {
		padding: 0.75rem 1rem;
		border: 1px solid #ccc;
		border-radius: 0.5rem;
		font-size: 1rem;
		font-family: "Quicksand", sans-serif;
		background-color: #fff;
		min-width: 150px;
	}
	.search-group {
		position: relative;
	}
	.search-group input {
		width: 100%;
		padding-left: 2.5rem;
	}
	.search-group .icon {
		position: absolute;
		left: 0.75rem;
		top: 50%;
		transform: translateY(-50%);
		color: #aaa;
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
	}
	th {
		font-weight: 700;
		color: #005bea;
		background-color: #f8f9fa;
	}
	tbody tr:hover {
		background-color: #f0f8ff;
	}
	.status-badge {
		padding: 0.3rem 0.75rem;
		border-radius: 1rem;
		font-weight: 600;
		font-size: 0.9rem;
		color: #333;
	}
	.status-badge.in_transit {
		background-color: #e3f2fd;
		color: #0d47a1;
	}
	.status-badge.delivered {
		background-color: #e8f5e9;
		color: #1b5e20;
	}
	.status-badge.delayed {
		background-color: #fff9c4;
		color: #f57f17;
	}
	.status-badge.pending {
		background-color: #fbe9e7;
		color: #d84315;
	}
	.message-state {
		text-align: center;
		padding: 4rem 2rem;
		color: #555;
	}
	.error-state {
		background-color: #ffcdd2;
		border-radius: 1rem;
	}
	.error-state h3 {
		color: #c62828;
	}
	.message-state h3 {
		font-size: 1.5rem;
		color: #005bea;
		margin-bottom: 0.5rem;
	}
	@media (max-width: 900px) {
		.filters-bar {
			flex-direction: column;
			align-items: stretch;
		}
	}
	@media (max-width: 768px) {
		.page-container {
			padding: 1.5rem;
		}
		table {
			border: 0;
		}
		table thead {
			display: none;
		}
		table tr {
			display: block;
			margin-bottom: 1rem;
			border-bottom: 3px solid #005bea;
		}
		table td {
			display: block;
			text-align: right;
			border-bottom: 1px dotted #ccc;
		}
		table td:last-child {
			border-bottom: 0;
		}
		table td::before {
			content: attr(data-label);
			float: left;
			font-weight: bold;
			color: #333;
		}
	}
</style>
