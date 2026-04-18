<!--
  Component: src/routes/alerts/+page.svelte
  Description: Final corrected version. Sends a bodiless PUT request using the correct shipment_id in the URL.
-->
<script lang="ts">
	import { fly, fade } from "svelte/transition";
	import { onMount } from "svelte";
	import Navbar2 from "../../components/Navbar/Navbar2.svelte";

	// --- TYPE DEFINITION (Matches the API payload) ---
	type ApiAlert = {
		id: number;
		shipment_id: number;
		status: "temp_low" | "temp_high" | "delay";
		message: string;
		alerted_at: string;
		resolved: boolean;
	};

	// --- TYPE FOR DISPLAY (Includes derived UI data) ---
	type DisplayAlert = ApiAlert & {
		typeMeta: {
			icon: string;
			name: string;
			colorClass: string;
		};
	};

	// --- COMPONENT STATE ---
	let allAlerts: DisplayAlert[] = [];
	let isLoading = true;
	let fetchError: string | null = null;
	let updateError: string | null = null;

	// --- DATA FETCHING AND PROCESSING ---
	async function fetchAlerts() {
		isLoading = true;
		fetchError = null;
		try {
			const res = await fetch("http://localhost:8085/exp/alert");
			if (!res.ok)
				throw new Error(`Server responded with status: ${res.status}`);
			const data: ApiAlert[] = await res.json();
			const processedData = Array.isArray(data) ? data : [];

			// Process the raw data: add typeMeta and then sort
			allAlerts = processedData
				.map((alert) => ({
					...alert,
					typeMeta: formatAlertType(alert.status), // Add derived data here
				}))
				.sort(
					(a, b) =>
						(a.resolved ? 1 : -1) - (b.resolved ? 1 : -1) ||
						new Date(b.alerted_at).getTime() -
							new Date(a.alerted_at).getTime(),
				);
		} catch (error) {
			fetchError =
				"Could not fetch alerts. Please check the API connection and browser console for CORS issues.";
			console.error("Fetch error:", error);
		} finally {
			isLoading = false;
		}
	}

	onMount(fetchAlerts);

	/**
	 * Resolves an alert by sending a bodiless PUT request with the correct ID.
	 */
	async function resolveAlert(alertIdToResolve: number) {
		updateError = null;
		const alertIndex = allAlerts.findIndex(
			(a) => a.id === alertIdToResolve,
		);
		if (alertIndex === -1) return;

		const alertToUpdate = allAlerts[alertIndex];
		const originalStatus = alertToUpdate.resolved;

		// 1. Optimistically update the UI to mark as resolved.
		alertToUpdate.resolved = true;
		allAlerts = [...allAlerts];

		try {
			// Use the shipment_id for the URL as requested
			const response = await fetch(
				`http://localhost:8085/exp/alert/${alertToUpdate.shipment_id}`,
				{
					method: "PUT",
				},
			);

			if (!response.ok) {
				const errorBody = await response.text();
				throw new Error(
					`API update failed with status ${response.status}. Body: ${errorBody}`,
				);
			}
		} catch (error) {
			console.error(
				"Failed to resolve alert. This could be a CORS or network issue. Full error:",
				error,
			);
			updateError = `Failed to update alert SHIP${alertToUpdate.shipment_id}.`;

			// 3. If the fetch fails, revert the UI change.
			alertToUpdate.resolved = originalStatus;
			allAlerts = [...allAlerts];
		}
	}

	// --- HELPER FUNCTIONS ---
	function formatAlertType(status: ApiAlert["status"]) {
		if (status === "temp_high")
			return {
				icon: "🌡️",
				name: "Temp High",
				colorClass: "type-temperature-high",
			};
		if (status === "temp_low")
			return {
				icon: "🌡️",
				name: "Temp Low",
				colorClass: "type-temperature-low",
			};
		if (status === "delay")
			return { icon: "⏱️", name: "Delay", colorClass: "type-delay" };
		return { icon: "🔔", name: "General", colorClass: "type-general" };
	}

	function formatTimestamp(isoString: string): string {
		const date = new Date(isoString);
		return date.toLocaleString("en-US", {
			month: "short",
			day: "numeric",
			hour: "2-digit",
			minute: "2-digit",
			hour12: true,
		});
	}
</script>
<Navbar2 />

<div class="page-container">
	<header class="page-header" in:fly={{ y: -30, duration: 500 }}>
		<h1>Alert Management</h1>
		<p>Review and manage all critical events in your supply chain.</p>
	</header>

	{#if updateError}
		<div class="error-banner" transition:fade>
			{updateError} Check console for details.
		</div>
	{/if}

	<div class="table-container" in:fade={{ duration: 500, delay: 100 }}>
		{#if isLoading}
			<div class="state-message">Loading alerts...</div>
		{:else if fetchError}
			<div class="state-message error-state">{fetchError}</div>
		{:else if allAlerts.length > 0}
			<table>
				<thead>
					<tr>
						<th>Alert Type</th>
						<th>Shipment ID</th>
						<th>Details</th>
						<th>Timestamp</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					{#each allAlerts as alert (alert.id)}
						<tr
							class:is-resolved={alert.resolved}
							transition:fly={{ y: 20, duration: 300 }}
						>
							<td data-label="Type">
								<!-- Use the pre-processed typeMeta object from the alert -->
								<span
									class="alert-type-badge {alert.typeMeta
										.colorClass}"
								>
									{alert.typeMeta.icon}
									{alert.typeMeta.name}
								</span>
							</td>
							<td data-label="Shipment ID">
								<a
									href="/shipments?search={alert.shipment_id}"
									class="shipment-link"
								>
									SHIP{alert.shipment_id}
								</a>
							</td>
							<td data-label="Details">{alert.message}</td>
							<td data-label="Timestamp"
								>{formatTimestamp(alert.alerted_at)}</td
							>
							<td data-label="Action">
								{#if !alert.resolved}
									<button
										class="resolve-btn"
										on:click={() => resolveAlert(alert.id)}
									>
										Resolve
									</button>
								{:else}
									<span class="resolved-text"
										>Resolved ✅</span
									>
								{/if}
							</td>
						</tr>
					{/each}
				</tbody>
			</table>
		{:else}
			<div class="state-message all-clear">
				<span class="icon">✅</span>
				<h3>No Alerts Found</h3>
				<p>There are no alerts recorded at this time.</p>
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
	tbody tr.is-resolved {
		background-color: #f8f9fa;
		color: #aaa;
	}
	tbody tr.is-resolved .shipment-link {
		color: #8ab4f8;
	}
	.alert-type-badge {
		display: inline-flex;
		align-items: center;
		gap: 0.5rem;
		padding: 0.4rem 0.8rem;
		border-radius: 1rem;
		font-weight: 600;
		font-size: 0.9rem;
	}
	.type-temperature-high {
		background-color: #ffcdd2;
		color: #c62828;
	}
	.type-temperature-low {
		background-color: #e3f2fd;
		color: #0d47a1;
	}
	.type-delay {
		background-color: #fff9c4;
		color: #f57f17;
	}
	.type-general {
		background-color: #e0e0e0;
		color: #424242;
	}
	.shipment-link {
		color: #005bea;
		font-weight: 600;
		text-decoration: none;
	}
	.shipment-link:hover {
		text-decoration: underline;
	}
	.resolve-btn {
		background: linear-gradient(90deg, #00c6fb 0%, #005bea 100%);
		color: #fff;
		border: none;
		border-radius: 2rem;
		padding: 0.6rem 1.2rem;
		font-size: 0.9rem;
		font-weight: 700;
		cursor: pointer;
		transition:
			transform 0.18s,
			box-shadow 0.18s;
	}
	.resolve-btn:hover {
		transform: scale(1.05);
		box-shadow: 0 4px 15px rgba(0, 91, 234, 0.25);
	}
	.resolved-text {
		font-weight: 700;
		color: #1b5e20;
	}
	.state-message {
		text-align: center;
		padding: 4rem 2rem;
		color: #555;
	}
	.error-state {
		background-color: #ffcdd2;
		color: #c62828;
		border-radius: 1rem;
	}
	.error-banner {
		padding: 1rem;
		background-color: #c62828;
		color: white;
		text-align: center;
		border-radius: 0.5rem;
		margin-bottom: 1.5rem;
		font-weight: 600;
	}
	.all-clear .icon {
		font-size: 3rem;
	}
	.all-clear h3 {
		font-size: 1.8rem;
		color: #1b5e20;
		margin: 1rem 0 0.5rem;
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
		.resolve-btn {
			width: 100%;
		}
	}
</style>
