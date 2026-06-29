@extends('layouts.app')

@section('title', 'Katalog - ' . $title)

@section('styles')
<style>
    /* CSS Orisinal Kategori RELASKA Milik Raka */
    body { background-color: #f0f2f5; color: #1e293b; }
    .filter-section { background: white; border-radius: 20px; padding: 25px; box-shadow: 0 10px 30px rgba(0,0,0,0.08); }
    .filter-title { font-weight: 800; color: #0f172a; margin-bottom: 20px; font-size: 1.1rem; }
    .filter-subtitle { font-weight: 700; color: #334155; font-size: 0.9rem; margin-bottom: 15px; }
    .form-check-label { color: #1e293b; font-weight: 600; cursor: pointer; }
    .product-grid-card { background: white; border-radius: 20px; border: 1px solid #e2e8f0; padding: 20px; transition: all 0.3s ease; text-decoration: none; color: inherit; display: flex; flex-direction: column; height: 100%; }
    .product-grid-card:hover { transform: translateY(-8px); border-color: #0d6efd; box-shadow: 0 15px 35px rgba(13, 110, 253, 0.12); }
    .product-img-box { background: #f8fafc; border-radius: 15px; height: 180px; display: flex; align-items: center; justify-content: center; margin-bottom: 18px; overflow: hidden; }
    .product-img-box img { max-width: 85%; max-height: 85%; object-fit: contain; }
    .product-name { font-weight: 700; font-size: 0.95rem; color: #1e293b; height: 45px; overflow: hidden; margin-bottom: 8px; }
    .product-price { color: #0f172a; font-weight: 800; font-size: 1.3rem; }
</style>
@endsection

@section('content')
<div class="container pb-5 mt-5">
    
    @if(in_array('all', $selected_cats))
        <div class="text-center mb-5">
            <h2 class="fw-bold">Rekomendasi Produk RELASKA</h2>
            <p class="text-muted">Jelajahi seluruh komponen PC dari berbagai merek ternama untuk rakitan impianmu.</p>
        </div>
    @endif

    <div class="row g-4">
        
        @if(!in_array('all', $selected_cats))
        <div class="col-md-3">
            <div class="filter-section position-sticky shadow-sm p-4 filter-scroll" style="top: 180px; z-index: 1010; background: white; border-radius: 20px; border: 1px solid #f0f0f0; max-height: calc(100vh - 200px); overflow-y: auto;">
                <h5 class="fw-bold mb-4" style="letter-spacing: 0.5px;">Filter Spesifikasi</h5>
                
                <form action="{{ url()->current() }}" method="GET" id="filterForm">
                    
                    <div class="mb-4">
                        <h6 class="fw-bold mb-3 small text-muted text-uppercase" style="letter-spacing: 1px;">Brand</h6>
                        <div class="filter-scroll pe-2" style="max-height: 160px; overflow-y: auto;">
                            @php
                                // Otak AI: Mengumpulkan brand berdasarkan kategori yang sedang aktif
                                $brands = [];
                                if(isset($selected_cats)) {
                                    if(in_array(1, $selected_cats)) $brands = array_merge($brands, ['AMD', 'Intel']);
                                    if(in_array(2, $selected_cats)) $brands = array_merge($brands, ['Asus', 'MSI', 'Gigabyte', 'ASRock', 'Biostar']);
                                    if(in_array(3, $selected_cats)) $brands = array_merge($brands, ['Corsair', 'G.Skill', 'Kingston', 'TeamGroup', 'Adata', 'Crucial', 'PNY', 'Patriot']);
                                    if(in_array(4, $selected_cats)) $brands = array_merge($brands, ['Nvidia', 'AMD', 'Intel']);
                                    if(in_array(5, $selected_cats)) $brands = array_merge($brands, ['Samsung', 'WD', 'Seagate', 'Crucial', 'Adata', 'Lexar', 'Kingston']);
                                    if(in_array(6, $selected_cats)) $brands = array_merge($brands, ['Corsair', 'Seasonic', 'FSP', 'Cooler Master', 'Deepcool', 'MSI', 'Asus']);
                                    if(in_array(7, $selected_cats)) $brands = array_merge($brands, ['NZXT', 'Lian Li', 'Corsair', 'Phanteks', 'Cooler Master', 'Deepcool', 'Paradox', 'Cube', 'DarkFlash']);
                                    if(in_array(8, $selected_cats)) $brands = array_merge($brands, ['Noctua', 'Deepcool', 'NZXT', 'Corsair', 'Thermalright', 'ID-Cooling', 'Arctic']);
                                    
                                    $brands = array_unique($brands); // Membuang brand yang duplikat
                                }
                                
                                // Jika di halaman "all" atau kategori kosong, tampilkan top brands global
                                if(empty($brands) || (isset($selected_cats) && in_array('all', $selected_cats))) {
                                    $brands = ['Asus', 'MSI', 'Gigabyte', 'AMD', 'Intel', 'Nvidia', 'Corsair', 'Samsung', 'Deepcool', 'NZXT'];
                                }
                                
                                sort($brands); // Urutkan sesuai abjad A-Z
                            @endphp
                            
                            @foreach($brands as $brand)
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="checkbox" name="brand[]" value="{{ $brand }}" id="brand_{{ $brand }}" 
                                    {{ (is_array(request('brand')) && in_array($brand, request('brand'))) ? 'checked' : '' }}
                                    style="cursor: pointer;">
                                <label class="form-check-label small fw-medium" for="brand_{{ $brand }}" style="cursor: pointer;">{{ $brand }}</label>
                            </div>
                            @endforeach
                        </div>
                    </div>

                    @if(isset($selected_cats) && (in_array(1, $selected_cats) || in_array(2, $selected_cats) || in_array('all', $selected_cats)))
                    <div class="mb-4">
                        <h6 class="fw-bold mb-3 small text-muted text-uppercase" style="letter-spacing: 1px;">Socket Type</h6>
                        @foreach(['AM4', 'AM5', 'LGA1700'] as $socket)
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" name="socket[]" value="{{ $socket }}" id="socket_{{ $socket }}"
                                {{ (is_array(request('socket')) && in_array($socket, request('socket'))) ? 'checked' : '' }}>
                            <label class="form-check-label small fw-medium" for="socket_{{ $socket }}">{{ $socket }}</label>
                        </div>
                        @endforeach
                    </div>
                    @endif

                    @if(isset($selected_cats) && (in_array(2, $selected_cats) || in_array(3, $selected_cats) || in_array('all', $selected_cats)))
                    <div class="mb-4">
                        <h6 class="fw-bold mb-3 small text-muted text-uppercase" style="letter-spacing: 1px;">Memory Type</h6>
                        @foreach(['DDR4', 'DDR5'] as $ram)
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" name="memory[]" value="{{ $ram }}" id="mem_{{ $ram }}"
                                {{ (is_array(request('memory')) && in_array($ram, request('memory'))) ? 'checked' : '' }}>
                            <label class="form-check-label small fw-medium" for="mem_{{ $ram }}">{{ $ram }}</label>
                        </div>
                        @endforeach
                    </div>
                    @endif

                    @if(isset($selected_cats) && (in_array(2, $selected_cats) || in_array(7, $selected_cats) || in_array('all', $selected_cats)))
                    <div class="mb-4">
                        <h6 class="fw-bold mb-3 small text-muted text-uppercase" style="letter-spacing: 1px;">Form Factor</h6>
                        @foreach(['ATX', 'M-ATX', 'E-ATX'] as $ff)
                        <div class="form-check mb-2">
                            <input class="form-check-input" type="checkbox" name="form_factor[]" value="{{ $ff }}" id="ff_{{ $ff }}"
                                {{ (is_array(request('form_factor')) && in_array($ff, request('form_factor'))) ? 'checked' : '' }}>
                            <label class="form-check-label small fw-medium" for="ff_{{ $ff }}">{{ $ff }}</label>
                        </div>
                        @endforeach
                    </div>
                    @endif

                    <a href="{{ url()->current() }}" class="btn btn-light w-100 rounded-pill small text-muted py-2 fw-bold" style="border: 1px solid #ddd;">Reset Filter</a>
                </form>
            </div>
        </div>
        @endif

        <div class="{{ in_array('all', $selected_cats) ? 'col-12' : 'col-md-9' }}">
            @if(!in_array('all', $selected_cats))
                <h5 class="fw-bold mb-4">Koleksi Terpilih : {{ $title }}</h5>
            @endif
            
            <div class="row g-4" id="product-grid">
                @if($products->isEmpty())
                    <div class="col-12 text-center py-5">
                        <i class="bi bi-box-seam text-muted" style="font-size: 3rem;"></i>
                        <p class="text-muted mt-3 fw-bold">Belum ada produk untuk filter ini.</p>
                    </div>
                @else
                    @include('product_cards')
                @endif
            </div>

            <div id="loading-spinner" class="text-center my-5 pb-5" style="display: none; min-height: 300px;">
                <div class="spinner-border text-primary" role="status" style="width: 2rem; height: 2rem;">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <p class="text-muted mt-2 small fw-bold">Memuat produk lainnya...</p>
            </div>

            <div id="no-more-products" class="text-center text-muted small fw-bold my-5" style="display: none; letter-spacing: 1px;">
                — Semua produk telah ditampilkan —
            </div>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script>
    // ==========================================
    // 1. MESIN INFINITE SCROLL (MEMUAT PRODUK)
    // ==========================================
    let page = 1;
    let isLoading = false;
    let hasMoreData = {{ $products->hasMorePages() ? 'true' : 'false' }};
    const noMoreProducts = document.getElementById('no-more-products');

    // Cerdas: Jika dari awal produknya memang sedikit dan tidak ada halaman 2, langsung tampilkan teksnya
    if (!hasMoreData && {{ $products->count() > 0 ? 'true' : 'false' }}) {
        noMoreProducts.style.display = 'block';
    }

    window.addEventListener('scroll', () => {
        // UBAH RADIUS PEMICU: Dari 200 menjadi 800 agar memuat SEBELUM footer kelihatan
        if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 800) {
            if (!isLoading && hasMoreData) {
                loadMoreProducts();
            }
        }
    });

    function loadMoreProducts() {
        isLoading = true;
        page++;
        document.getElementById('loading-spinner').style.display = 'block';

        let url = window.location.href;
        let sep = url.includes('?') ? '&' : '?';
        let fetchUrl = url + sep + 'page=' + page;

        fetch(fetchUrl, {
            headers: { "X-Requested-With": "XMLHttpRequest" }
        })
        .then(response => response.text())
        .then(html => {
            // Jika backend membalas dengan kosong (artinya data habis)
            if (html.trim() === '') {
                hasMoreData = false; 
                document.getElementById('loading-spinner').style.display = 'none';
                
                // MUNCULKAN TEKS PENUTUP DI SINI
                noMoreProducts.style.display = 'block'; 
                return;
            }
            
            // Jika data masih ada, susun ke dalam grid
            document.getElementById('product-grid').insertAdjacentHTML('beforeend', html);
            isLoading = false;
            document.getElementById('loading-spinner').style.display = 'none';
        })
        .catch(err => console.error(err));
    }

    // ==========================================
    // 2. MESIN AUTO-APPLY FILTER SPESIFIKASI
    // ==========================================
    document.addEventListener("DOMContentLoaded", () => {
        const filterCheckboxes = document.querySelectorAll('#filterForm .form-check-input');
        filterCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', () => {
                // Begitu ada checkbox yang diklik, langsung submit formnya otomatis!
                document.getElementById('filterForm').submit();
            });
        });
    });
</script>
@endsection