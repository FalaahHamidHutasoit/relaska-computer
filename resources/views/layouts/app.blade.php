<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'RELASKA COMPUTER')</title>
    
    <link rel="icon" type="image/png" href="{{ asset('assets/img/Icon Logo RELASKA rounded.png') }}">
    
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800;900&family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="module" src="https://ajax.googleapis.com/ajax/libs/model-viewer/3.3.0/model-viewer.min.js"></script>
    
    <style>
        /* Taruh di bagian paling atas di dalam tag <style> app.blade.php */
        body, input, button, select, textarea {
            font-family: 'Montserrat', sans-serif !important;
        }
    .navbar-top { padding: 15px 0; border-bottom: 1px solid #eee; background: white; }
    .search-container { position: relative; max-width: 600px; width: 100%; }
    /* CSS SEARCH BAR DENGAN GRADIENT BORDER */
    .search-input { 
        width: 100%; 
        padding: 12px 20px 12px 45px; 
        outline: none; 
        font-size: 0.9rem; 
        border-radius: 5px; 
        
        /* Teknik Ilusi Gradient Border */
        border: 2px solid transparent; 
        background-image: linear-gradient(white, white), linear-gradient(to bottom, #D72C84 0%, #FFE100 20%, #0A97D8 80%, #008cffff 100%);
        background-origin: border-box;
        background-clip: padding-box, border-box;
    }
    .search-icon-inside { position: absolute; left: 20px; top: 50%; transform: translateY(-50%); color: #7d8da1; z-index: 2;  }
    .search-btn { position: absolute; right: 0; top: 0; height: 100%; width: 50px; background: #1e1e1e; border: none; color: white; display: flex; align-items: center; justify-content: center; border-radius: 0 5px 5px 0; cursor: pointer; z-index: 2; }
    .search-results-dropdown { position: absolute; top: 100%; left: 0; right: 0; background: white; border-radius: 15px; box-shadow: 0 10px 40px rgba(0,0,0,0.1); margin-top: 10px; z-index: 1000; overflow: hidden; display: none; border: 1px solid #f0f0f0; }
    .search-item { display: flex; align-items: center; padding: 10px 15px; text-decoration: none; color: #333; transition: 0.2s; border-bottom: 1px solid #f9f9f9; }
    .search-item:hover { background-color: #f4f7fa; }
    .search-item img { width: 40px; height: 40px; object-fit: cover; border-radius: 8px; margin-right: 15px; border: 1px solid #eee; }
    .search-info h6 { margin: 0; font-size: 0.9rem; font-weight: 600; }
    .search-info span { font-size: 0.8rem; color: #0d6efd; font-weight: 700; }
    .nav-link-custom { color: var(--dark) !important; font-weight: 600; font-size: 14px; padding: 10px 15px !important; }
    @keyframes iconWiggle { 0% { transform: rotate(0deg); } 25% { transform: rotate(-10deg); } 50% { transform: rotate(10deg); } 75% { transform: rotate(-10deg); } 100% { transform: rotate(0deg); } }
    .btn-pc-builder-nav { transition: all 0.3s ease-in-out !important; background: transparent; color: #0d6efd !important; }
    .btn-pc-builder-nav:hover { background: #0d6efd !important; color: #ffffff !important; transform: translateY(-2px); box-shadow: 0 4px 15px rgba(13, 110, 253, 0.3); }
    .btn-pc-builder-nav:hover i { display: inline-block; animation: iconWiggle 0.5s ease infinite; }
    /* MAGIC LINE NAVBAR */
    .nav-magic-line {
        position: absolute;
        bottom: 0; /* Menempel di garis bawah navbar */
        left: 0;
        height: 3px;
        background-color: #0d6efd; /* Warna biru primary */
        border-radius: 3px 3px 0 0;
        transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1); /* Animasi gerak smooth */
        opacity: 0;
        pointer-events: none; /* Agar garisnya tidak menghalangi klik */
        z-index: 10;
    }
    
    /* Mengubah warna teks yang aktif agar lebih kontras */
    .nav-link-custom.active-nav {
        color: #0d6efd !important;
    }

    /* =========================================
       CSS DROPDOWN GUEST (SIGN IN HOVER)
       ========================================= */
    .auth-hover-container { 
        position: relative; 
        display: inline-flex; 
        align-items: center; 
        padding: 10px 0; 
        cursor: pointer; 
    }
    
    .auth-dropdown-menu {
        position: absolute; 
        top: 100%; 
        right: -10px; /* Sedikit digeser agar lurus dengan margin */
        width: 320px; 
        background: #212121; 
        border-radius: 12px; 
        padding: 30px 25px; 
        opacity: 0; 
        visibility: hidden;
        transform: translateY(15px); 
        transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1); 
        z-index: 1050;
        cursor: default;
        text-align: left;
    }
    
    /* Animasi saat disorot mouse */
    .auth-hover-container:hover .auth-dropdown-menu { 
        opacity: 1; 
        visibility: visible; 
        transform: translateY(0); 
    }
    .auth-hover-container:hover .chevron-icon { 
        transform: rotate(180deg); 
    }
    .chevron-icon { 
        transition: transform 0.3s ease; 
    }
    
    /* Tipografi di dalam kotak gelap */
    .auth-dropdown-menu h6 { font-size: 14px; font-weight: 500; color: #fff; margin-bottom: 2px; }
    .auth-dropdown-menu h5 { font-size: 18px; font-weight: 800; color: #fff; margin-bottom: 20px; }
    .auth-dropdown-menu p.benefit-title { font-size: 13px; color: #b0b0b0; margin-bottom: 12px; }
    
    /* List Keuntungan */
    .auth-dropdown-list { list-style: none; padding: 0; margin: 0 0 25px 0; }
    .auth-dropdown-list li { font-size: 13px; color: #e0e0e0; margin-bottom: 10px; position: relative; padding-left: 15px; }
    .auth-dropdown-list li::before { 
        content: "•"; 
        position: absolute; 
        left: 0; 
        color: #888; 
        font-size: 16px; 
        line-height: 1; 
        top: -1px; 
    }
    
    /* Tombol Log In & Register di dalam dropdown */
    .btn-auth-dropdown {
        display: block; 
        width: 100%; 
        text-align: center; 
        padding: 12px; 
        border-radius: 6px;
        background: #2b2b2b; 
        color: #fff; 
        text-decoration: none; 
        font-weight: 700; 
        font-size: 14px;
        margin-bottom: 12px; 
        border: 2px solid #3c3c3c; 
        transition: all 0.3s ease;
    }
    
    /* Efek Gradient Border saat tombol disorot */
    .btn-auth-dropdown:hover {
        border: 2px solid transparent;
        background-image: linear-gradient(#2b2b2b, #2b2b2b), linear-gradient(to right, #D72C84 0%, #FFE100 20%, #0A97D8 80%, #008cffff 100%);
        background-origin: border-box; 
        background-clip: padding-box, border-box;
        color: #fff;
    }

    /* =========================================
       CSS FOOTER PREMIUM RELASKA 
       ========================================= */
    .footer { background: #1e1e1e; color: white; padding: 80px 0 40px; border-radius: 60px 60px 0 0; margin-top: 100px; }
    .footer-logo-main { max-height: 80px; margin-bottom: 10px; }
    .footer-brand-text { font-size: 32px; font-weight: 800; letter-spacing: 12px; text-transform: uppercase; margin-bottom: 5px; }
    .footer-brand-subtext { font-size: 14px; letter-spacing: 6px; color: #909090; text-transform: uppercase; margin-bottom: 40px; }
    .footer-divider { border-top: 1px solid rgba(255,255,255,0.1); margin: 40px 0; }
    .footer h6 { font-weight: 700; margin-bottom: 25px; font-size: 18px; }
    .footer-link { color: rgba(255,255,255,0.6); text-decoration: none; font-size: 14px; transition: 0.3s; margin: 0 10px; }
    .footer-link:hover { color: #fff; }
    .social-icons i { font-size: 24px; margin: 0 15px; color: white; cursor: pointer; transition: 0.3s; }
    .social-icons i:hover { transform: translateY(-5px); color: #0d6efd; }
    .copyright-text { font-size: 12px; color: rgba(255,255,255,0.4); margin-top: 30px; }

    /* Custom Scrollbar untuk Filter */
    .filter-scroll::-webkit-scrollbar { width: 5px; }
    .filter-scroll::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 10px; }
    .filter-scroll::-webkit-scrollbar-thumb { background: #c1c1c1; border-radius: 10px; }
    .filter-scroll::-webkit-scrollbar-thumb:hover { background: #a8a8a8; }

    /* =========================================
       CSS DROPDOWN KERANJANG (CART HOVER)
       ========================================= */
    .cart-hover-container { 
        position: relative; 
        display: inline-flex; 
        align-items: center; 
        padding: 10px 0; 
        cursor: pointer; 
    }
    
    .cart-hover-container:hover .cart-dropdown-menu { 
        opacity: 1; 
        visibility: visible; 
        transform: translateY(0); 
    }
    .cart-hover-container:hover .cart-chevron-icon { 
        transform: rotate(180deg); 
    }
    
    .cart-dropdown-menu {
        position: absolute; 
        top: 100%; 
        right: -10px; 
        width: 360px; 
        background: #222222; 
        border-radius: 12px; 
        padding: 25px; 
        opacity: 0; 
        visibility: hidden;
        transform: translateY(15px); 
        transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1); 
        z-index: 1050;
        cursor: default;
        text-align: left;
        border: 1px solid #333;
        box-shadow: 0 15px 40px rgba(0,0,0,0.2);
    }

    /* Tombol Outline Gradient (Tampilkan Keranjang) disamakan warnanya */
    .btn-cart-outline {
        background: #222222;
        color: #fff;
        border: 2px solid transparent;
        background-image: linear-gradient(#222222, #222222), linear-gradient(to right, #ff5e62, #ff9966);
        background-origin: border-box; 
        background-clip: padding-box, border-box;
        transition: 0.3s;
    }
    .btn-cart-outline:hover { filter: brightness(1.2); color: white; }
    
    /* Tombol Solid Gradient (Checkout Sekarang) */
    .btn-cart-solid {
        background: linear-gradient(to right, #ff5e62, #ff9966);
        border: none;
        color: white;
        transition: 0.3s;
    }
    .btn-cart-solid:hover { filter: brightness(1.1); color: white; transform: translateY(-2px); }
    
    /* Titik Merah Indikator */
    .cart-indicator {
        position: absolute;
        top: 0px;
        right: 4px;
        width: 10px;
        height: 10px;
        background-color: #ff3366;
        border-radius: 50%;
        border: 2px solid white;
    }
    </style>
    @yield('styles')
</head>
<body>

    @section('navbar')
    <header class="sticky-top shadow-sm" style="z-index: 1020; background-color: white;">
    <div class="navbar-top">
        <div class="container d-flex align-items-center justify-content-between">
            <a class="navbar-brand" href="{{ url('/') }}">
                <img src="{{ asset('assets/img/logo_relaska.svg') }}" alt="RELASKA" style="height: 40px;">
            </a>
            
            <div class="search-container mx-4">
                <i class="bi bi-search search-icon-inside"></i>
                <input type="text" id="liveSearchInput" class="search-input" placeholder="Cari komponen... (cth: MSI, Intel)">
                <button class="search-btn"><i class="bi bi-arrow-right"></i></button>
                <div id="liveSearchResults" class="search-results-dropdown"></div>
            </div>

            <div class="d-flex align-items-center gap-4">
                <!-- LOGIKA CERDAS SIGN IN / USERNAME -->
                @if(session('logged_in'))
                    <div class="auth-hover-container">
                        <!-- Teks pemicu dengan icon chevron -->
                        <a href="#" class="text-dark fw-bold text-decoration-none d-flex align-items-center gap-2">
                            @if(session('role') == 'admin')
                                <i class="bi bi-shield-lock text-danger fs-5"></i> Admin: {{ session('username') }}
                            @else
                                <i class="bi bi-person-circle fs-5"></i> {{ session('username') }}
                            @endif
                            <i class="bi bi-chevron-down chevron-icon" style="font-size: 10px; font-weight: 900;"></i>
                        </a>
                        
                        <!-- Kotak Gelap yang muncul saat di-hover -->
                        <div class="auth-dropdown-menu shadow-lg" style="width: 280px; padding: 25px;">
                            <h6>Welcome back,</h6>
                            <h5 class="text-truncate mb-4">{{ session('username') }}</h5>
                            
                            @if(session('role') == 'admin')
                                <a href="{{ url('admin') }}" class="btn-auth-dropdown text-start ps-3"><i class="bi bi-speedometer2 me-2"></i> Admin Panel</a>
                            @else
                                <a href="{{ url('dashboard') }}" class="btn-auth-dropdown text-start ps-3"><i class="bi bi-grid-1x2 me-2"></i> Dashboard</a>
                            @endif
                            
                            <a href="{{ url('dashboard/pesanan') }}" class="btn-auth-dropdown text-start ps-3"><i class="bi bi-bag-check me-2"></i> Pesanan Saya</a>
                            
                            <div class="mt-4 pt-2 border-top border-secondary">
                                <a href="{{ url('auth/logout') }}" class="btn-auth-dropdown mb-0" style="background: rgba(220, 53, 69, 0.1); border-color: transparent; color: #ff4d4d; text-align: center; padding-left: 0;">
                                    <i class="bi bi-box-arrow-right me-2"></i> Logout
                                </a>
                            </div>
                        </div>
                    </div>
                @else
                    <div class="auth-hover-container">
                        <!-- Teks pemicu dengan icon chevron -->
                        <a href="{{ url('login') }}?redirect={{ urlencode(url()->current()) }}" class="text-decoration-none text-dark fw-bold small d-flex align-items-center gap-1">
                            Sign in <i class="bi bi-chevron-down chevron-icon" style="font-size: 10px; font-weight: 900;"></i>
                        </a>
                        
                        <!-- Kotak Gelap yang muncul saat di-hover -->
                        <div class="auth-dropdown-menu shadow-lg">
                            <h6>Selamat Datang di</h6>
                            <h5>RELASKA COMPUTER</h5>
                            
                            <p class="benefit-title">Keuntungan yang didapat</p>
                            <ul class="auth-dropdown-list">
                                <li>Klaim Hadiah Spin Wheel</li>
                                <li>Akses Penuh PC Builder</li>
                                <li>Masuk Program Loyalitas</li>
                                <li>Tukar Tambah Lebih Mudah</li>
                                <li>Riwayat Transaksi Akurat</li>
                            </ul>
                            
                            <!-- Tombol log in dan register -->
                            <a href="{{ url('login') }}?redirect={{ urlencode(url()->current()) }}" class="btn-auth-dropdown">Log In</a>
                            <a href="{{ url('register') }}?redirect={{ urlencode(url()->current()) }}" class="btn-auth-dropdown mb-0">Register</a>
                        </div>
                    </div>
                @endif
                
                <div class="vr" style="height: 25px;"></div>
                
                <div class="{{ session('logged_in') ? 'cart-hover-container' : '' }} ms-2">
                    <a href="{{ session('logged_in') ? url('cart') : 'javascript:void(0)' }}" 
                       @unless(session('logged_in')) onclick="requireLoginCart(event)" @endunless
                       class="d-flex align-items-center text-decoration-none text-dark position-relative" style="transition: 0.3s;">
                        
                        <div class="position-relative pe-2" id="navbar-cart-icon" style="transition: transform 0.2s;">
                            <i class="bi bi-cart3 fs-4"></i>
                            @if(session('logged_in') && count(session('cart', [])) > 0)
                                <div class="cart-indicator" id="cart-dot"></div>
                            @endif
                        </div>
                        
                        <div style="line-height: 1;">
                            <span class="fw-bold d-block small">Cart</span>
                            <small class="text-muted"><span id="cart-count">{{ count(session('cart', [])) }}</span> Items</small>
                        </div>
                        
                        @if(session('logged_in'))
                            <i class="bi bi-chevron-down cart-chevron-icon ms-2" style="font-size: 12px; font-weight: 900;"></i>
                        @endif
                    </a>

                    @if(session('logged_in'))
                    <div class="cart-dropdown-menu">
                        @php
                            $cart = session('cart', []);
                        @endphp
                        
                        @if(count($cart) > 0)
                            <h6 style="font-size: 15px; font-weight: 600; color: #b0b0b0; margin-bottom: 20px;">Baru Ditambahkan</h6>
                            
                            @php
                                // Logika Cerdas: Balik urutan dari yang paling baru masuk, lalu potong 5 saja
                                $cartReversed = array_reverse($cart, true);
                                $displayCart = array_slice($cartReversed, 0, 5, true);
                                $remaining = count($cart) - 5;
                                
                                // Panggil database sekaligus untuk 5 produk tersebut
                                $productIds = array_keys($displayCart);
                                $products = \Illuminate\Support\Facades\DB::table('products')->whereIn('id', $productIds)->get()->keyBy('id');
                            @endphp
                            
                            <div class="filter-scroll pe-2 mb-2" style="max-height: 250px; overflow-y: auto;">
                                @foreach($displayCart as $id => $details)
                                    @if(isset($products[$id]))
                                        @php $p = $products[$id]; @endphp
                                        <div class="d-flex align-items-center mb-3">
                                            <div class="bg-white rounded-3 d-flex align-items-center justify-content-center p-2 shadow-sm" style="width: 60px; height: 60px; flex-shrink: 0;">
                                                <img src="{{ asset('assets/img/'.$p->name.'.png') }}" onerror="this.src='{{ asset('assets/img/default_part.png') }}'" alt="" style="max-width: 100%; max-height: 100%; object-fit: contain;">
                                            </div>
                                            <div class="ms-3 overflow-hidden">
                                                <div class="text-white text-truncate fw-bold mb-1" style="font-size: 14px;">{{ $p->name }}</div>
                                                <div class="text-secondary small mb-1">Qty: {{ $details['quantity'] }}</div>
                                                <div class="fw-bold" style="color: #ff4d6d; font-size: 13px;">Rp {{ number_format($p->price, 0, ',', '.') }}</div>
                                            </div>
                                        </div>
                                    @endif
                                @endforeach
                            </div>
                            
                            <p class="text-center text-muted mb-4 mt-2" style="font-size: 12px; border-top: 1px solid #333; padding-top: 15px;">
                                {{ $remaining > 0 ? 'Ada ' . $remaining . ' produk lainnya di keranjang' : 'Belum ada produk lainnya' }}
                            </p>
                            
                            <div class="d-flex gap-2">
                                <a href="{{ url('cart') }}" class="btn-cart-outline flex-grow-1 text-center py-2 rounded-2 text-decoration-none" style="font-size: 13px; font-weight: 600;">Tampilkan Keranjang</a>
                                <a href="{{ url('checkout') }}" class="btn-cart-solid flex-grow-1 text-center py-2 rounded-2 text-decoration-none text-white" style="font-size: 13px; font-weight: 600;">Checkout sekarang</a>
                            </div>
                        @else
                            <div class="text-center py-4">
                                <i class="bi bi-cart-x text-muted mb-3" style="font-size: 3rem;"></i>
                                <p class="text-muted mb-0" style="font-size: 14px;">Keranjangmu masih kosong</p>
                            </div>
                        @endif
                    </div>
                    @endif
                </div>
            </div>
        </div>
    </div>

    <nav class="bg-white border-bottom">
        <!-- Tambahkan id="navbar-categories" dan position-relative di sini -->
        <div class="container d-flex py-2 align-items-center position-relative" id="navbar-categories">
            
            <a class="nav-link nav-link-custom" href="{{ url('products/category/1,2') }}">Processor/Motherboard <i class="bi bi-chevron-down ms-1" style="font-size: 10px;"></i></a>
            <a class="nav-link nav-link-custom" href="{{ url('products/category/4') }}">VGA <i class="bi bi-chevron-down ms-1" style="font-size: 10px;"></i></a>
            <a class="nav-link nav-link-custom" href="{{ url('products/category/3,5') }}">Memory & Storage <i class="bi bi-chevron-down ms-1" style="font-size: 10px;"></i></a>
            <a class="nav-link nav-link-custom" href="{{ url('products/category/6,7') }}">Power & Casing <i class="bi bi-chevron-down ms-1" style="font-size: 10px;"></i></a>
            <a class="nav-link nav-link-custom" href="{{ url('products/category/8') }}">Peripheral <i class="bi bi-chevron-down ms-1" style="font-size: 10px;"></i></a>
            
            <!-- INI DIA SANG GARIS MAGIS -->
            <div class="nav-magic-line" id="magic-line"></div>
            
            <a class="nav-link nav-link-custom ms-auto btn-pc-builder-nav d-flex align-items-center" 
               href="{{ url('builder') }}" 
               style="font-weight: 800; border: 2px solid #0d6efd; border-radius: 10px; padding: 6px 18px !important;">
                <i class="bi bi-pc-display me-2"></i> PC BUILDER
            </a>
        </div>
    </nav>
    </header>
    @show


    @yield('content')

    @section('footer')
    <footer class="footer text-center">
        <div class="container"> 
            <div class="mb-5">
                <!-- Sesuaikan path gambarnya jika diperlukan -->
                <img src="{{ asset('assets/img/Icon Logo RELASKA rounded.png') }}" alt="Relaska" class="footer-logo-main" style="filter: brightness(0) invert(1);">
                <div class="footer-brand-text">RELASKA</div>
                <div class="footer-brand-subtext">C O M P U T E R</div>
            </div>

            <div class="footer-divider"></div>

            <div class="row gy-5">
                <div class="col-md-4">
                    <h6>Features</h6>
                    <div class="d-flex flex-wrap justify-content-center">
                        <a href="#" class="footer-link">Koleksi</a>
                        <a href="#" class="footer-link">Best Seller</a>
                        <a href="#" class="footer-link">Cara Order</a>
                        <a href="#" class="footer-link">Pre-Order</a>
                    </div>
                </div>

                <div class="col-md-4">
                    <h6>Social Media</h6>
                    <div class="social-icons">
                        <i class="bi bi-facebook"></i>
                        <i class="bi bi-instagram"></i>
                        <i class="bi bi-whatsapp"></i>
                        <i class="bi bi-messenger"></i>
                    </div>
                </div>

                <div class="col-md-4">
                    <h6>Contact</h6>
                    <div class="d-flex flex-wrap justify-content-center">
                        <a href="#" class="footer-link">Tentang Kami</a>
                        <a href="#" class="footer-link">Hubungi Kami</a>
                        <a href="#" class="footer-link">FAQ</a>
                        <a href="#" class="footer-link">Kebijakan Pengembalian</a>
                    </div>
                </div>
            </div>

            <div class="footer-divider"></div>

            <p class="copyright-text">
                © 2026 RELASKA COMPUTER. All Rights Reserved. Privacy Policy | Terms & Conditions
            </p>
        </div>
    </footer>
    @show

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Tombol HTML Back to Top -->
     @unless(request()->is('login', 'register'))
    <button id="btn-back-to-top" class="btn btn-primary rounded-circle shadow-lg" 
        style="position: fixed; top: 180px; right: 30px; display: none; z-index: 1050; width: 55px; height: 55px; transition: all 0.3s ease; border: 3px solid white;">
        <i class="bi bi-chevron-up fs-4" style="line-height: 0;"></i>
    </button>
    @endunless

    <!-- Otak Interaksi UI -->
    <script>
        document.addEventListener("DOMContentLoaded", () => {

            // 1. MESIN BACK TO TOP
            const backToTopBtn = document.getElementById("btn-back-to-top");
            
            // PENGAMAN: Jalankan logika ini HANYA jika tombolnya ada di layar
            if (backToTopBtn) {
                window.addEventListener("scroll", () => {
                    if (window.scrollY > 300) {
                        backToTopBtn.style.display = "block";
                        setTimeout(() => { backToTopBtn.style.opacity = "1"; }, 10);
                    } else {
                        backToTopBtn.style.opacity = "0";
                        setTimeout(() => { backToTopBtn.style.display = "none"; }, 300);
                    }
                });
                
                backToTopBtn.addEventListener("click", () => {
                    window.scrollTo({ top: 0, behavior: "smooth" });
                });
            }

            // 2. MESIN MAGIC LINE NAVBAR
            const magicLine = document.getElementById('magic-line');
            const navLinks = document.querySelectorAll('#navbar-categories .nav-link-custom:not(.btn-pc-builder-nav)');
            let activeLink = null;
            const currentUrl = window.location.href;

            navLinks.forEach(link => {
                if (currentUrl.includes(link.getAttribute('href'))) {
                    activeLink = link;
                }
            });

            function moveLine(target) {
                if(!target) return;
                magicLine.style.width = target.offsetWidth + 'px';
                magicLine.style.left = target.offsetLeft + 'px';
                magicLine.style.opacity = 1;
            }

            if (activeLink) {
                setTimeout(() => { moveLine(activeLink); }, 100); 
            }

            navLinks.forEach(link => {
                link.addEventListener('mouseenter', (e) => { moveLine(e.target); });
                link.addEventListener('mouseleave', () => {
                    if (activeLink) { moveLine(activeLink); } 
                    else { magicLine.style.opacity = 0; }
                });
            });
        });
    </script>

    @yield('scripts')
</body>
</html>