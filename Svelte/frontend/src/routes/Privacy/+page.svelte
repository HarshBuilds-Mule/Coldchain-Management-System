
<script lang="ts">
    import { fly, fade } from 'svelte/transition';
    import Navbar2 from '../../components/Navbar/Navbar2.svelte';
    import Footer from '../../components/Footer/Footer.svelte';
</script>

<Navbar2 />


<div class="page-container">
    <header class="page-header" in:fly={{ y: -30, duration: 500 }}>
        <h1>Privacy Policy</h1>
        <p>Your privacy is important to us. Here's how we collect, use, and protect your data.</p>
    </header>

    <div class="content-wrapper">
        <section class="info-section" in:fade={{ duration: 600, delay: 100 }}>
            <p class="meta-info"><strong>Last Updated:</strong> September 3, 2025</p>
            <p>
                This Privacy Policy describes how Coldchain Monitor ("we," "us," or "our") collects, uses, and discloses your information in connection with your use of our website and services (collectively, the "Service"). By using the Service, you agree to the collection and use of information in accordance with this policy.
            </p>
        </section>

        <section class="info-section" in:fade={{ duration: 600, delay: 200 }}>
            <h2>1. Information We Collect</h2>
            <p>We collect several different types of information for various purposes to provide and improve our Service to you.</p>
            
            <h3>Types of Data Collected:</h3>
            <ul>
                <li>
                    <strong>Personal Data:</strong> While using our Service, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you ("Personal Data"). This may include, but is not limited to: email address, first name and last name, and user role.
                </li>
                <li>
                    <strong>Usage Data:</strong> We may also collect information on how the Service is accessed and used ("Usage Data"). This Usage Data may include information such as your computer's Internet Protocol address (e.g., IP address), browser type, browser version, the pages of our Service that you visit, the time and date of your visit, and other diagnostic data.
                </li>
                <li>
                    <strong>Tracking & Cookies Data:</strong> We use cookies and similar tracking technologies to track the activity on our Service and hold certain information. You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent.
                </li>
            </ul>
        </section>
        
        <section class="info-section" in:fade={{ duration: 600, delay: 300 }}>
            <h2>2. How We Use Your Information</h2>
            <p>
                Coldchain Monitor uses the collected data for various purposes:
            </p>
             <ul>
                <li>To provide and maintain our Service</li>
                <li>To notify you about changes to our Service</li>
                <li>To provide customer support and respond to your inquiries</li>
                <li>To monitor the usage of our Service to detect, prevent, and address technical issues</li>
                <li>To gather analysis or valuable information so that we can improve our Service</li>
            </ul>
        </section>

        <section class="info-section" in:fade={{ duration: 600, delay: 400 }}>
            <h2>3. Data Security</h2>
            <p>
                The security of your data is critical to us. We strive to use commercially acceptable means to protect your Personal Data, including encryption and secure server infrastructure. However, remember that no method of transmission over the Internet or method of electronic storage is 100% secure. While we do our best to protect your information, we cannot guarantee its absolute security.
            </p>
            
        </section>

        <section class="info-section" in:fade={{ duration: 600, delay: 500 }}>
            <h2>4. Changes to This Privacy Policy</h2>
            <p>
                We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. We will let you know via email and/or a prominent notice on our Service, prior to the change becoming effective and update the "Last Updated" date at the top of this Privacy Policy.
            </p>
        </section>

        <section class="info-section" in:fade={{ duration: 600, delay: 600 }}>
            <h2>5. Contact Us</h2>
            <p>
                If you have any questions about this Privacy Policy, please contact us:
            </p>
            <ul>
                <li>By email: <strong>privacy@coldchainmonitor.example.com</strong></li>
                <li>By mail: <strong>Coldchain Monitor, Civil Lines, Jabalpur, Madhya Pradesh, India</strong></li>
            </ul>
        </section>
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

    .info-section p, .info-section li {
        font-size: 1.15rem;
        line-height: 1.8;
        color: #333;
    }
    
    .meta-info {
        font-style: italic;
        color: #555;
        margin-bottom: 2rem;
    }

    ul {
        list-style-type: disc;
        padding-left: 2rem;
    }

    li {
        margin-bottom: 1rem;
    }

    @media (max-width: 768px) {
        .page-container { padding: 1.5rem; }
        .content-wrapper { padding: 1.5rem; }
        .page-header h1 { font-size: 2.2rem; }
        .page-header p { font-size: 1.1rem; }
    }
</style>
