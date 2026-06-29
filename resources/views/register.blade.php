@extends('layouts.app')

@section('title', 'Sign Up - RELASKA Computer')

@section('navbar')
@endsection

@section('styles')
<!-- Menggunakan Style CSS yang 100% SAMA dengan Login -->
<style>
    :root { --primary-grad: linear-gradient(90deg, #D72C84 0%, #0A97D8 100%); }
    body {
        margin: 0; 
        padding: 0; 
        font-family: 'Montserrat', sans-serif;
        min-height: 100vh; 
        display: flex; 
        flex-direction: column;
        
        /* Mahakarya Gradien Gelap RELASKA */
        background: linear-gradient(-45deg, #040812, #0a1128, #0f1938, #142045) !important;
        background-size: 400% 400% !important; 
        animation: gradientBG 15s ease infinite !important;
        overflow-x: hidden;
    }
    @keyframes gradientBG {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }
    #liveBg { position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1; background: transparent; }
    .auth-wrapper { flex: 1; display: flex; flex-direction: column; }
    .login-main-area {
        position: relative; flex: 1; display: flex; justify-content: center; align-items: center;
        padding: 40px 20px; box-sizing: border-box; z-index: 1;
    }
    /* KOTAK TERMINAL HACKER DINAMIS */
    .hacker-log {
        position: absolute;
        color: rgba(255, 255, 255, 0.5); /* Putih transparan agar menyatu dengan background */
        font-family: 'Courier New', monospace;
        font-size: 12px;
        white-space: pre-wrap;
        pointer-events: none;
        z-index: 0;
        overflow: hidden;
        line-height: 1.6;
        text-shadow: 0 0 5px rgba(255, 255, 255, 0.3);
    }
    .log-top-left { top: 60px; left: 60px; width: 300px; height: 160px; text-align: left; }
    .log-bottom-right { bottom: 80px; right: 60px; width: 300px; height: 160px; text-align: right; }
    .card-login {
        background: #ffffff; border-radius: 25px; box-shadow: 0 25px 50px rgba(0,0,0,0.5);
        width: 100%; max-width: 480px; padding: 50px 45px; z-index: 10; position: relative; text-align: center;
    }
    .welcome-text h3 { font-weight: 800; font-size: 1.6rem; margin-bottom: 8px; letter-spacing: -0.5px; }
    .welcome-text p { font-size: 0.85rem; color: #6c757d; margin-bottom: 25px; }
    .form-control-custom { background-color: #f4f6f8; border: 1px solid #e1e1e1; padding: 12px 15px; border-radius: 8px; margin-bottom: 15px; font-size: 0.95rem; width: 100%; }
    .form-control-custom:focus { background: #fff; border-color: #0A97D8; box-shadow: 0 0 0 4px rgba(10, 151, 216, 0.1); outline: none; }
    .btn-gradient { background: linear-gradient(90deg, #d500f9, #2979ff); border: none; color: white; font-weight: 700; padding: 14px; border-radius: 8px; width: 100%; transition: 0.3s; margin-top: 10px; }
    .btn-gradient:hover { transform: translateY(-3px); box-shadow: 0 12px 24px rgba(213, 0, 249, 0.3); filter: brightness(1.1); color: white; }
    .signup-text { margin-top: 25px; font-size: 0.85rem; }
    .signup-text a { color: #2979ff; text-decoration: none; font-weight: 800; }
    
    /* Custom Footer */
    .footer-auth { background: #1a1a1a; color: #fff; padding: 60px 0 30px; border-radius: 60px 60px 0 0; position: relative; z-index: 5; width: 100%; margin-top: auto; }
    .footer-logo-main { max-height: 80px; margin-bottom: 15px; filter: brightness(0) invert(1); }
    .footer-brand-text { font-size: 32px; font-weight: 800; letter-spacing: 12px; text-transform: uppercase; }
    .footer-brand-subtext { font-size: 14px; letter-spacing: 6px; color: #6c757d; text-transform: uppercase; margin-bottom: 40px; }
    .footer-divider { border-top: 1px solid rgba(255,255,255,0.1); margin: 30px 0; }
    .footer-link { color: rgba(255,255,255,0.5); text-decoration: none; font-size: 14px; transition: 0.3s; margin: 5px 12px; display: inline-block; }
    .social-icons i { font-size: 22px; margin: 0 15px; color: #fff; transition: 0.3s; }
    @media (max-width: 768px) { .login-main-area::before, .login-main-area::after { display: none; } .card-login { max-width: 90%; padding: 40px 25px; } }
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
@endsection

@section('content')
<div class="auth-wrapper">
    <canvas id="liveBg"></canvas>

<div class="login-main-area">
        <div id="log-left" class="hacker-log log-top-left"></div>
        <div id="log-right" class="hacker-log log-bottom-right"></div>
        <div class="card-login">
            <div class="text-start w-100 mb-3">
                <a href="javascript:void(0)" onclick="history.back()" class="text-dark text-decoration-none d-inline-flex align-items-center fw-bold small">
                    <i class="bi bi-arrow-left-circle-fill me-2 fs-5"></i> Kembali
                </a>
            </div>
            <div class="mb-3">
                <img src="{{ asset('assets/img/Icon Logo RELASKA rounded.png') }}" alt="Logo" style="max-height: 60px;">
            </div>

            <div class="welcome-text">
                <h3 class="mb-2">Buat Akun Baru</h3>
                <p>Daftar sekarang untuk simpan rakitan impianmu!</p>
            </div>

            <form action="{{ url('auth/registerProcess') }}" method="POST">
                @csrf
                <input type="hidden" name="redirect" value="{{ request('redirect') }}">
                
                <div class="text-start mb-1"><label class="small fw-bold text-muted px-1">Nama Lengkap</label></div>
                <input type="text" class="form-control-custom" name="fullname" required>
                
                <div class="text-start mb-1"><label class="small fw-bold text-muted px-1">Username</label></div>
                <input type="text" class="form-control-custom" name="username" required>
                
                <div class="text-start mb-1"><label class="small fw-bold text-muted px-1">Password</label></div>
                <input type="password" class="form-control-custom" name="password" placeholder="Minimal 6 karakter" required>

                <button type="submit" class="btn btn-gradient">Daftar & Lanjutkan</button>
            </form>

            <div class="signup-text">
                <span class="text-muted">Sudah punya akun?</span> 
                <a href="{{ url('login') }}{{ request('redirect') ? '?redirect=' . urlencode(request('redirect')) : '' }}">Log In</a>
            </div>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script>
    // Canvas Animasi
    const canvas = document.getElementById('liveBg');
    const ctx = canvas.getContext('2d');
    canvas.width = window.innerWidth; canvas.height = window.innerHeight;
    let particlesArray = [];
    class Particle {
        constructor() {
            this.x = Math.random() * canvas.width; this.y = Math.random() * canvas.height;
            this.size = Math.random() * 2 + 1; this.speedX = Math.random() * 0.5 - 0.25; this.speedY = Math.random() * 0.5 - 0.25;
        }
        update() {
            this.x += this.speedX; this.y += this.speedY;
            if (this.x > canvas.width) this.x = 0; else if (this.x < 0) this.x = canvas.width;
            if (this.y > canvas.height) this.y = 0; else if (this.y < 0) this.y = canvas.height;
        }
        draw() { ctx.fillStyle = 'rgba(255, 255, 255, 0.5)'; ctx.beginPath(); ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2); ctx.fill(); }
    }
    function init() { particlesArray = []; for (let i = 0; i < 80; i++) { particlesArray.push(new Particle()); } }
    function connect() {
        for (let a = 0; a < particlesArray.length; a++) {
            for (let b = a; b < particlesArray.length; b++) {
                let distance = ((particlesArray[a].x - particlesArray[b].x) ** 2) + ((particlesArray[a].y - particlesArray[b].y) ** 2);
                if (distance < (canvas.width / 7) * (canvas.height / 7)) {
                    let opacity = 1 - (distance / 15000); ctx.strokeStyle = `rgba(0, 212, 255, ${opacity})`; ctx.lineWidth = 1;
                    ctx.beginPath(); ctx.moveTo(particlesArray[a].x, particlesArray[a].y); ctx.lineTo(particlesArray[b].x, particlesArray[b].y); ctx.stroke();
                }
            }
        }
    }
    function animate() { ctx.clearRect(0, 0, canvas.width, canvas.height); for (let i = 0; i < particlesArray.length; i++) { particlesArray[i].update(); particlesArray[i].draw(); } connect(); requestAnimationFrame(animate); }
    window.addEventListener('resize', () => { canvas.width = window.innerWidth; canvas.height = window.innerHeight; init(); });
    init(); animate();

    function simulasiRegister() {
        Swal.fire({ title: 'Pendaftaran Berhasil!', text: 'Akun kamu sudah aktif, silakan login.', icon: 'success', confirmButtonColor: '#0d6efd' }).then(() => {
            window.location.href = "{{ url('login') }}";
        });
    }

    // ==========================================
    // MESIN TEKS TERMINAL HACKER RELASKA
    // ==========================================
    const logLeft = document.getElementById('log-left');
    const logRight = document.getElementById('log-right');

    // Kumpulan kalimat log sistem acak
    const systemLogs = [
        "Initializing RELASKA_CORE_V3.0...",
        "Bypassing supplier firewall...",
        "STATUS: 200 OK CHECK",
        "WARRANTY_DATABASE.ORIGINALITY = TRUE;",
        "Fetching hardware matrix...",
        "Resolving compatibility dependencies...",
        "ERROR_CODE: 403 (Supplier API) - Retrying...",
        "SYNCHRONIZE_STOCK_DATA_FIXED;",
        "SYSTEM STATUS: VERIFIED",
        "Loading PC_BUILDER_MODULE...",
        "Checking socket LGA1700... MATCH",
        "Checking socket AM5... MATCH",
        "Encrypting user credentials...",
        "Establishing secure connection..."
    ];

    function printLog(element, align) {
        // Pilih kalimat acak dari array
        const randomLog = systemLogs[Math.floor(Math.random() * systemLogs.length)];
        const newLine = document.createElement('div');
        
        // Atur kursor '>' menyesuaikan posisi kiri atau kanan
        newLine.innerText = (align === 'left' ? "> " : "") + randomLog + (align === 'right' ? " <" : "");
        element.appendChild(newLine);

        // Batasi maksimal 8 baris agar teks lama terdorong ke atas (menghilang)
        if (element.childNodes.length > 8) {
            element.removeChild(element.firstChild);
        }
    }

    // Jalankan secara terus menerus dengan kecepatan berbeda
    // Teks kiri muncul setiap 800 milidetik, teks kanan setiap 1200 milidetik
    setInterval(() => printLog(logLeft, 'left'), 800);
    setInterval(() => printLog(logRight, 'right'), 1200);
</script>
@endsection