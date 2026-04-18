<!--
  Component: src/routes/contact/+page.svelte
  Description: A graphically rich and interactive contact page with animated form elements,
               real-time validation, and a dynamic layout.
-->
<script lang="ts">
    import { fly, fade, scale } from "svelte/transition";
    import Navbar from "../../components/Navbar/Navbar.svelte";
    import Footer from "../../components/Footer/Footer.svelte";

    // Form state
    let formValues = {
        name: "",
        email: "",
        subject: "",
        message: "",
    };
    let errors = {
        name: "",
        email: "",
        message: "",
    };
    let formStatus = "";
    let isSubmitting = false;

    // --- Form Validation ---
    function validate() {
        errors = { name: "", email: "", message: "" };
        let isValid = true;

        if (!formValues.name) {
            errors.name = "Full name is required.";
            isValid = false;
        }
        if (!/^\S+@\S+\.\S+$/.test(formValues.email)) {
            errors.email = "Please enter a valid email address.";
            isValid = false;
        }
        if (!formValues.message) {
            errors.message = "A message is required.";
            isValid = false;
        }
        return isValid;
    }

    // --- Form Submission ---
    async function handleSubmit(event: Event) {
        if (!validate()) {
            return;
        }
        isSubmitting = true;
        formStatus = "";

        fetch("http://localhost:8085/exp/messages", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(formValues),
        })
            .then((response) => {
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }
                return response.json();
            })
            .then((data) => {
                console.log("Success:", data);
            });
        await new Promise((resolve) => setTimeout(resolve, 1500));

        isSubmitting = false;
        formStatus =
            "Thank you for your message! We will get back to you shortly.";
        formValues = { name: "", email: "", subject: "", message: "" }; // Reset form

        setTimeout(() => {
            formStatus = "";
        }, 5000);
    }
</script>

<!-- The Navbar and Footer are now handled by the global +layout.svelte -->

<Navbar />

<div class="page-container">
    <header class="page-header" in:fly={{ y: -30, duration: 500 }}>
        <h1>Connect With Us</h1>
        <p>
            Your feedback drives our innovation. Let's build a more reliable
            cold chain, together.
        </p>
    </header>

    <div class="content-wrapper">
        <div class="contact-grid">
            <!-- Left Side: Interactive Form -->
            <section
                class="contact-form-section"
                in:fade={{ duration: 600, delay: 100 }}
            >
                <h2>Send Us a Message</h2>
                <form on:submit|preventDefault={handleSubmit} novalidate>
                    <div class="form-group floating-label-group">
                        <input
                            type="text"
                            id="name"
                            name="name"
                            bind:value={formValues.name}
                            placeholder=" "
                            class:invalid={errors.name}
                        />
                        <label for="name">Full Name</label>
                        {#if errors.name}<span class="error-message"
                                >{errors.name}</span
                            >{/if}
                    </div>

                    <div class="form-group floating-label-group">
                        <input
                            type="email"
                            id="email"
                            name="email"
                            bind:value={formValues.email}
                            placeholder=" "
                            class:invalid={errors.email}
                        />
                        <label for="email">Email Address</label>
                        {#if errors.email}<span class="error-message"
                                >{errors.email}</span
                            >{/if}
                    </div>

                    <div class="form-group floating-label-group">
                        <input
                            type="text"
                            id="subject"
                            name="subject"
                            bind:value={formValues.subject}
                            placeholder=" "
                        />
                        <label for="subject">Subject (Optional)</label>
                    </div>

                    <div class="form-group floating-label-group">
                        <textarea
                            id="message"
                            name="message"
                            rows="5"
                            bind:value={formValues.message}
                            placeholder=" "
                            class:invalid={errors.message}
                        ></textarea>
                        <label for="message">Your Message</label>
                        {#if errors.message}<span class="error-message"
                                >{errors.message}</span
                            >{/if}
                    </div>

                    <button
                        type="submit"
                        class="submit-btn"
                        disabled={isSubmitting}
                    >
                        {#if isSubmitting}
                            <div class="spinner"></div>
                            <span>Sending...</span>
                        {:else}
                            <span>Send Message</span>
                        {/if}
                    </button>
                </form>
                {#if formStatus}
                    <div class="form-status" in:fade>
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            ><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"
                            ></path><polyline points="22 4 12 14.01 9 11.01"
                            ></polyline></svg
                        >
                        <span>{formStatus}</span>
                    </div>
                {/if}
            </section>

            <!-- Right Side: Contact Details & Map -->
            <section
                class="contact-details-section"
                in:fade={{ duration: 600, delay: 200 }}
            >
                <h2>Direct Contact</h2>
                <div
                    class="contact-card"
                    in:fly={{ y: 20, duration: 400, delay: 300 }}
                >
                    <div class="icon">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            ><path
                                d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"
                            ></path><polyline points="22,6 12,13 2,6"
                            ></polyline></svg
                        >
                    </div>
                    <div class="text">
                        <strong>Sales & Support</strong>
                        <a href="mailto:support@coldchainmonitor.example.com"
                            >support@coldchainmonitor.example.com</a
                        >
                    </div>
                </div>
                <div
                    class="contact-card"
                    in:fly={{ y: 20, duration: 400, delay: 400 }}
                >
                    <div class="icon">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            width="24"
                            height="24"
                            viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            ><path
                                d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"
                            ></path><circle cx="12" cy="10" r="3"></circle></svg
                        >
                    </div>
                    <div class="text">
                        <strong>Our Office</strong>
                        <span>Sec 126,Noida, India</span
                        >
                    </div>
                </div>

                <div
                    class="map-container"
                    in:scale={{ duration: 500, delay: 500 }}>
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3502.1234567890123!2d77.40000000000001!3d28.60000000000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390ce5b123456789%3A0xabcdef1234567890!2sSec%20126%2C%20Noida%2C%20Uttar%20Pradesh%20201301%2C%20India!5e0!3m2!1sen!2sus!4v1610000000000!5m2!1sen!2sus" 
                        width="100%" 
                        height="100%" 
                        style="border:0;" 
                        allowfullscreen 
                        loading="lazy" 
                        referrerpolicy="no-referrer-when-downgrade"
                        title="Map showing Sec 126, Noida, India"
                        ></iframe>
                    <div class="map-pin"></div>
                    <div class="map-pulse"></div>
                </div>
            </section>
        </div>
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
        background: rgba(255, 255, 255, 0.95);
        border-radius: 1.5rem;
        padding: 2.5rem 3.5rem;
        box-shadow: 0 16px 40px rgba(0, 0, 0, 0.12);
    }

    .contact-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 3.5rem;
    }

    .contact-form-section h2,
    .contact-details-section h2 {
        font-size: 2rem;
        color: #005bea;
        font-weight: 700;
        margin-bottom: 2rem;
        padding-bottom: 0.5rem;
        border-bottom: 3px solid #00c6fb;
        display: inline-block;
    }

    /* Floating Label Form Styles */
    .form-group {
        margin-bottom: 1.5rem;
    }
    .floating-label-group {
        position: relative;
    }
    .floating-label-group input,
    .floating-label-group textarea {
        width: 100%;
        padding: 1rem;
        border: 2px solid #ccc;
        border-radius: 0.5rem;
        font-size: 1rem;
        font-family: "Quicksand", sans-serif;
        background-color: #f8f9fa;
        box-sizing: border-box;
        transition: border-color 0.2s;
    }
    .floating-label-group label {
        position: absolute;
        left: 1rem;
        top: 1rem;
        color: #999;
        background: #f8f9fa;
        padding: 0 0.25rem;
        transition: all 0.2s ease-out;
        pointer-events: none;
    }
    .floating-label-group input:focus,
    .floating-label-group textarea:focus,
    .floating-label-group input:not(:placeholder-shown),
    .floating-label-group textarea:not(:placeholder-shown) {
        border-color: #005bea;
    }
    .floating-label-group input:focus + label,
    .floating-label-group textarea:focus + label,
    .floating-label-group input:not(:placeholder-shown) + label,
    .floating-label-group textarea:not(:placeholder-shown) + label {
        top: -0.75rem;
        left: 0.75rem;
        font-size: 0.9rem;
        color: #005bea;
    }
    .form-group input.invalid,
    .form-group textarea.invalid {
        border-color: #c62828;
    }
    .error-message {
        color: #c62828;
        font-size: 0.85rem;
        padding-left: 0.5rem;
    }

    /* Submit Button */
    .submit-btn {
        background: linear-gradient(90deg, #00c6fb 0%, #005bea 100%);
        color: #fff;
        border: none;
        border-radius: 2rem;
        padding: 0.8rem 2rem;
        font-size: 1.1rem;
        font-weight: 700;
        cursor: pointer;
        box-shadow: 0 4px 20px rgba(0, 91, 234, 0.3);
        transition: all 0.2s;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
    }
    .submit-btn:hover:not(:disabled) {
        transform: translateY(-3px);
        box-shadow: 0 6px 25px rgba(0, 91, 234, 0.4);
    }
    .submit-btn:disabled {
        background: #ccc;
        cursor: not-allowed;
    }

    .spinner {
        width: 20px;
        height: 20px;
        border: 3px solid rgba(255, 255, 255, 0.3);
        border-top-color: #fff;
        border-radius: 50%;
        animation: spin 1s linear infinite;
    }
    @keyframes spin {
        to {
            transform: rotate(360deg);
        }
    }

    .form-status {
        text-align: center;
        margin-top: 1rem;
        font-weight: 600;
        color: #1b5e20;
        background-color: #e8f5e9;
        padding: 0.75rem;
        border-radius: 0.5rem;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
    }

    /* Contact Details Cards */
    .contact-card {
        display: flex;
        align-items: center;
        gap: 1.5rem;
        background: #f8f9fa;
        padding: 1.5rem;
        border-radius: 1rem;
        margin-bottom: 1.5rem;
        transition: all 0.2s;
        border-left: 5px solid #00c6fb;
    }
    .contact-card:hover {
        transform: translateX(5px);
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    }
    .contact-card .icon {
        background-color: #e3f2fd;
        color: #005bea;
        width: 50px;
        height: 50px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }
    .contact-card .text strong {
        display: block;
        font-size: 1.2rem;
        color: #005bea;
        margin-bottom: 0.25rem;
    }
    .contact-card .text span,
    .contact-card .text a {
        font-size: 1.1rem;
        color: #333;
        text-decoration: none;
    }
    .contact-card .text a:hover {
        text-decoration: underline;
    }

    /* Stylized Map */
    .map-container {
        width: 100%;
        aspect-ratio: 16/10;
        background: linear-gradient(45deg, #e3f2fd, #fce4ec);
        border-radius: 1rem;
        margin-top: 2rem;
        overflow: hidden;
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .map-pin {
        width: 30px;
        height: 30px;
        background: #ff5f6d;
        border-radius: 50% 50% 50% 0;
        transform: rotate(-45deg);
        position: absolute;
        border: 3px solid white;
    }
    .map-pulse {
        width: 30px;
        height: 30px;
        background: #ff5f6d;
        border-radius: 50%;
        position: absolute;
        animation: pulse 2s infinite;
        opacity: 0;
    }
    @keyframes pulse {
        0% {
            transform: scale(0.95);
            opacity: 0.7;
        }
        70% {
            transform: scale(2.5);
            opacity: 0;
        }
        100% {
            opacity: 0;
        }
    }

    @media (max-width: 900px) {
        .contact-grid {
            grid-template-columns: 1fr;
        }
    }

    @media (max-width: 768px) {
        .page-container {
            padding: 1.5rem;
        }
        .content-wrapper {
            padding: 1.5rem 2rem;
        }
        .page-header h1 {
            font-size: 2.2rem;
        }
        .page-header p {
            font-size: 1.1rem;
        }
    }
</style>
