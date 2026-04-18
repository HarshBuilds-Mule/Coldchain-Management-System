<!--
  Component: src/routes/about/+page.svelte
  Description: An About Us page with details on the company's mission, story, and team.
-->
<script lang="ts">
    import { fly, fade } from "svelte/transition";
    import { onMount } from "svelte";
    import Navbar2 from "../../components/Navbar/Navbar2.svelte";
    import Footer from "../../components/Footer/Footer.svelte";
    

    // --- MOCK TEAM DATA ---
    type TeamMember = {
        id: number;
        name: string;
        role: string;
        bio: string;
    };

    const teamMembers: TeamMember[] = [
        {
            id: 1,
            name: "Alex Frost",
            role: "Founder & CEO",
            bio: "With a background in logistics and a passion for technology, Alex founded Coldchain Monitor to bring transparency and reliability to the industry.",
        },
        {
            id: 2,
            name: "Brenda Chill",
            role: "Lead Engineer",
            bio: "Brenda is the architect behind our robust monitoring platform, ensuring every data point is captured and analyzed with precision.",
        },
        {
            id: 3,
            name: "Charles Iceberg",
            role: "Head of Operations",
            bio: "Charles ensures our hardware and software solutions are seamlessly integrated for clients worldwide, guaranteeing smooth deployments.",
        },
    ];

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
        <h1>About Coldchain Monitor</h1>
        <p>
            Ensuring the integrity of every temperature-sensitive shipment, from
            origin to destination.
        </p>
    </header>

    <div class="content-wrapper">
        <!-- Our Mission Section -->
        <section class="info-section" in:fade={{ duration: 600, delay: 100 }}>
            <h2>Our Mission</h2>
            <p>
                Our mission is to eliminate uncertainty in cold chain logistics.
                We believe that by providing real-time, actionable data in a
                playful and intuitive interface, we can empower businesses to
                protect their valuable cargo, reduce waste, and ensure consumer
                safety. We're dedicated to making advanced monitoring simple,
                accessible, and reliable for companies of all sizes, from local
                producers to global distributors.
            </p>
        </section>

        <!-- Our Values Section -->
        <section class="info-section" in:fade={{ duration: 600, delay: 200 }}>
            <h2>Our Core Values</h2>
            <div class="values-grid">
                <div
                    class="value-card"
                    in:fly={{ y: 20, duration: 400, delay: 300 }}
                >
                    <div class="value-icon">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="48"
                            height="48"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            ><path
                                d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"
                            ></path></svg
                        >
                    </div>
                    <h3>Reliability</h3>
                    <p>
                        We build systems that are dependable and trustworthy,
                        because we know millions in critical assets are on the
                        line.
                    </p>
                </div>
                <div
                    class="value-card"
                    in:fly={{ y: 20, duration: 400, delay: 400 }}
                >
                    <div class="value-icon">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="48"
                            height="48"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            ><path
                                d="M17.5 12h-15m5.8-3.8l-3.3 3.3a1 1 0 000 1.4l3.3 3.3m12.4-5.8l-3.3 3.3a1 1 0 000 1.4l3.3 3.3"
                            ></path></svg
                        >
                    </div>
                    <h3>Innovation</h3>
                    <p>
                        We constantly push the boundaries of technology to
                        create simpler, smarter, and more effective monitoring
                        solutions.
                    </p>
                </div>
                <div
                    class="value-card"
                    in:fly={{ y: 20, duration: 400, delay: 500 }}
                >
                    <div class="value-icon">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="48"
                            height="48"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            ><path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"
                            ></path><circle cx="12" cy="7" r="4"></circle></svg
                        >
                    </div>
                    <h3>Customer-Centric</h3>
                    <p>
                        Our users are at the heart of everything we do. We
                        design intuitive interfaces and provide unparalleled
                        support.
                    </p>
                </div>
            </div>
        </section>

        <!-- Our Story Section -->
        <section class="info-section" in:fade={{ duration: 600, delay: 300 }}>
            <h2>Our Story: An Interactive Timeline</h2>
            <div class="timeline">
                <div
                    class="timeline-item"
                    in:fly={{ x: -20, duration: 500, delay: 400 }}
                >
                    <div class="timeline-dot"></div>
                    <div class="timeline-content">
                        <h3>2023 - The Spark</h3>
                        <p>
                            Founded in Jabalpur, Coldchain Monitor started as a
                            solution to a common problem: a lack of visibility
                            in temperature-controlled supply chains. After
                            seeing millions lost in spoiled goods due to
                            preventable temperature violations, our founders set
                            out to build a better way.
                        </p>
                    </div>
                </div>
                <div
                    class="timeline-item"
                    in:fly={{ x: 20, duration: 500, delay: 500 }}
                >
                    <div class="timeline-dot"></div>
                    <div class="timeline-content">
                        <h3>2024 - Building the Platform</h3>
                        <p>
                            Our core platform was developed, combining modern
                            IoT hardware with a user-centric software platform.
                            We launched our first successful pilot program with
                            local pharmaceutical distributors, proving the
                            system's reliability and value.
                        </p>
                    </div>
                </div>
                <div
                    class="timeline-item"
                    in:fly={{ x: -20, duration: 500, delay: 600 }}
                >
                    <div class="timeline-dot"></div>
                    <div class="timeline-content">
                        <h3>2025 - Expanding Horizons</h3>
                        <p>
                            Today, we've created a system that not only alerts
                            you to problems but helps you prevent them from ever
                            happening. We are expanding our services across
                            India, helping businesses of all sizes ensure the
                            integrity of their supply chain.
                        </p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Meet the Team Section -->
        <section class="team-section" in:fade={{ duration: 600, delay: 400 }}>
            <h2>Meet the Team</h2>
            <div class="team-grid">
                {#each teamMembers as member (member.id)}
                    <div
                        class="team-card"
                        in:fly={{
                            y: 20,
                            duration: 400,
                            delay: 500 + member.id * 100,
                        }}
                    >
                        <div class="avatar">{getInitials(member.name)}</div>
                        <h3>{member.name}</h3>
                        <span class="role">{member.role}</span>
                        <p>{member.bio}</p>
                    </div>
                {/each}
            </div>
        </section>

        <!-- Call to Action Section -->
        <section class="cta-section" in:fade={{ duration: 600, delay: 500 }}>
            <h2>Ready to Transform Your Supply Chain?</h2>
            <p>
                Join dozens of companies who trust Coldchain Monitor to protect
                their most valuable assets. Get started today and bring a new
                level of certainty to your logistics.
            </p>
            <button
                class="cta-btn"
                on:click={() => (window.location.href = "/Login")}
                >Go to Login</button
            >
        </section>
    </div>
</div>

<Footer />

<style>
    :global(body) {
        margin: 0;
        font-family: "Quicksand", "Segoe UI", sans-serif;
        background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
        min-height: 100vh;
    }

    .page-container {
        padding: 2rem 3rem;
        max-width: 1200px;
        margin: 0 auto;
    }

    .page-header {
        text-align: center;
        margin-bottom: 3rem;
        color: #005bea;
    }

    .page-header h1 {
        font-size: 2.8rem;
        margin: 0 0 0.5rem 0;
        font-weight: 800;
    }

    .page-header p {
        font-size: 1.3rem;
        margin: 0;
        color: #333;
        max-width: 800px;
        margin: 0 auto;
    }

    .content-wrapper {
        background: rgba(255, 255, 255, 0.9);
        border-radius: 1.5rem;
        padding: 2rem 3rem;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
    }

    .info-section {
        margin-bottom: 4rem;
    }

    .info-section h2,
    .team-section h2 {
        font-size: 2rem;
        color: #005bea;
        font-weight: 700;
        margin-bottom: 1.5rem;
        padding-bottom: 0.5rem;
        border-bottom: 3px solid #00c6fb;
        display: inline-block;
    }

    .info-section p {
        font-size: 1.15rem;
        line-height: 1.8;
        color: #333;
    }

    /* Values Section */
    .values-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 2rem;
    }
    .value-card {
        text-align: center;
    }
    .value-icon {
        background-color: #e3f2fd;
        color: #005bea;
        width: 80px;
        height: 80px;
        border-radius: 50%;
        margin: 0 auto 1rem auto;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 15px rgba(0, 91, 234, 0.1);
    }
    .value-card h3 {
        font-size: 1.4rem;
        color: #005bea;
        margin-bottom: 0.5rem;
    }
    .value-card p {
        font-size: 1rem;
        line-height: 1.6;
        color: #555;
    }

    /* Interactive Timeline */
    .timeline {
        position: relative;
        padding: 2rem 0;
        margin-top: 2rem;
    }
    .timeline::before {
        content: "";
        position: absolute;
        top: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 4px;
        height: 100%;
        background: #e3f2fd;
        border-radius: 2px;
    }
    .timeline-item {
        position: relative;
        width: 50%;
        padding: 1rem 2rem;
        margin-bottom: 2rem;
    }
    .timeline-item:nth-child(odd) {
        left: 0;
        padding-right: 40px;
        text-align: right;
    }
    .timeline-item:nth-child(even) {
        left: 50%;
        padding-left: 40px;
        text-align: left;
    }
    .timeline-dot {
        position: absolute;
        top: 20px;
        width: 20px;
        height: 20px;
        background: #00c6fb;
        border: 4px solid #fff;
        border-radius: 50%;
        box-shadow: 0 0 0 4px #00c6fb;
    }
    .timeline-item:nth-child(odd) .timeline-dot {
        right: -10px;
        transform: translate(50%, -50%);
    }
    .timeline-item:nth-child(even) .timeline-dot {
        left: -10px;
        transform: translate(-50%, -50%);
    }
    .timeline-content h3 {
        color: #005bea;
        font-size: 1.3rem;
        margin-top: 0;
    }
    .timeline-content p {
        font-size: 1rem;
        line-height: 1.6;
    }

    /* Team Section */
    .team-section h2 {
        text-align: center;
        border-bottom: none;
        width: 100%;
    }
    .team-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 2rem;
        margin-top: 2rem;
    }
    .team-card {
        text-align: center;
        padding: 2rem;
        background-color: #f8f9fa;
        border-radius: 1rem;
        transition:
            transform 0.2s ease-in-out,
            box-shadow 0.2s ease-in-out;
    }
    .team-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 12px 40px rgba(0, 0, 0, 0.1);
    }
    .team-card .avatar {
        width: 90px;
        height: 90px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #005bea;
        color: white;
        font-weight: 700;
        font-size: 2rem;
        text-transform: uppercase;
        margin: 0 auto 1rem auto;
        border: 4px solid #fff;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }
    .team-card h3 {
        margin: 0 0 0.25rem 0;
        font-size: 1.4rem;
        color: #005bea;
    }
    .team-card .role {
        display: block;
        margin-bottom: 1rem;
        font-weight: 600;
        color: #f7971e;
    }
    .team-card p {
        font-size: 1rem;
        line-height: 1.6;
        color: #555;
    }

    /* CTA Section */
    .cta-section {
        text-align: center;
        padding: 3rem 2rem;
        margin-top: 3rem;
        background: linear-gradient(135deg, #e0f7fa 0%, #fce4ec 100%);
        border-radius: 1rem;
    }
    .cta-section h2 {
        font-size: 2rem;
        color: #005bea;
        margin-top: 0;
    }
    .cta-section p {
        font-size: 1.15rem;
        color: #333;
        max-width: 600px;
        margin: 0 auto 2rem auto;
    }
    .cta-btn {
        background: linear-gradient(90deg, #00c6fb 0%, #005bea 100%);
        color: #fff;
        border: none;
        border-radius: 2rem;
        padding: 1rem 2.5rem;
        font-size: 1.2rem;
        font-weight: 700;
        cursor: pointer;
        box-shadow: 0 4px 20px rgba(0, 91, 234, 0.3);
        transition:
            transform 0.2s,
            box-shadow 0.2s;
    }
    .cta-btn:hover {
        transform: scale(1.05);
        box-shadow: 0 6px 25px rgba(0, 91, 234, 0.4);
    }

    @media (max-width: 768px) {
        .page-container {
            padding: 1.5rem;
        }
        .content-wrapper {
            padding: 1.5rem;
        }
        .page-header h1 {
            font-size: 2.2rem;
        }
        .page-header p {
            font-size: 1.1rem;
        }
        .timeline::before {
            left: 10px;
        }
        .timeline-item,
        .timeline-item:nth-child(even) {
            left: 0;
            width: 100%;
            padding-left: 40px;
            text-align: left;
        }
        .timeline-item:nth-child(odd) {
            padding-right: 1rem;
        }
        .timeline-dot,
        .timeline-item:nth-child(odd) .timeline-dot,
        .timeline-item:nth-child(even) .timeline-dot {
            left: 10px;
            transform: translate(-50%, -50%);
        }
    }
</style>
