@extends('layouts.app')

@section('title', 'RELASKA - Best Computer Store')

@section('styles')
<style>
    /* Seluruh CSS orisinal milikmu tetap utuh di sini */
    :root { 
        --dark: #1e1e1e; 
        --grey: #f8f9fa; 
        --blue: #0d6efd; 
    }
    body { font-family: 'Montserrat', sans-serif; background: white; overflow-x: hidden; }
    .hero-curve { border-radius: 0 0 20px 20px; overflow: hidden; position: relative; z-index: 10; background: #000; }
    .carousel-item img { width: 100%; height: auto; object-fit: cover; }
    .carousel-control-prev, .carousel-control-next { width: 45px; height: 45px; background: rgba(30, 30, 30, 0.8); border-radius: 50%; top: 50%; transform: translateY(-50%); opacity: 1; border: 2px solid transparent; transition: 0.3s; }
    .carousel-control-prev { left: 20px; border-color: #f5576c; }
    .carousel-control-next { right: 20px; border-color: #00f2fe; }
    .innovation-section { background: rgba(245, 247, 247, 1); padding: 55px 0 25px; margin-top: -30px; border-radius: 0 0 20px 20px; position: relative; z-index: 5; box-shadow: 0 10px 30px rgba(0,0,0,0.03); }
    .utility-bar { background: var(--dark); color: white; padding: 100px 0 80px; margin-top: -80px; border-radius: 0; position: relative; z-index: 1; font-size: 15px; }
    .marquee-container { overflow: hidden; white-space: nowrap; }
    .marquee-text { display: inline-block; animation: marquee 20s linear infinite; font-weight: 500; }
    @keyframes marquee { 0% { transform: translateX(100%); } 100% { transform: translateX(-100%); } }
    .category-section { background: white; border-radius: 20px 20px 0 0; margin-top: -60px; position: relative; z-index: 5; padding-top: 60px; }
    .cat-card { position: relative; background: #f4f7f7; border-radius: 18px; padding: 45px; height: 100%; display: flex; align-items: center; justify-content: flex-start; gap: 45px; transition: transform 0.4s ease, box-shadow 0.4s ease; cursor: pointer; overflow: hidden; border: none; z-index: 1; }
    .cat-card::before { content: ""; position: absolute; top: 0; left: 0; width: 100%; height: 100%; background-size: cover; background-position: center; opacity: 0; transition: opacity 0.5s ease; z-index: -1; }
    .cat-card:hover::before { opacity: 1; }
    .pm-card:hover::before { background-image: url('{{ asset("assets/img/cat_bg.png") }}'); }
    .vga-card:hover::before { background-image: url('{{ asset("assets/img/cat_bg.png") }}'); }
    .cat-card:hover { transform: translateY(-8px); box-shadow: 0 20px 40px rgba(0,0,0,0.12); }
    .cat-card:hover .cat-info h4, .cat-card:hover .cat-info h6, .cat-card:hover .cat-info span { color: #ffffff !important; transition: color 0.4s ease; }
    .cat-card:hover img { filter: brightness(1.1); transition: filter 0.4s ease; }
    .cat-card img { order: 1; max-width: 200px; width: 100%; flex-shrink: 0; margin-left: -30px; }
    .cat-info { order: 2; text-align: left; margin-left: -15px; padding-right: 10px; }
    .cat-card.big { min-height: 220px; }
    .cat-card.small { min-height: 140px; }
    .cat-info h4 { font-size: 26px; font-weight: 800; letter-spacing: 1.8px; margin-bottom: 16px; text-transform: uppercase; color: #2d3436; line-height: 1.1; }
    .cat-info h6 { font-size: 18px; font-weight: 800; letter-spacing: 1.5px; margin-bottom: 14px; text-transform: uppercase; color: #2d3436; }
    .vga-card .cat-info h6 { font-size: 21px; }
    .cat-info span { font-size: 14px; color: #7d7d7d; font-weight: 600; display: block; }
    .pm-card img { max-width: 300px; }
    /* =========================================
       PRICE TREND RADAR SECTION
       ========================================= */
    .radar-section { background: #0a1128 url('{{ asset("assets/img/hexagon_bg.png") }}'); background-size: cover; padding: 70px 0 120px; margin-top: 130px; border-radius: 20px 20px 0 0; position: relative; }
    .radar-section::after { content: ""; position: absolute; bottom: -1px; left: 0; width: 100%; height: 60px; background: white; border-radius: 20px 20px 0 0; }
    .radar-card {
        background: white;
        border-radius: 20px;
        padding: 20px;
        height: 100%;
        transition: transform 0.4s ease, box-shadow 0.4s ease;
        border: 2px solid transparent;
        box-shadow: 0 8px 25px rgba(0,0,0,0.04);
    }
    .radar-card:hover { 
        transform: translateY(-10px); 
        border-color: #0d6efd; 
        box-shadow: 0 15px 35px rgba(13, 110, 253, 0.2); 
    }
    .radar-img-box { background: #f8fafc; border-radius: 15px; height: 160px; display: flex; align-items: center; justify-content: center; margin-bottom: 15px; padding: 10px; }
    .radar-img-box img { max-width: 90%; max-height: 90%; object-fit: contain; }
    
    /* Gauge / Speedometer Style */
    .mini-gauge-wrapper { width: 160px; height: 80px; position: relative; overflow: hidden; margin: 15px auto 5px; }
    .mini-gauge-bg { width: 160px; height: 160px; border-radius: 50%; background: conic-gradient(from 270deg, #198754 0deg 60deg, #ffc107 60deg 120deg, #dc3545 120deg 180deg, transparent 180deg); }
    .mini-gauge-inner { width: 110px; height: 110px; background: white; border-radius: 50%; position: absolute; top: 25px; left: 25px; }
    .mini-gauge-label-l { position: absolute; bottom: 4px; left: 12px; font-size: 0.65rem; font-weight: 800; color: #1a2a3a; z-index: 20; }
    .mini-gauge-label-r { position: absolute; bottom: 4px; right: 12px; font-size: 0.65rem; font-weight: 800; color: #1a2a3a; z-index: 20; }
    .mini-gauge-needle { width: 70px; height: 4px; background: #1e293b; position: absolute; bottom: -2px; left: 10px; transform-origin: 70px center; border-radius: 4px; transition: transform 1.5s cubic-bezier(0.22, 1, 0.36, 1); }
    .mini-gauge-center {
        /* Tambahkan shadow pada titik tengah jarum agar lebih realistis */
        box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    }
    /* Tambahkan label keterangan warna statis di bawah speedometer */
    .gauge-legend {
        display: flex;
        justify-content: center;
        gap: 10px;
        font-size: 0.6rem;
        margin-top: 5px;
        color: #64748b;
    }
    .gauge-legend span::before {
        content: ''; display: inline-block; width: 8px; height: 8px; border-radius: 50%; margin-right: 4px;
    }
    .legend-buy::before { background: #198754; }
    .legend-hold::before { background: #dc3545; }

    /* Promo Section */
    .promo-section { background: #1a2a3a url('{{ asset("assets/img/hexagon_bg.png") }}'); background-size: cover; padding: 60px 0 110px; margin-top: 130px; border-radius: 60px 60px 0 0; position: relative; }
    .promo-section::after { content: ""; position: absolute; bottom: -1px; left: 0; width: 100%; height: 60px; background: white; border-radius: 60px 60px 0 0; }
    .product-card-premium { background: white; border-radius: 20px; padding: 4px; background: linear-gradient(to bottom, #D72C84 0%, #FFE100 20%, #0A97D8 80%, #008cffff 100%); height: 100%; transition: transform 0.3s ease; }
    .product-card-premium:hover { transform: translateY(-10px); }
    .product-inner { background: white; border-radius: 18px; height: 100%; padding: 15px; }
    .img-container-product { background: #f1f3f5; border-radius: 15px; height: 200px; display: flex; align-items: center; justify-content: center; margin-bottom: 15px; }
    .img-container-product img { max-width: 80%; max-height: 85%; object-fit: contain; transition: transform 0.3s ease; }
    .p-name { font-size: 15px; font-weight: 700; color: #333; height: 45px; overflow: hidden; margin-bottom: 5px; }
    .p-price { font-size: 18px; font-weight: 800; color: #000; margin-bottom: 2px; }
    .p-old-price { font-size: 12px; color: #bbb; text-decoration: line-through; }
    .p-rating { font-size: 12px; color: #777; font-weight: 600; display: flex; align-items: center; gap: 4px; }
    .p-rating i { color: #ffc107; }
    .footer-card { border-top: 1px solid #eee; padding-top: 12px; margin-top: 15px; display: flex; justify-content: space-between; align-items: center; }
    .brand-section { padding: 40px 0 30px; }
    .brand-container { display: flex; justify-content: center; align-items: center; gap: 50px; flex-wrap: wrap; }
    .brand-item img { height: 42px; transition: 0.3s; }
    .footer { background: #1e1e1e; color: white; padding: 80px 0 40px; border-radius: 20px 20px 0 0; margin-top: 100px; }
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

    /* Live Chat Widget Styling */
    #ai-chat-widget { position: fixed; bottom: 30px; right: 30px; z-index: 9999; font-family: 'Montserrat', sans-serif; }
    #chat-button { width: 60px; height: 60px; border-radius: 50%; background: #0d6efd; color: white; border: none; box-shadow: 0 5px 25px rgba(13, 110, 253, 0.4); cursor: pointer; display: flex; align-items: center; justify-content: center; transition: 0.3s; }
    #chat-button:hover { transform: scale(1.1); background: #0a58ca; }
    #chat-window { width: 350px; height: 500px; background: white; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,0,0,0.15); display: none; flex-direction: column; overflow: hidden; margin-bottom: 20px; }
    .chat-header { background: #0d6efd; color: white; padding: 15px 20px; display: flex; align-items: center; justify-content: space-between; }
    .chat-body { flex: 1; padding: 20px; overflow-y: auto; background: #f8f9fa; display: flex; flex-direction: column; gap: 10px; }
    .chat-footer { padding: 15px; border-top: 1px solid #eee; display: flex; gap: 10px; }
    .chat-input { border: 1px solid #ddd; border-radius: 20px; padding: 8px 15px; flex: 1; outline: none; font-size: 14px; }
    .chat-input:focus { border-color: #0d6efd; }
    .msg { max-width: 80%; padding: 10px 15px; border-radius: 15px; font-size: 13px; line-height: 1.4; }
    .msg-ai { background: white; align-self: flex-start; border-bottom-left-radius: 2px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
    .msg-user { background: #0d6efd; color: white; align-self: flex-end; border-bottom-right-radius: 2px; }
    .typing { font-style: italic; color: #999; font-size: 11px; }

    /* CSS KARTU PRODUK REKOMENDASI */
    .product-grid-card { background: white; border-radius: 20px; border: 1px solid #e2e8f0; padding: 20px; transition: all 0.3s ease; text-decoration: none; color: inherit; display: flex; flex-direction: column; height: 100%; box-shadow: 0 4px 6px rgba(0,0,0,0.02); }
    .product-grid-card:hover { transform: translateY(-8px); border-color: #0d6efd; box-shadow: 0 15px 35px rgba(13, 110, 253, 0.12); }
    .product-img-box { background: #f8fafc; border-radius: 15px; height: 180px; display: flex; align-items: center; justify-content: center; margin-bottom: 18px; overflow: hidden; }
    .product-img-box img { max-width: 85%; max-height: 85%; object-fit: contain; }
    .product-name { font-weight: 700; font-size: 0.95rem; color: #1e293b; height: 45px; overflow: hidden; margin-bottom: 8px; }
    .product-price { color: #0f172a; font-weight: 800; font-size: 1.2rem; }

    /* ======================================================== */
    /* 📱 RESPONSIVE KARTU RADAR REGRESI (GRID 2x2 DI HP)      */
    /* ======================================================== */
    @media (max-width: 768px) {
        /* 1. Atur jarak barisnya agar lebih merapat */
        .radar-section .row {
            margin-right: -5px !important;
            margin-left: -5px !important;
        }
        
        /* 2. Paksa kolom menjadi 50% (2 menyamping) */
        .radar-section .col-md-3 {
            flex: 0 0 50% !important;
            max-width: 50% !important;
            padding-right: 5px !important;
            padding-left: 5px !important;
            margin-bottom: 10px !important;
        }

        /* 3. Penyesuaian isi kartu agar muat dibagi 2 */
        .radar-card {
            padding: 10px !important; /* Padding kartu diperkecil */
        }
        .radar-img-box {
            height: 90px !important; /* Kotak gambar lebih ceper */
            padding: 5px !important;
            margin-bottom: 10px !important;
        }
        .radar-card .p-name {
            font-size: 10.5px !important; /* Teks nama produk dikecilkan */
            height: 30px !important; 
            line-height: 1.3 !important;
            margin-bottom: 5px !important;
        }
        .radar-card .p-price {
            font-size: 12.5px !important; 
        }
        
        /* 4. MAGIC FIX: Mengecilkan Speedometer Regresi */
        .mini-gauge-wrapper {
            transform: scale(0.55) !important; /* Susutkan speedometer jadi 55% */
            transform-origin: top center !important;
            margin-bottom: -35px !important; /* Tarik elemen di bawahnya agar ikut naik */
            margin-top: 5px !important;
        }
        
        /* 5. Kecilkan ukuran Label & Tombol */
        .radar-card .d-flex.justify-content-between { font-size: 0.55rem !important; margin-top: -5px !important; }
        .gauge-legend { font-size: 0.5rem !important; flex-wrap: wrap; justify-content: center; gap: 4px; }
        .radar-card h6 { font-size: 0.75rem !important; }
        .radar-card small { font-size: 0.6rem !important; }
        
        .radar-card .btn {
            font-size: 9.5px !important;
            padding: 5px 8px !important;
        }
    }
</style>
@endsection

@section('content')
<div class="hero-curve shadow-sm">
    <div id="heroSlider" class="carousel slide" data-bs-ride="carousel" data-bs-interval="2000">
        <div class="carousel-inner">
            @php 
            $banners = ['banner1.jpg', 'banner2.jpg', 'banner3.jpg', 'banner4.jpg', 'banner5.jpg', 'banner6.jpg', 'banner7.jpg', 'banner8.jpg'];
            @endphp
            @foreach($banners as $index => $b)
                <div class="carousel-item {{ $loop->first ? 'active' : '' }}">
                    <img src="{{ asset('assets/img/' . $b) }}" class="d-block w-100" alt="Promo RELASKA">
                </div>
            @endforeach
        </div>
        
        <button class="carousel-control-prev" data-bs-target="#heroSlider" data-bs-slide="prev">
            <i class="bi bi-chevron-left fs-4"></i>
        </button>
        <button class="carousel-control-next" data-bs-target="#heroSlider" data-bs-slide="next">
            <i class="bi bi-chevron-right fs-4"></i>
        </button>
        <div class="carousel-indicators">
            @foreach($banners as $index => $b)
                <button type="button" data-bs-target="#heroSlider" data-bs-slide-to="{{ $index }}" class="{{ $loop->first ? 'active' : '' }}"></button>
            @endforeach
        </div>
    </div>
</div>

<section class="innovation-section shadow-sm">
    <div class="container d-flex justify-content-center gap-2 gap-md-5">
        @php 
        $inovasi = [
            ['icon' => 'Protect.svg', 'title' => 'Garansi Resmi', 'desc' => 'Produk Distributor Resmi.'],
            ['icon' => 'Screwdriver.svg', 'title' => 'Panduan Rakit', 'desc' => 'Assembly Guide komprehensif.'],
            ['icon' => 'Exchange.svg', 'title' => 'Tukar Tambah', 'desc' => 'Upgrade PC lebih mudah.']
        ];
        @endphp
        @foreach($inovasi as $in)
        <div class="d-flex align-items-center gap-3 px-4">
            <img src="{{ asset('assets/icons/'.$in['icon']) }}" width="45" alt="Icon">
            <div><h6 class="fw-bold mb-0" style="font-size: 13px;">{{ $in['title'] }}</h6><small class="text-muted" style="font-size: 10px;">{{ $in['desc'] }}</small></div>
        </div>
        @endforeach
    </div>
</section>

<div class="utility-bar">
    <div class="container d-flex justify-content-between align-items-center px-4">
        <small class="opacity-75">Waktu Operasional : Senin - Sabtu 08:00 - 18:00 WIB</small>
        <i class="bi bi-megaphone-fill ps-4"></i> 
        <div class="marquee-container flex-grow-1 mx-4">
            <span class="marquee-text">Butuh Bantuan Rakit? Konsultasi Kompatibilitas GRATIS Bersama AI RELASKA!</span>
        </div>
        <button onclick="startAIConsultation()" class="btn-contact-pill bg-white text-dark px-4 py-1 rounded-pill fw-bold small border-0">
            <i class="bi bi-robot me-2"></i> Konsultasi Gratis
        </button>
    </div>
</div>

<section class="category-section">
    <div class="container"> 
        <div class="text-center mb-5">
            <h2 class="category-title fw-bold" style="letter-spacing: 2px;">KATEGORI</h2>
            <p class="text-muted small">Pilih komponen hardware yang sesuai dengan kebutuhan sistem Anda.</p>
        </div>

        <div class="row g-4">
            <div class="col-md-6">
                <a href="{{ url('products/category/1,2') }}" class="text-decoration-none">
                    <div class="cat-card big pm-card">
                        <div class="cat-info">
                            <h4>PROCESSOR &<br>MOTHERBOARD</h4>
                            <span>Temukan Lebih Banyak</span>
                        </div>
                        <img src="{{ asset('assets/img/P&M.svg') }}" alt="Processor">
                    </div>
                </a>
            </div>

            <div class="col-md-6">
                <a href="{{ url('products/category/3,5') }}" class="text-decoration-none">
                    <div class="cat-card big pm-card">
                        <div class="cat-info" style="margin-left: 30px;">
                            <h4>MEMORY &<br>STORAGE</h4>
                            <span>Temukan Lebih Banyak</span>
                        </div>
                        <img src="{{ asset('assets/img/M&S.svg') }}" alt="Memory">
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="{{ url('products/category/4') }}" class="text-decoration-none">
                    <div class="cat-card small vga-card">
                        <div class="cat-info">
                            <h6>VGA CARD</h6>
                            <span>Temukan Lebih Banyak</span>
                        </div>
                        <img src="{{ asset('assets/img/VGA.svg') }}" alt="VGA">
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="{{ url('products/category/6,7') }}" class="text-decoration-none">
                    <div class="cat-card small vga-card">
                        <div class="cat-info">
                            <h6 style="font-size: 18px;">POWER <br>& CASING</h6>
                            <span>Temukan Lebih Banyak</span>
                        </div>
                        <img src="{{ asset('assets/img/P&C.svg') }}" alt="Power">
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="{{ url('products/category/8') }}" class="text-decoration-none">
                    <div class="cat-card small vga-card">
                        <div class="cat-info" style="margin-left: -40px;">
                            <h6>PERIPHERAL</h6>
                            <span>Temukan Lebih Banyak</span>
                        </div>
                        <img src="{{ asset('assets/img/peripheral.svg') }}" alt="Peripheral">
                    </div>
                </a>
            </div>
        </div>
    </div>
</section>

<!-- ===== PRICE TREND RADAR: MARKET HIGHLIGHTS ===== -->
<section class="radar-section">
    <div class="container text-center">
        <!-- Wadah Judul Section Berupa Gambar (Sesuai Mockup) -->
        <img src="{{ asset('assets/img/logo new.png') }}" 
             alt="Price Trend Radar: Smart Buy Recommendations" 
             style="height: 140px; margin-top: -130px; position: relative; z-index: 10;" 
             class="mb-5 img-fluid">

        <div class="row g-4 text-start">
            @foreach($radarItems as $item)
            <div class="col-md-3">
                <div class="radar-card shadow">
                    <!-- Area Gambar -->
                    <div class="radar-img-box">
                        <img src="{{ asset('assets/img/'.$item['img']) }}" 
                             onerror="this.onerror=null; this.src='{{ asset('assets/img/default_part.png') }}';" 
                             alt="{{ $item['name'] }}">
                    </div>
                    
                    <!-- Info Produk -->
                    <div class="p-name text-center" title="{{ $item['name'] }}">{{ $item['name'] }}</div>
                    <div class="text-center mb-3">
                        <span class="p-price fs-5">Rp {{ $item['price'] }}</span>
                    </div>

                    <hr class="text-muted opacity-25">

                    <!-- Visualisasi Speedometer (Gauge) UX -->
                    <div class="text-center">
                        <div class="mini-gauge-wrapper">
                            <div class="mini-gauge-bg"></div>
                            <div class="mini-gauge-inner"></div>
                            <!-- Transform Rotasi Jarum berdasarkan Skor Regresi -->
                            <div class="mini-gauge-needle" style="transform: rotate({{ ($item['score'] / 100) * 180 }}deg);"></div>
                            <div class="mini-gauge-center"></div>
                        </div>
                        
                        <!-- Label Beli & Tunda dipindah ke luar lingkaran -->
                        <div class="d-flex justify-content-between px-4 mt-1" style="font-size: 0.7rem; font-weight: 800; color: #1a2a3a;">
                            <span>BELI</span>
                            <span>TUNDA</span>
                        </div>
                        
                        <div class="gauge-legend mt-2">
                            <span class="legend-buy">Waktu Beli Terbaik</span>
                            <span class="legend-hold">Rawan Kerugian</span>
                        </div>
                        
                        <div class="mt-3">
                            <h6 class="fw-bold mb-1 {{ $item['color'] }}" style="font-size: 0.85rem;">
                                {{ $item['status'] }}
                            </h6>
                            <small class="text-muted d-block" style="font-size: 0.7rem;">
                                <i class="bi bi-graph-down-arrow me-1"></i> {{ $item['desc'] }}
                            </small>
                        </div>
                    </div>
                    
                    <!-- Action Button -->
                    <div class="mt-3">
                        <a href="{{ url('product/'.$item['id']) }}" class="btn btn-sm btn-outline-primary w-100 rounded-pill fw-bold">
                            Lihat Detail
                        </a>
                    </div>
                </div>
            </div>
            @endforeach
        </div>
        
        <!-- Kesimpulan Regresi untuk User Awam -->
        <div class="mt-5 text-light opacity-75 small">
            <i class="bi bi-info-circle-fill me-1"></i> Data dianalisis secara *real-time* dari riwayat harga 6 bulan terakhir..
        </div>
    </div>
</section>

</section>

<!-- ===== SECTION REKOMENDASI PRODUK ===== -->
<section class="recommended-section container" style="margin-top: 0px; margin-bottom: 80px;">
    <div class="text-center mb-5">
        <!-- Sesuaikan nama file gambar dan ukuran height-nya dengan desainmu -->
        <img src="{{ asset('assets/img/rekomendasi_title.png') }}" alt="Rekomendasi Produk" style="height: 60px;">
    </div>

    <div class="row g-4">
        @php
            /* * OPTIMASI 1 (BACKEND): Ambil data produk
             */
            $rekomendasi = \Illuminate\Support\Facades\DB::table('products')
                ->select('id', 'name', 'price')
                ->inRandomOrder()
                ->limit(16)
                ->get();

            // MESIN REGRESI MINI: Ditanam langsung untuk menghitung tiap produk rekomendasi
            foreach ($rekomendasi as $prod) {
                $histories = \Illuminate\Support\Facades\DB::table('product_price_histories')
                    ->where('product_id', $prod->id)
                    ->orderBy('recorded_date', 'asc')
                    ->get();

                $n = count($histories);
                $slope = 0;
                
                if ($n > 1) {
                    $sumX = 0; $sumY = 0; $sumXY = 0; $sumX2 = 0;
                    $x = 1;
                    foreach ($histories as $history) {
                        $sumX += $x;
                        $sumY += $history->price;
                        $sumXY += ($x * $history->price);
                        $sumX2 += ($x * $x);
                        $x++;
                    }
                    $penyebut = ($n * $sumX2) - ($sumX * $sumX);
                    $slope = ($penyebut != 0) ? (($n * $sumXY) - ($sumX * $sumY)) / $penyebut : 0;
                }

                // Tentukan Mini Badge UI berdasarkan Slope
                if ($slope > 50000) {
                    $prod->trend_badge = '<span class="badge bg-danger text-white rounded-pill px-2 py-1" style="font-size: 0.65rem;"><i class="bi bi-graph-up-arrow"></i> Naik</span>';
                } elseif ($slope < -50000) {
                    $prod->trend_badge = '<span class="badge bg-success text-white rounded-pill px-2 py-1" style="font-size: 0.65rem;"><i class="bi bi-graph-down-arrow"></i> Turun</span>';
                } else {
                    $prod->trend_badge = '<span class="badge bg-primary text-white rounded-pill px-2 py-1" style="font-size: 0.65rem;"><i class="bi bi-dash-lg"></i> Stabil</span>';
                }
            }
        @endphp

        @foreach($rekomendasi as $p)
            <div class="col-md-3">
                <a href="{{ url('product/'.$p->id) }}" class="product-grid-card">
                    <div class="product-img-box">
                        <img src="{{ asset('assets/img/'.$p->name.'.png') }}" 
                             onerror="this.onerror=null; this.src='{{ asset('assets/img/default_part.png') }}';" 
                             alt="{{ $p->name }}">
                    </div>
                    <div class="product-name" title="{{ $p->name }}">{{ $p->name }}</div>
                    
                    <div class="d-flex justify-content-between align-items-center mt-auto pt-2 border-top">
                        <div class="product-price mb-0" style="font-size: 1.05rem;">Rp {{ number_format($p->price, 0, ',', '.') }}</div>
                        {!! $p->trend_badge ?? '' !!}
                    </div>
                </a>
            </div>
        @endforeach
    </div>

    <!-- TOMBOL LIHAT PRODUK LAINNYA -->
    <div class="text-center mt-5 pt-3">
        <a href="{{ url('products/category/all') }}" class="btn btn-outline-primary rounded-pill px-5 py-2 fw-bold" style="border-width: 2px; transition: 0.3s;">
            Lihat Produk Lainnya <i class="bi bi-arrow-right ms-2"></i>
        </a>
    </div>
</section>

<section class="brand-section container">
    <div class="brand-container">
        @php 
        $brands = ['acer.png', 'asus.png', 'tplink.png', 'lg.png', 'logitech.png', 'sandisk.png', 'samsung.png', 'toshiba.png', 'adata.png', 'intel.png', 'amd.png', 'vgen.png'];
        @endphp
        @foreach($brands as $b)
            <div class="brand-item">
                <img src="{{ asset('assets/img/brands/'.$b) }}" alt="Brand Logo">
            </div>
        @endforeach
    </div>
</section>

<!-- AI Chat Widget -->
<div id="ai-chat-widget">
    <div id="chat-window">
        <div class="chat-header">
            <div class="d-flex align-items-center">
                <i class="bi bi-robot fs-4 me-2"></i>
                <div>
                    <h6 class="mb-0 fw-bold">RELASKA KONSULTASI</h6>
                    <small style="font-size: 10px; opacity: 0.8;">Online | Konsultan PC</small>
                </div>
            </div>
            <button onclick="toggleChat()" class="btn-close btn-close-white small" style="font-size: 10px;"></button>
        </div>
        <div class="chat-body" id="chatMessages">
            <div class="msg msg-ai">Halo Customer! Ada yang bisa saya bantu terkait kebutuhan rakitan PC kamu hari ini?</div>
        </div>
        <div class="chat-footer">
            <input type="text" id="userInput" class="chat-input" placeholder="Tanya sesuatu..." onkeypress="handleKeyPress(event)">
            <button onclick="sendMessage()" class="btn btn-primary btn-sm rounded-circle"><i class="bi bi-send-fill"></i></button>
        </div>
    </div>
    <button id="chat-button" onclick="toggleChat()">
        <i class="bi bi-chat-dots-fill fs-4"></i>
    </button>
</div>
@endsection

@section('scripts')
<script>
function startAIConsultation() {
    Swal.fire({
        title: 'Halo! Saya AI RELASKA',
        text: 'Sebutkan budget atau kebutuhan rakitanmu (misal: "Budget 10 juta buat gaming")',
        input: 'text',
        inputPlaceholder: 'Ketik di sini...',
        showCancelButton: true,
        confirmButtonText: 'Analisis Sekarang',
        cancelButtonText: 'Batal',
        confirmButtonColor: '#0d6efd',
        preConfirm: (input) => {
            if (!input) {
                Swal.showValidationMessage('Tuliskan kebutuhanmu dulu ya!');
            }
            return input;
        }
    }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire({
                title: 'Sedang Menganalisis...',
                html: 'AI sedang mencocokkan hardware terbaik untukmu...',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });

            setTimeout(() => {
                let userQuery = result.value.toLowerCase();
                let aiResponse = "";

                if (userQuery.includes('gaming')) {
                    aiResponse = "Untuk <b>Gaming</b>, saya sarankan fokus pada GPU (RTX 40 Series) dan RAM minimal 16GB. Jangan lupa pakai SSD NVMe agar loading game kencang!";
                } else if (userQuery.includes('editing') || userQuery.includes('render')) {
                    aiResponse = "Untuk <b>Editing/Rendering</b>, Anda butuh Processor dengan banyak Core (seperti Ryzen 7 atau Core i7) dan RAM minimal 32GB.";
                } else if (userQuery.includes('murah') || userQuery.includes('kantor')) {
                    aiResponse = "Untuk <b>Kebutuhan Kantor</b>, i3 generasi terbaru dengan RAM 8GB sudah sangat cukup dan hemat energi.";
                } else {
                    aiResponse = "Rencana yang bagus! Saya sarankan cek menu <b>PC BUILDER</b> kami untuk memastikan semua komponen kompatibel secara teknis.";
                }

                Swal.fire({
                    title: '<i class="bi bi-robot text-primary"></i> Saran AI RELASKA',
                    html: `<div class="text-start p-2" style="font-size: 14px;">
                            "${result.value}"<br><br>
                            ${aiResponse}<br><br>
                            <hr>
                            <b>Saran Tambahan:</b> Gunakan PSU minimal 80+ Bronze untuk keamanan komponen.
                           </div>`,
                    confirmButtonText: 'Mulai Rakit Sekarang',
                    showCancelButton: true,
                    cancelButtonText: 'Tutup'
                }).then((res) => {
                    if (res.isConfirmed) {
                        window.location.href = "{{ url('builder') }}";
                    }
                });
            }, 2000);
        }
    });
}

function toggleChat() {
    const chat = document.getElementById('chat-window');
    chat.style.display = chat.style.display === 'flex' ? 'none' : 'flex';
}

function handleKeyPress(e) {
    if (e.key === 'Enter') sendMessage();
}

function appendMessage(text, sender) {
    const chatBody = document.getElementById('chatMessages');
    const msgDiv = document.createElement('div');
    msgDiv.className = `msg msg-${sender}`;
    msgDiv.innerHTML = text;
    chatBody.appendChild(msgDiv);
    chatBody.scrollTop = chatBody.scrollHeight;
}

function sendMessage() {
    const input = document.getElementById('userInput');
    const text = input.value.trim();
    if (!text) return;

    appendMessage(text, 'user');
    input.value = '';

    const typingDiv = document.createElement('div');
    typingDiv.className = 'typing mb-2';
    typingDiv.innerText = 'AI sedang mengetik...';
    document.getElementById('chatMessages').appendChild(typingDiv);

    setTimeout(() => {
        typingDiv.remove();
        let query = text.toLowerCase();
        let response = "";

        if ((query.includes('processor') || query.includes('cpu')) && (query.includes('multitasking') || query.includes('edit') || query.includes('render'))) {
            response = "Untuk multitasking berat atau editing, saya sangat sarankan <b>Intel Core i7 Gen 13/14</b> atau <b>AMD Ryzen 7 7000 Series</b>. <br><br>Kedua prosesor ini punya banyak core yang bikin buka banyak aplikasi tetap lancar jaya! 😎";
        } else if ((query.includes('processor') || query.includes('cpu')) && (query.includes('game') || query.includes('gaming'))) {
            response = "Buat gaming, <b>Intel Core i5-13600K</b> atau <b>Ryzen 5 7600X</b> sudah sangat *sweet spot*! Performa kencang tapi harga masih masuk akal.";
        } else if (query.includes('vga') || query.includes('gpu') || query.includes('kartu grafis')) {
            response = "Kalau cari VGA, seri <b>RTX 4060</b> sekarang lagi best seller buat main di 1080p rata kanan. Tapi kalau budget lebih, gas ke <b>RTX 4070</b> biar aman buat masa depan.";
        } else if (query.includes('ram') || query.includes('memory')) {
            response = "Minimal banget <b>16GB Dual Channel</b> (2x8GB) ya! Kalau sering buka Chrome banyak tab sambil main game, mending langsung 32GB aja.";
        } else if (query.includes('murah') || query.includes('budget') || query.includes('hemat')) {
            response = "Tenang, untuk budget pelajar/mahasiswa, rakitan pakai <b>Intel Core i3-12100F</b> + <b>RX 6600</b> itu udah paling juara <i>price-to-performance</i>-nya!";
        } else {
            response = "Pertanyaan menarik! Untuk detail teknis yang lebih dalam, kamu bisa coba simulasikan langsung di menu <b>PC Builder</b> kami, atau tanyakan spesifik soal komponen (misal: 'VGA apa yang bagus?').";
        }
        
        appendMessage(response, 'ai');
    }, 1500); 
}

const searchInput = document.getElementById('liveSearchInput');
const searchResults = document.getElementById('liveSearchResults');

searchInput.addEventListener('keyup', function() {
    let query = this.value.trim();

    if (query.length < 1) {
        searchResults.style.display = 'none';
        searchResults.innerHTML = '';
        return;
    }

    fetch('{{ url("home/ajaxSearch") }}?query=' + query)
    .then(response => response.json())
    .then(data => {
        let html = '';

        if (data.length > 0) {
            data.forEach(product => {
                let price = new Intl.NumberFormat('id-ID', { style: 'currency', currency: 'IDR' }).format(product.price);
                let imgUrl = '{{ asset("assets/img/") }}/' + product.name + '.png';
                let fallbackImg = '{{ asset("assets/img/default_part.png") }}'; 
                
                html += `
                    <a href="{{ url('product/') }}/${product.id}" class="search-item">
                        <img src="${imgUrl}" onerror="this.src='${fallbackImg}'">
                        <div class="search-info">
                            <h6>${product.name}</h6>
                            <span>${price}</span>
                        </div>
                    </a>
                `;
            });
            searchResults.style.display = 'block';
        } else {
            html = `
                <div class="p-3 text-center text-muted small">
                    <i class="bi bi-emoji-frown mb-1 d-block fs-5"></i>
                    Produk tidak ditemukan
                </div>
            `;
            searchResults.style.display = 'block';
        }
        searchResults.innerHTML = html;
    })
    .catch(err => console.error('Error:', err));
});

document.addEventListener('click', function(e) {
    if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) {
        searchResults.style.display = 'none';
    }
});


// ========================================================
// POP-UP KHUSUS RESPONDEN PENGUJIAN REGRESI
// ========================================================
// ========================================================
// POP-UP KHUSUS RESPONDEN PENGUJIAN REGRESI (UPDATE SCROLL)
// ========================================================
// ========================================================
// POP-UP KHUSUS RESPONDEN PENGUJIAN REGRESI (FINAL FIX SCROLL)
// ========================================================
document.addEventListener("DOMContentLoaded", function() {
    // Cek apakah pop-up sudah pernah muncul di sesi ini
    if (!sessionStorage.getItem('respondentPopupShown')) {
        
        // Kasih jeda 1 detik setelah web loading
        setTimeout(() => {
            Swal.fire({
                title: 'Selamat Datang, Responden!',
                html: 'Terima kasih telah berpartisipasi dalam pengujian sistem kami.<br><br>Fokus utama website ini adalah <b>Model Prediksi Regresi Harga Hardware (Price Trend Radar)</b>.<br><br>Apakah Anda ingin langsung diantarkan ke fitur tersebut?',
                icon: 'info',
                showCancelButton: true,
                confirmButtonText: '</i> Ya, Antar Saya Kesana!',
                cancelButtonText: 'Tidak, Biar Saya Eksplor Sendiri',
                confirmButtonColor: '#0d6efd',
                cancelButtonColor: '#6c757d',
                reverseButtons: true,
                backdrop: `rgba(0,0,0,0.6)`
            }).then((result) => {
                // Tandai bahwa pop-up sudah muncul
                sessionStorage.setItem('respondentPopupShown', 'true');
                
                // Jika Responden klik "YA"
                if (result.isConfirmed) {
                    
                    // KUNCI JAWABANNYA: Delay 400ms nunggu pop-up hilang & layar di-unlock
                    setTimeout(() => {
                        const radarSection = document.querySelector('.radar-section');
                        if(radarSection) {
                            
                            const headerOffset = 110; 
                            const elementPosition = radarSection.getBoundingClientRect().top;
                            const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
      
                            window.scrollTo({
                                 top: offsetPosition,
                                 behavior: "smooth"
                            });
                            
                            // Beri efek Glow Biru sebagai penekanan UX
                            setTimeout(() => {
                                radarSection.style.transition = "box-shadow 0.8s ease-in-out";
                                radarSection.style.boxShadow = "0 0 40px rgba(13, 110, 253, 0.6)";
                                radarSection.style.borderRadius = "60px 60px 0 0";
                                radarSection.style.zIndex = "100";
                                
                                // Hilangkan glow setelah 3 detik
                                setTimeout(() => {
                                    radarSection.style.boxShadow = "none";
                                }, 3000);
                            }, 800); // Nunggu animasi scroll selesai
                        }
                    }, 400); // Jeda 400ms disini!
                }
            });
        }, 1000);
    }
});
</script>
@endsection