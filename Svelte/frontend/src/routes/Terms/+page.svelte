<!--
  Component: src/routes/terms-of-service/+page.svelte
  Description: A comprehensive Terms of Service page, styled to match the project's theme.
-->
<script lang="ts">
    import { fly, fade } from "svelte/transition";
    import Navbar2 from "../../components/Navbar/Navbar2.svelte";
    import Footer from "../../components/Footer/Footer.svelte";
    
</script>

<Navbar2 />

<div class="page-container">
    <header class="page-header" in:fly={{ y: -30, duration: 500 }}>
        <h1>Terms of Service</h1>
        <p>Please read these terms carefully before using our service.</p>
    </header>

    <div class="content-wrapper">
        <section class="info-section" in:fade={{ duration: 600, delay: 100 }}>
            <p class="meta-info">
                <strong>Effective Date:</strong> September 3, 2025
            </p>
            <p>
                Welcome to Coldchain Monitor! These Terms of Service ("Terms")
                govern your access to and use of the Coldchain Monitor website
                and services (collectively, the "Service"), operated by
                Coldchain Monitor ("we," "us," or "our"). Your access to and use
                of the Service is conditioned on your acceptance of and
                compliance with these Terms.
            </p>
        </section>

        <section class="info-section" in:fade={{ duration: 600, delay: 200 }}>
            <h2>1. Agreement to Terms</h2>
            <p>
                By creating an account or by using our Service, you agree to be
                bound by these Terms. If you disagree with any part of the
                terms, then you may not access the Service.
            </p>
        </section>

        <section class="info-section" in:fade={{ duration: 600, delay: 300 }}>
            <h2>2. User Accounts</h2>
            <p>
                When you create an account with us, you must provide us with
                information that is accurate, complete, and current at all
                times. Failure to do so constitutes a breach of the Terms, which
                may result in immediate termination of your account on our
                Service. You are responsible for safeguarding the password that
                you use to access the Service and for any activities or actions
                under your password.
            </p>
        </section>

        <section class="info-section" in:fade={{ duration: 600, delay: 400 }}>
            <h2>3. Use of the Service</h2>
            <p>
                You agree not to use the Service for any purpose that is illegal
                or prohibited by these Terms. You may not use the Service in any
                manner that could damage, disable, overburden, or impair the
                Service, or interfere with any other party's use and enjoyment
                of the Service.
            </p>
        </section>

        <section class="info-section" in:fade={{ duration: 600, delay: 500 }}>
            <h2>4. Termination</h2>
            <p>
                We may terminate or suspend your account immediately, without
                prior notice or liability, for any reason whatsoever, including
                without limitation if you breach the Terms. Upon termination,
                your right to use the Service will immediately cease.
            </p>
        </section>

        <section class="info-section" in:fade={{ duration: 600, delay: 600 }}>
            <h2>5. Governing Law</h2>
            <p>
                These Terms shall be governed and construed in accordance with
                the laws of Madhya Pradesh, India, without regard to its
                conflict of law provisions. Our failure to enforce any right or
                provision of these Terms will not be considered a waiver of
                those rights.
            </p>
        </section>

        <section class="info-section" in:fade={{ duration: 600, delay: 700 }}>
            <h2>6. Changes to Terms</h2>
            <p>
                We reserve the right, at our sole discretion, to modify or
                replace these Terms at any time. If a revision is material, we
                will provide at least 30 days' notice prior to any new terms
                taking effect. What constitutes a material change will be
                determined at our sole discretion.
            </p>
        </section>

        <section class="info-section" in:fade={{ duration: 600, delay: 800 }}>
            <h2>7. Contact Us</h2>
            <p>
                If you have any questions about these Terms, please contact us
                at: <strong>legal@coldchainmonitor.example.com</strong>
            </p>
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
        margin-bottom: 2.5rem;
    }

    .info-section h2 {
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

    .meta-info {
        font-style: italic;
        color: #555;
        margin-bottom: 2rem;
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
    }
</style>
