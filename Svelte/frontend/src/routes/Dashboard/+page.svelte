<!--
  Component: src/routes/dashboard/+page.svelte
  Description: A dynamic dashboard that fetches and visualizes data from the
               /prc/dashboard/aggregation API based on a user-selected date range.
-->
<script lang="ts">
	import { onMount } from "svelte";
	import { fly, fade } from "svelte/transition";
	import Chart from "chart.js/auto";
	import Navbar2 from "../../components/Navbar/Navbar2.svelte";

	// --- TYPE DEFINITIONS for the API response ---
	type ViolatedTemp = { date: string; count: number };
	type AverageTemp = { shipment_id: number; avg_temp: number };
	type DashboardData = {
		violatedTemp: ViolatedTemp[];
		averageTemp: AverageTemp[];
		totalViolations: number;
		activeShipment: number;
		activeAlerts: number;
	};

	// --- STATE VARIABLES ---
	let isLoading = true;
	let error: string | null = null;
	let dashboardData: DashboardData | null = null;

	// State for date range filters. Default to the last 30 days.
	const DaysAgo = new Date();
	DaysAgo.setDate(DaysAgo.getDate() - 300);
	let startTime = DaysAgo.toISOString().slice(0, 16); // Format for datetime-local
	let endTime = new Date().toISOString().slice(0, 16);

	// Chart instances
	let violationsChart: Chart;
	let avgTempChart: Chart;

	// --- API & DATA HANDLING ---
	/**
	 * Fetches dashboard data from the API for the selected time range.
	 */
	async function fetchDashboardData() {
		isLoading = true;
		error = null;
		dashboardData = null; // Clear previous data

		try {
			const response = await fetch(
				"http://localhost:8084/prc/dashboard/aggregation",
				{
					method: "POST",
					headers: {
						"Content-Type": "application/json",
					},
					body: JSON.stringify({
						// Convert local datetime-local format to ISO 8601
						startTime: new Date(startTime),
						endTime: new Date(endTime)
					}),
				},
			);

			if (!response.ok) {
				throw new Error(
					`API Error: ${response.status} ${response.statusText}`,
				);
			}

			const data: DashboardData = await response.json();
			dashboardData = data;

			// Update charts after the DOM has been updated
			setTimeout(() => {
				if (dashboardData) {
					createViolationsChart(dashboardData.violatedTemp);
					createAverageTempChart(dashboardData.averageTemp);
				}
			}, 0);
		} catch (e: any) {
			console.error("Failed to fetch dashboard data:", e);
			error = e.message || "Could not connect to the API.";
		} finally {
			isLoading = false;
		}
	}

	// --- LIFECYCLE ---
	onMount(() => {
		fetchDashboardData(); // Fetch initial data on component mount

		// Cleanup charts on component destruction
		return () => {
			violationsChart?.destroy();
			avgTempChart?.destroy();
		};
	});

	// --- CHART CREATION FUNCTIONS ---
	function createViolationsChart(data: ViolatedTemp[]) {
		const ctx = document.getElementById(
			"violationsChart",
		) as HTMLCanvasElement;
		if (!ctx) return;
		if (violationsChart) violationsChart.destroy(); // Destroy old chart instance

		violationsChart = new Chart(ctx, {
			type: "bar",
			data: {
				labels: data.map((d) => d.date),
				datasets: [
					{
						label: "Violations per Day",
						data: data.map((d) => d.count),
						backgroundColor: "#ffcdd2",
						borderColor: "#c62828",
						borderWidth: 1,
					},
				],
			},
			options: {
				responsive: true,
				maintainAspectRatio: false,
				plugins: { legend: { display: false } },
				scales: {
					y: {
						beginAtZero: true,
						title: { display: true, text: "Number of Violations" },
					},
				},
			},
		});
	}

	function createAverageTempChart(data: AverageTemp[]) {
		const ctx = document.getElementById(
			"avgTempChart",
		) as HTMLCanvasElement;
		if (!ctx) return;
		if (avgTempChart) avgTempChart.destroy(); // Destroy old chart instance

		avgTempChart = new Chart(ctx, {
			type: "bar",
			data: {
				labels: data.map((d) => `Shipment ${d.shipment_id}`),
				datasets: [
					{
						label: "Average Temperature (°C)",
						data: data.map((d) => d.avg_temp),
						backgroundColor: "#e3f2fd",
						borderColor: "#005bea",
						borderWidth: 1,
					},
				],
			},
			options: {
				responsive: true,
				maintainAspectRatio: false,
				indexAxis: "y", // Horizontal bar chart
				plugins: { legend: { display: false } },
				scales: {
					x: {
						beginAtZero: true,
						title: { display: true, text: "Average Temp (°C)" },
					},
				},
			},
		});
	}
</script>

<Navbar2 />

<!-- Add Chart.js from CDN -->
<svelte:head>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</svelte:head>

<div class="dashboard-container">
	<!-- Page Header -->
	<header class="dashboard-header" in:fly={{ y: -30, duration: 500 }}>
		<h1>Dashboard Overview</h1>
		<p>Real-time insights into your cold chain logistics.</p>
	</header>

	<!-- Date Filter Bar -->
	<div class="filters-bar" in:fade={{ duration: 400, delay: 100 }}>
		<div class="filter-group">
			<label for="start-time">Start Time:</label>
			<input
				type="datetime-local"
				id="start-time"
				bind:value={startTime}
			/>
		</div>
		<div class="filter-group">
			<label for="end-time">End Time:</label>
			<input type="datetime-local" id="end-time" bind:value={endTime} />
		</div>
		<button
			class="fetch-btn"
			on:click={fetchDashboardData}
			disabled={isLoading}
		>
			{isLoading ? "Loading..." : "Apply Filter"}
		</button>
	</div>

	<!-- Main Grid Layout -->
	<div class="dashboard-grid">
		{#if isLoading}
			<div class="state-message loading">Loading Dashboard Data...</div>
		{:else if error}
			<div class="state-message error">
				<strong>Error:</strong>
				{error}
			</div>
		{:else if dashboardData}
			<!-- Stat Cards -->
			<div
				class="widget stat-card"
				in:fly={{ y: 20, duration: 400, delay: 100 }}
			>
				<div class="icon">📦</div>
				<div class="value">{dashboardData.activeShipment}</div>
				<div class="label">Active Shipments</div>
			</div>
			<div
				class="widget stat-card"
				in:fly={{ y: 20, duration: 400, delay: 200 }}
			>
				<div class="icon">🔔</div>
				<div class="value">{dashboardData.activeAlerts}</div>
				<div class="label">Active Alerts</div>
			</div>
			<div
				class="widget stat-card"
				in:fly={{ y: 20, duration: 400, delay: 300 }}
			>
				<div class="icon">⚠️</div>
				<div class="value">{dashboardData.totalViolations}</div>
				<div class="label">Total Violations</div>
			</div>

			<!-- Violated Temperature Chart -->
			<div
				class="widget chart-widget large"
				in:fade={{ duration: 500, delay: 400 }}
			>
				<h3>Temperature Violations Over Time</h3>
				<div class="chart-container">
					<canvas id="violationsChart"></canvas>
				</div>
			</div>

			<!-- Average Temperature Chart -->
			<div
				class="widget chart-widget large"
				in:fade={{ duration: 500, delay: 500 }}
			>
				<h3>Average Temperature per Shipment</h3>
				<div class="chart-container">
					<canvas id="avgTempChart"></canvas>
				</div>
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

	.dashboard-container {
		padding: 2rem 3rem;
		max-width: 1400px;
		margin: 0 auto;
	}

	.dashboard-header {
		margin-bottom: 2rem;
		color: #005bea;
		padding-left: 30px;
	}
	.dashboard-header h1 {
		font-size: 2.5rem;
		margin: 0 0 0.5rem 0;
		font-weight: 800;
	}
	.dashboard-header p {
		font-size: 1.2rem;
		margin: 0;
		color: #333;
	}

	/* --- Filters Bar --- */
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
	.filter-group label {
		font-weight: 600;
		color: #005bea;
	}
	.filter-group input {
		padding: 0.75rem 1rem;
		border: 1px solid #ccc;
		border-radius: 0.5rem;
		font-size: 1rem;
		font-family: "Quicksand", sans-serif;
		background-color: #fff;
	}
	.fetch-btn {
		background: linear-gradient(90deg, #00c6fb 0%, #005bea 100%);
		color: #fff;
		border: none;
		border-radius: 2rem;
		padding: 0.75rem 1.5rem;
		font-size: 1rem;
		font-weight: 700;
		cursor: pointer;
		transition:
			transform 0.18s,
			box-shadow 0.18s;
		margin-left: auto;
	}
	.fetch-btn:hover {
		transform: scale(1.05);
	}
	.fetch-btn:disabled {
		background: #ccc;
		cursor: not-allowed;
	}

	/* --- Grid & Widgets --- */
	.dashboard-grid {
		display: grid;
		grid-template-columns: repeat(3, 1fr);
		gap: 1.5rem;
	}
	.widget {
		background: rgba(255, 255, 255, 0.9);
		border-radius: 1rem;
		box-shadow: 0 4px 24px rgba(0, 0, 0, 0.08);
		padding: 1.5rem;
	}
	.state-message {
		grid-column: 1 / -1;
		text-align: center;
		padding: 4rem 2rem;
		font-size: 1.2rem;
		font-weight: 600;
		border-radius: 1rem;
	}
	.loading {
		background: #e3f2fd;
		color: #005bea;
	}
	.error {
		background: #ffcdd2;
		color: #c62828;
	}

	/* --- Stat Cards --- */
	.stat-card {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	.stat-card .icon {
		font-size: 2.5rem;
		margin-bottom: 0.5rem;
	}
	.stat-card .value {
		font-size: 2.2rem;
		font-weight: 700;
		color: #005bea;
	}
	.stat-card .label {
		font-size: 1rem;
		color: #333;
		font-weight: 600;
	}

	/* --- Chart Widgets --- */
	.chart-widget {
		display: flex;
		flex-direction: column;
	}
	.chart-widget h3 {
		margin: 0 0 1rem 0;
		color: #005bea;
		font-size: 1.2rem;
	}
	.chart-container {
		flex-grow: 1;
		position: relative;
		min-height: 350px;
	}
	.large {
		grid-column: span 3;
	}

	/* --- Responsive Design --- */
	@media (max-width: 1200px) {
		.dashboard-grid {
			grid-template-columns: 1fr;
		}
	}
	@media (max-width: 768px) {
		.dashboard-container {
			padding: 1.5rem;
		}
		.filters-bar {
			flex-direction: column;
			align-items: stretch;
		}
		.fetch-btn {
			margin-left: 0;
			width: 100%;
		}
	}
</style>
