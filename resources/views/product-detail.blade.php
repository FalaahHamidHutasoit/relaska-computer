@extends('layouts.app')

@section('title', 'Detail - ' . $product->name)

@section('styles')
<style>
    .content-wrapper { flex: 1; }
    .navbar-custom { background: white; border-bottom: 2px solid #0d6efd; padding: 15px 0; }
    .detail-card { background: white; border-radius: 25px; padding: 40px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); }
    .img-main-container { background: #fdfdfd; border-radius: 20px; height: 450px; display: flex; align-items: center; justify-content: center; overflow: hidden; border: 1px solid #f0f0f0; }
    .img-main-container img { max-width: 85%; max-height: 85%; object-fit: contain; transition: 0.3s; }
    .stock-tag { font-size: 0.8rem; font-weight: 700; color: #0d6efd; text-transform: uppercase; }
    .product-title { font-size: 2rem; font-weight: 800; color: #1a2a3a; margin-top: 5px; }
    .price-tag { font-size: 2.2rem; font-weight: 800; color: #000; margin: 25px 0; }
    .btn-wishlist { background: #ff007a; color: white; border: none; padding: 12px 25px; border-radius: 12px; font-weight: 600; }
    .btn-cart { background: linear-gradient(90deg, #9b4dff, #008cffff); color: white; border: none; padding: 12px 20px; border-radius: 12px; font-weight: 700; flex-grow: 1; transition: 0.3s; }
    .btn-cart:hover { transform: translateY(-3px); box-shadow: 0 5px 15px rgba(13, 110, 253, 0.3); color: white; }
    .btn-buy-now { background: linear-gradient(90deg, #ff9966, #ff5e62); color: white; border: none; padding: 12px 20px; border-radius: 12px; font-weight: 700; flex-grow: 1; transition: 0.3s; text-decoration: none; text-align: center; display: inline-flex; align-items: center; justify-content: center; }
    .btn-buy-now:hover { transform: translateY(-3px); box-shadow: 0 5px 15px rgba(255, 94, 98, 0.3); color: white; }
    .spec-table th { font-weight: 600; color: #888; width: 40%; font-size: 0.85rem; border: none; padding: 10px 0; }
    .spec-table td { font-weight: 700; color: #333; font-size: 0.85rem; border: none; padding: 10px 0; }
    /* =========================================
       CSS PRODUK SERUPA (MOCKUP STYLE)
       ========================================= */
    .similar-container { background: #ffffff; border-radius: 20px; padding: 30px; border: 1px solid #f0f0f0; }
    .similar-card { border: 1px solid #e2e8f0; border-radius: 12px; overflow: hidden; transition: 0.3s; background: #fff; display: flex; flex-direction: column; height: 100%; text-decoration: none; color: inherit; }
    .similar-card:hover { border-color: #0d6efd; box-shadow: 0 10px 20px rgba(0,0,0,0.05); transform: translateY(-5px); }
    .similar-img-box { background: #f1f3f5; height: 170px; display: flex; align-items: center; justify-content: center; padding: 15px; }
    .similar-img-box img { max-width: 90%; max-height: 90%; object-fit: contain; mix-blend-mode: multiply; }
    .similar-info { padding: 15px; flex-grow: 1; display: flex; flex-direction: column; }
    .similar-title { font-size: 13px; font-weight: 500; color: #2d3748; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; margin-bottom: 8px; line-height: 1.4; }
    .similar-price { font-size: 16px; font-weight: 800; color: #1a202c; margin-bottom: 8px; }
    .similar-stats { font-size: 11px; color: #718096; display: flex; align-items: center; gap: 4px; margin-bottom: 12px; }
    .similar-stats i { color: #ffc107; font-size: 12px;}
    .similar-store { display: flex; align-items: center; justify-content: space-between; margin-top: auto; border-top: 1px dashed #e2e8f0; padding-top: 10px; }
    .store-info { display: flex; align-items: center; gap: 6px; font-size: 10px; font-weight: 700; color: #a0aec0; text-transform: uppercase; letter-spacing: 0.5px; }
    .store-info img { height: 14px; filter: grayscale(100%); opacity: 0.8; }
</style>
@endsection

@section('content')
<div class="content-wrapper">
    <div class="container mb-5">
        <div class="detail-card">
            <div class="row g-5">
                <div class="col-md-6 text-center">
                    <div class="img-main-container shadow-sm">
                        <img id="productImage" 
                             src="{{ asset('assets/img/'.$product->name.'.png') }}" 
                             onerror="this.onerror=null; this.src='{{ asset('assets/img/default_part.png') }}';" 
                             alt="{{ $product->name }}">
                    </div>
                </div>
                
                <div class="col-md-6">
                    <span class="stock-tag">{{ ($product->stock > 0) ? 'Tersedia' : 'Habis' }}</span>
                    <h1 class="product-title">{{ $product->name }}</h1>
                    <p class="text-muted small">Kategori: <b>{{ $product->brand ?: 'RELASKA' }}</b></p>
                    
                    <h2 class="price-tag">Rp {{ number_format($product->price, 0, ',', '.') }}</h2>
                    
                    <div class="d-flex align-items-center gap-3 mb-4">
                        <div class="d-flex align-items-center border rounded-3 p-1" style="width: 120px;">
                            <button class="btn btn-link text-dark" onclick="changeQty(-1)"><i class="bi bi-dash"></i></button>
                            <input type="text" id="qty-input" value="1" class="form-control border-0 text-center bg-transparent" readonly style="font-weight: 700;">
                            <button class="btn btn-link text-dark" onclick="changeQty(1)"><i class="bi bi-plus"></i></button>
                        </div>
                        <small class="text-muted">Sisa stok: {{ $product->stock }}</small>
                    </div>

                    <div class="d-flex gap-2 mb-5">
                        <button class="btn btn-wishlist"><i class="bi bi-heart-fill"></i></button>
                        
                        <button class="btn btn-cart" id="btnAddToCart">
                            <i class="bi bi-cart-plus me-2"></i> Keranjang
                        </button>

                        <a href="{{ url('/checkout') }}" class="btn btn-buy-now" id="btnBuyNow">
                            Beli Sekarang <i class="bi bi-arrow-right ms-2"></i>
                        </a>
                    </div>

                    <h6 class="fw-bold mb-3 border-bottom pb-2">Spesifikasi Utama</h6>
                    
                    <!-- TABEL ADAPTIF: Menyesuaikan kolom dengan Kategori Produk -->
                    <table class="table spec-table mb-4">
                        <tr><th>BRAND</th><td>{{ $product->brand ?: 'Tidak ada keterangan' }}</td></tr>
                        
                        <!-- Logika Form Factor (Mobo & Casing) -->
                        @if(in_array($product->category_id, [2, 7]) && $product->form_factor)
                        <tr><th>FORM FACTOR</th><td>{{ $product->form_factor }}</td></tr>
                        @endif

                        <!-- Logika Socket (Processor & Mobo) -->
                        @if(in_array($product->category_id, [1, 2]) && $product->socket_type)
                        <tr><th>SOCKET TYPE</th><td>{{ $product->socket_type }}</td></tr>
                        @endif

                        <!-- Logika Memory Type (Mobo & RAM) -->
                        @if(in_array($product->category_id, [2, 3]) && $product->memory_type)
                        <tr><th>MEMORY TYPE</th><td>{{ $product->memory_type }}</td></tr>
                        @endif

                        <!-- Logika Capacity (RAM, Storage, VGA VRAM) -->
                        @if(in_array($product->category_id, [3, 4, 5]) && $product->capacity)
                        <tr>
                            <th>KAPASITAS</th>
                            <td>
                                @if($product->category_id == 5 && $product->capacity >= 1000)
                                    {{ $product->capacity / 1000 }} TB
                                @else
                                    {{ $product->capacity }} GB
                                @endif
                            </td>
                        </tr>
                        @endif

                        <!-- Logika Wattage / TDP (VGA & PSU) -->
                        @if(in_array($product->category_id, [4, 6]) && $product->wattage)
                        <tr><th>{{ $product->category_id == 6 ? 'DAYA OUTPUT' : 'TDP / KONSUMSI DAYA' }}</th><td>{{ $product->wattage }} W</td></tr>
                        @endif
                        
                        <tr><th>TIER PERFORMANCE</th><td>
                            <span class="badge bg-dark text-white">Tier {{ $product->tier }}</span>
                        </td></tr>
                    </table>

                    <!-- AREA DESKRIPSI (TEMPAT ADMIN MENGETIK SPESIFIKASI DETAIL SEPERTI DI GAMBAR) -->
                    <h6 class="fw-bold mb-3 border-bottom pb-2">Deskripsi & Detail Spesifikasi</h6>
                    <div class="product-description text-muted small" style="line-height: 1.6;">
                        @if($product->description)
                            {!! nl2br(e($product->description)) !!}
                        @else
                            <i>Detail spesifikasi belum ditambahkan oleh admin.</i>
                        @endif
                    </div>
                </div>
            </div>
        </div>
        <!-- =========================================
             SECTION PRODUK SERUPA
             ========================================= -->
        <h4 class="fw-bold mt-5 mb-4" style="color: #1a2a3a;">Produk Serupa</h4>
        
        <div class="similar-container shadow-sm mb-5">
            <div class="row g-4" id="similar-product-grid">
                
                @php
                    /* Logika Mandiri: Mengambil produk dengan kategori yang sama (kecuali produk ini sendiri) */
                    $similar_products = \Illuminate\Support\Facades\DB::table('products')
                        ->where('category_id', $product->category_id)
                        ->where('id', '!=', $product->id)
                        ->paginate(4); // Memuat 4 data per halaman scroll
                @endphp

                @foreach($similar_products as $sp)
                <div class="col-lg-3 col-md-4 col-6 similar-item-wrapper">
                    <a href="{{ url('product/'.$sp->id) }}" class="similar-card">
                        <div class="similar-img-box">
                            <img src="{{ asset('assets/img/'.$sp->name.'.png') }}" 
                                 onerror="this.onerror=null; this.src='{{ asset('assets/img/default_part.png') }}';" 
                                 alt="{{ $sp->name }}">
                        </div>
                        <div class="similar-info">
                            <div class="similar-title">{{ $sp->name }}</div>
                            <div class="similar-price">Rp {{ number_format($sp->price, 0, ',', '.') }}</div>
                            
                            <!-- Angka rating dan terjual dibuat random/statis sementara sesuai mockup -->
                            <div class="similar-stats">
                                <i class="bi bi-star-fill"></i> 4.8 - {{ rand(10, 50) }} terjual
                            </div>
                            
                            <div class="similar-store">
                                <div class="store-info">
                                    <img src="{{ asset('assets/img/Icon Logo RELASKA rounded.png') }}" alt="Logo">
                                    RELASKA COMPUTER
                                </div>
                                <i class="bi bi-three-dots text-muted"></i>
                            </div>
                        </div>
                    </a>
                </div>
                @endforeach
                
            </div>
            
            <!-- Animasi Loading & Teks Penutup -->
            <div id="similar-loading-spinner" class="text-center mt-5 mb-3" style="display: none;">
                <div class="spinner-border text-primary" role="status" style="width: 1.5rem; height: 1.5rem;"></div>
                <p class="text-muted mt-2 small fw-bold">Memuat produk serupa...</p>
            </div>
            <div id="similar-no-more" class="text-center text-muted small fw-bold mt-5 mb-3" style="display: none; letter-spacing: 1px;">
                — Semua produk serupa telah ditampilkan —
            </div>
            
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script>
    function changeQty(val) {
        let input = document.getElementById('qty-input');
        let current = parseInt(input.value);
        if (current + val >= 1 && current + val <= {{ $product->stock }}) {
            input.value = current + val;
        }
    }

    document.getElementById('btnBuyNow').addEventListener('click', function(e) {
    e.preventDefault(); // Tahan dulu biar gak langsung pindah halaman

    const isLoggedIn = {{ session('logged_in') ? 'true' : 'false' }};
    if (!isLoggedIn) {
        Swal.fire({
            icon: 'warning',
            title: 'Oopss... Belum Login!',
            text: 'Kamu harus login dulu untuk melanjutkan pembayaran.',
            confirmButtonText: 'Login & Lanjut Bayar',
            confirmButtonColor: '#0d6efd',
            showCancelButton: true,
            cancelButtonText: 'Nanti Saja'
        }).then((result) => {
            if (result.isConfirmed) {
                const tujuan = "{{ url('product/'.$product->id) }}";
                window.location.href = "{{ url('login') }}?redirect=" + encodeURIComponent(tujuan);
            }
        });
        return; // Hentikan eksekusi di sini kalau belum login
    }

    // 1. Tampilkan loading biar user tau sistem lagi mikir
    Swal.fire({
        title: 'Mempersiapkan Checkout...',
        text: 'Mohon tunggu sebentar ya.',
        allowOutsideClick: false,
        didOpen: () => { Swal.showLoading() }
    });

    // 2. Siapkan data produk untuk diselundupkan ke keranjang
    const prodId = "{{ $product->id }}";
    const qty = document.getElementById('qty-input').value;
    let formData = new FormData();
    formData.append('product_id', prodId);
    formData.append('quantity', qty);
    formData.append('_token', '{{ csrf_token() }}');

    // 3. Masukkan ke keranjang diam-diam via AJAX
    fetch('{{ url("cart/buy-now") }}', { 
        method: 'POST', 
        body: formData, 
        headers: { "X-Requested-With": "XMLHttpRequest" } 
    })
    .then(res => res.json())
    .then(data => {
        if(data.status === 'success') {
            // LEMPAR KE CHECKOUT DENGAN MEMBAWA KARTU VIP "?mode=buynow"
            window.location.href = "{{ url('checkout') }}?mode=buynow";
        } else {
            Swal.fire('Gagal', 'Terjadi kesalahan sistem.', 'error');
        }
    })
    .catch(err => {
        Swal.fire('Error Jaringan', 'Gagal memproses permintaan.', 'error');
    });
});

    document.getElementById('btnAddToCart').addEventListener('click', function() {
        const isLoggedIn = {{ session('logged_in') ? 'true' : 'false' }};
        if (!isLoggedIn) {
            Swal.fire({
                icon: 'warning', title: 'Belum Login!', text: 'Silakan login untuk memasukkan barang ke keranjang.', confirmButtonText: 'Login', confirmButtonColor: '#0d6efd'
            }).then((res) => {
                if(res.isConfirmed) {
                    const currentUrl = window.location.href;
                    window.location.href = "{{ url('login') }}?redirect=" + encodeURIComponent(currentUrl);
                }
            });
            return;
        }

        const prodId = "{{ $product->id }}";
        const qty = document.getElementById('qty-input').value;
        const imgUrl = document.getElementById('productImage').src;
        let formData = new FormData();
        formData.append('product_id', prodId);
        formData.append('quantity', qty);
        formData.append('_token', '{{ csrf_token() }}');

        // 1. FUNGSI ILUSI OPTIK (ANIMASI TERBANG)
        function flyToCart(imgElement, cartElement, callback) {
            // Kloning gambar produk
            const imgClone = imgElement.cloneNode(true);
            const imgRect = imgElement.getBoundingClientRect();
            const cartRect = cartElement.getBoundingClientRect();

            // Atur gaya kloningan agar melayang di atas segalanya
            imgClone.style.position = 'fixed';
            imgClone.style.top = imgRect.top + 'px';
            imgClone.style.left = imgRect.left + 'px';
            imgClone.style.width = imgRect.width + 'px';
            imgClone.style.height = imgRect.height + 'px';
            imgClone.style.objectFit = 'contain';
            imgClone.style.zIndex = '9999';
            // Transisi kurva melengkung yang natural
            imgClone.style.transition = 'all 0.8s cubic-bezier(0.25, 0.8, 0.25, 1)'; 

            document.body.appendChild(imgClone);

            // Trigger reflow mesin browser
            imgClone.offsetHeight;

            // Beri kordinat tujuan (menuju Navbar)
            imgClone.style.top = cartRect.top + 'px';
            imgClone.style.left = cartRect.left + 'px';
            imgClone.style.width = '20px';
            imgClone.style.height = '20px';
            imgClone.style.opacity = '0'; // Menghilang perlahan saat sampai

            // Hapus gambar setelah sampai, lalu jalankan popup
            setTimeout(() => {
                imgClone.remove();
                
                // Efek ikon keranjang meloncat bahagia (bounce)
                cartElement.style.transform = 'scale(1.3)';
                setTimeout(() => { cartElement.style.transform = 'scale(1)'; }, 200);
                
                if(callback) callback();
            }, 800);
        }

        // 2. PROSES BACKEND & EKSEKUSI
        fetch('{{ url("cart/add") }}', { method: 'POST', body: formData, headers: { "X-Requested-With": "XMLHttpRequest" } })
        .then(res => res.json())
        .then(data => {
            if(data.status === 'success') {
                const productImage = document.getElementById('productImage');
                const cartIcon = document.getElementById('navbar-cart-icon'); 
                
                // Panggil pesawat kertasnya!
                flyToCart(productImage, cartIcon, () => {
                    // Update angka di navbar setelah gambar masuk
                    document.getElementById('cart-count').innerText = data.cart_count;
                    
                    // ========================================================
                    // TRIK EKSTRAKSI: UPDATE DROPDOWN SECARA DIAM-DIAM (SILENT)
                    // ========================================================
                    fetch(window.location.href)
                    .then(response => response.text())
                    .then(html => {
                        const parser = new DOMParser();
                        const doc = parser.parseFromString(html, 'text/html');
                        
                        // 1. Potong isi dropdown baru dan timpa ke dropdown lama
                        const newDropdown = doc.querySelector('.cart-dropdown-menu');
                        const currentDropdown = document.querySelector('.cart-dropdown-menu');
                        if (newDropdown && currentDropdown) {
                            currentDropdown.innerHTML = newDropdown.innerHTML;
                        }
                        
                        // 2. Nyalakan titik merah notifikasi jika keranjang tadinya kosong
                        if (!document.getElementById('cart-dot')) {
                            const dot = document.createElement('div');
                            dot.className = 'cart-indicator';
                            dot.id = 'cart-dot';
                            cartIcon.appendChild(dot);
                        }
                    });
                    
                    // Baru munculkan SweetAlert setelah semua sulap visual selesai
                    Swal.fire({
                        title: 'Berhasil Masuk Keranjang!', 
                        text: qty + ' unit {{ $product->name }} sudah ditambahkan.', 
                        imageUrl: imgUrl, 
                        imageWidth: 200, 
                        imageHeight: 200, 
                        showCancelButton: true, 
                        confirmButtonColor: '#0d6efd', 
                        confirmButtonText: '<i class="bi bi-cart-check"></i> Lihat Keranjang', 
                        cancelButtonText: 'Lanjut Belanja'
                    }).then((result) => {
                        if (result.isConfirmed) window.location.href = "{{ url('cart') }}";
                    });
                });
                
            } else { Swal.fire('Gagal', 'Gagal menambahkan barang', 'error'); }
        });
    });

    // ==========================================
    // MESIN INFINITE SCROLL PRODUK SERUPA
    // ==========================================
    let similarPage = 1;
    let isSimilarLoading = false;
    let hasMoreSimilar = {{ $similar_products->hasMorePages() ? 'true' : 'false' }};
    const similarGrid = document.getElementById('similar-product-grid');
    const similarLoading = document.getElementById('similar-loading-spinner');
    const similarNoMore = document.getElementById('similar-no-more');

    if (!hasMoreSimilar && {{ $similar_products->count() > 0 ? 'true' : 'false' }}) {
        similarNoMore.style.display = 'block';
    }

    window.addEventListener('scroll', () => {
        // Memicu pencarian data saat jarak scroll tersisa 600px dari bawah
        if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 600) {
            if (!isSimilarLoading && hasMoreSimilar) {
                loadMoreSimilarProducts();
            }
        }
    });

    function loadMoreSimilarProducts() {
        isSimilarLoading = true;
        similarPage++;
        similarLoading.style.display = 'block';

        let url = window.location.href;
        let sep = url.includes('?') ? '&' : '?';
        // Memaksa parameter page masuk ke URL untuk Pagination Laravel
        let fetchUrl = url + sep + 'page=' + similarPage;

        fetch(fetchUrl)
        .then(response => response.text())
        .then(html => {
            // TEKNIK EKSTRAKSI FRONTEND
            // Kita ubah HTML panjang yang dibalas server menjadi objek DOM
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');
            
            // Kita "potong" bagian grid produk serupa saja dari HTML tersebut
            const newGrid = doc.getElementById('similar-product-grid');
            
            // Periksa apakah di dalam potongan tersebut ada kartu produknya
            const newItems = newGrid ? newGrid.querySelectorAll('.similar-item-wrapper') : [];

            if (newItems.length === 0) {
                hasMoreSimilar = false; 
                similarLoading.style.display = 'none';
                similarNoMore.style.display = 'block'; 
                return;
            }
            
            // Jika ada, pindahkan kartu-kartu baru itu ke grid halaman kita saat ini
            newItems.forEach(item => {
                similarGrid.appendChild(item);
            });
            
            isSimilarLoading = false;
            similarLoading.style.display = 'none';
        })
        .catch(err => {
            console.error(err);
            isSimilarLoading = false;
            similarLoading.style.display = 'none';
        });
    }
</script>
@endsection