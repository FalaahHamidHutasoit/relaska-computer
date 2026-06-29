@extends('layouts.app')

@section('title', 'Checkout Pesanan - RELASKA')

@section('styles')
<!-- Import CSS Leaflet JS untuk Peta -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<link rel="stylesheet" href="https://unpkg.com/leaflet-control-geocoder/dist/Control.Geocoder.css" />

<style>
    /* =========================================
       1. PENGATURAN TEMA DASAR
       ========================================= */
    body { background-color: #f8f9fa; }
    .checkout-container { margin-top: 40px; margin-bottom: 80px; }
    
    .section-title { font-size: 18px; font-weight: 800; color: #1a2a3a; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
    .section-title i { color: #0A97D8; font-size: 22px; }
    
    .checkout-card { background: #fff; border-radius: 20px; padding: 30px; border: 1px solid #f0f0f0; margin-bottom: 25px; box-shadow: 0 4px 15px rgba(0,0,0,0.02); }

    /* =========================================
       2. UI ALAMAT PENGIRIMAN (PROFIL VS PETA)
       ========================================= */
    /* Tab Navigasi Alamat */
    .address-tab-btn { border-radius: 50px; font-weight: 600; padding: 10px 25px; transition: 0.3s; border: 1px solid #dee2e6; color: #6c757d; background: #fff; font-size: 14px; margin-right: 10px; cursor: pointer; }
    .address-tab-btn.active { background: #0A97D8; color: white; border-color: #0A97D8; box-shadow: 0 4px 10px rgba(10, 151, 216, 0.2); }
    
    /* Kotak Alamat Default (Dari Profil) */
    .profile-address-box { border: 2px solid #0A97D8; border-radius: 15px; padding: 20px; background: #f0faff; position: relative; overflow: hidden; }
    .profile-address-box::before { content: 'Alamat Profil (Utama)'; position: absolute; top: 0; right: 0; background: #0A97D8; color: white; font-size: 11px; font-weight: bold; padding: 5px 15px; border-bottom-left-radius: 15px; }
    
    /* Kanvas Peta Leaflet */
    #map-container { height: 350px; border-radius: 12px; border: 1px solid #eaeaea; z-index: 1; margin-top: 15px; }
    .map-feedback { background: #e8f5e9; border: 1px solid #c8e6c9; color: #2e7d32; border-radius: 10px; padding: 12px; font-size: 13px; margin-top: 15px; display: none; }

    /* =========================================
       3. UI OPSI PEMBAYARAN (SESUAI SCREENSHOT)
       ========================================= */
    .payment-category-title { font-size: 13px; font-weight: 800; color: #495057; margin-top: 25px; margin-bottom: 12px; text-transform: uppercase; letter-spacing: 0.5px; }
    
    .payment-option input[type="radio"] { display: none; } /* Sembunyikan radio bawaan browser */
    
    .payment-card { border: 1px solid #dee2e6; border-radius: 12px; padding: 14px 18px; cursor: pointer; transition: 0.2s; display: flex; align-items: center; background: #fff; gap: 15px; }
    .payment-card img { height: 24px; width: 60px; object-fit: contain; object-position: left; }
    .payment-card span { font-weight: 600; font-size: 14px; color: #212529; }
    
    /* Efek visual ketika E-Wallet atau Bank dipilih */
    .payment-option input[type="radio"]:checked + .payment-card { border-color: #0A97D8; border-width: 2px; background: #f8fcff; padding: 13px 17px; /* Kompensasi border */ }

    /* =========================================
       4. RINGKASAN PESANAN & TOMBOL AJAX
       ========================================= */
    .summary-card { background: #fff; border-radius: 20px; padding: 30px; border: 1px solid #f0f0f0; position: sticky; top: 140px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
    .summary-row { display: flex; justify-content: space-between; margin-bottom: 12px; color: #6c757d; font-size: 14px; }
    .summary-total { display: flex; justify-content: space-between; margin-top: 20px; padding-top: 20px; border-top: 2px dashed #eee; font-size: 18px; font-weight: 800; color: #1a2a3a; }
    
    /* Tombol Checkout Ajax */
    .btn-pay { background: linear-gradient(90deg, #D72C84 0%, #0A97D8 100%); color: white; border: none; border-radius: 12px; padding: 16px; font-weight: 700; font-size: 16px; width: 100%; transition: 0.3s; margin-top: 25px; display: flex; justify-content: center; align-items: center; gap: 10px; }
    .btn-pay:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(10, 151, 216, 0.3); color: white; filter: brightness(1.1); }
    .btn-pay:disabled { opacity: 0.7; cursor: not-allowed; transform: none; box-shadow: none; }
</style>
@endsection

@section('content')
<div class="container checkout-container">
    <a href="{{ url('cart') }}" class="text-decoration-none text-muted mb-4 d-inline-block fw-bold small">
        <i class="bi bi-arrow-left me-1"></i> Kembali ke Keranjang
    </a>
    <h3 class="fw-bold mb-4" style="color: #1a2a3a;">Checkout Pesanan</h3>

    <form id="checkout-form">
        @csrf
        <input type="hidden" name="address_type" id="input_address_type" value="{{ session('address') ? 'profile' : 'map' }}">
        <input type="hidden" name="map_lat" id="input_map_lat" value="">
        <input type="hidden" name="map_lng" id="input_map_lng" value="">
        <input type="hidden" name="map_address_text" id="input_map_address_text" value="">

        <div class="row g-4">
            <div class="col-lg-8">
                
                <div class="checkout-card">
                    <div class="section-title"><i class="bi bi-geo-alt-fill"></i> Alamat Pengiriman</div>
                    
                    @if(session('address') && session('address') != '')
                        <div class="d-flex mb-4 border-bottom pb-3 overflow-auto">
                            <button type="button" class="address-tab-btn active" id="tab-profile">
                                <i class="bi bi-person-lines-fill me-2"></i> Gunakan Alamat Profil
                            </button>
                            <button type="button" class="address-tab-btn" id="tab-map">
                                <i class="bi bi-map-fill me-2"></i> Pilih Titik di Peta
                            </button>
                        </div>

                        <div id="area-profile-address">
                            <div class="profile-address-box shadow-sm">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h6 class="fw-bold mb-0 text-dark">{{ session('fullname') }}</h6>
                                </div>
                                <p class="text-muted mb-1 small fw-bold">{{ session('phone') }}</p>
                                <p class="text-muted small mb-0" style="line-height: 1.5;">
                                    {{ session('address') }}
                                </p>
                            </div>
                        </div>
                    @endif

                    <div id="area-map-address" style="display: {{ session('address') ? 'none' : 'block' }};">
                        <label class="form-label fw-bold small text-muted">Cari Lokasi Pengiriman</label>
                        <div class="input-group mb-2 shadow-sm" style="border-radius: 10px; overflow: hidden;">
                            <input type="text" id="map_search_input" class="form-control border-0" placeholder="Ketik nama jalan atau daerah..." style="background: #f8f9fa;">
                            <button class="btn btn-primary px-4 fw-bold" type="button" id="btn-search-map">Cari</button>
                        </div>
                        
                        <div id="map-container"></div>
                        
                        <div class="map-feedback" id="map-feedback-box">
                            <i class="bi bi-check-circle-fill me-2"></i> 
                            <span id="map-feedback-text">Titik lokasi berhasil diamankan!</span>
                        </div>
                    </div>
                </div>

                <div class="checkout-card">
                    <div class="section-title"><i class="bi bi-box-seam-fill"></i> Jasa Pengiriman</div>
                    <select name="shipping_method" id="shipping_method" onchange="updateTotalHarga()" class="form-select form-select-lg bg-light" style="border-radius: 12px; font-size: 15px; font-weight: 600; cursor: pointer;">
                        <option value="gosend" data-ongkir="35000">GoSend Instant (Rp 35.000) - Tiba Hari Ini</option>
                        <option value="jne_yes" data-ongkir="24000">JNE YES (Rp 24.000) - Besok Sampai</option>
                        <option value="sicepat" data-ongkir="15000">SiCepat REG (Rp 15.000) - 2-3 Hari</option>
                    </select>
                </div>

                <div class="checkout-card">
                    <div class="section-title"><i class="bi bi-wallet2"></i> Metode Pembayaran</div>
                    
                    <div class="payment-category-title mt-0">E-Wallet</div>
                    <div class="row g-3 mb-3">
                        @php 
                            $ewallets = [
                                'qris' => 'QRIS', 'shopeepay' => 'ShopeePay', 
                                'gopay' => 'Gopay', 'ovo' => 'OVO via QRIS', 'dana' => 'Dana via QRIS'
                            ]; 
                        @endphp
                        @foreach($ewallets as $val => $name)
                        <div class="col-md-6">
                            <label class="payment-option w-100">
                                <input type="radio" name="payment_method" value="{{ $val }}" {{ $val == 'qris' ? 'checked' : '' }}>
                                <div class="payment-card shadow-sm">
                                    <img src="{{ asset('assets/img/'.$val.'.png') }}" onerror="this.style.display='none'" alt="{{ $name }}">
                                    <span>{{ $name }}</span>
                                </div>
                            </label>
                        </div>
                        @endforeach
                    </div>

                    <div class="payment-category-title">Transfer Virtual Account</div>
                    <div class="row g-3 mb-3">
                        @php 
                            $vas = ['bca' => 'BCA', 'mandiri' => 'Mandiri', 'bni' => 'BNI', 'bri' => 'BRI', 'bank_lain' => 'Bank Lain']; 
                        @endphp
                        @foreach($vas as $val => $name)
                        <div class="col-md-6">
                            <label class="payment-option w-100">
                                <input type="radio" name="payment_method" value="{{ $val }}">
                                <div class="payment-card shadow-sm">
                                    <img src="{{ asset('assets/img/'.$val.'.png') }}" onerror="this.style.display='none'" alt="{{ $name }}">
                                    <span>{{ $name }}</span>
                                </div>
                            </label>
                        </div>
                        @endforeach
                    </div>

                    <div class="payment-category-title">Kartu Kredit / Debit</div>
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label class="payment-option w-100">
                                <input type="radio" name="payment_method" value="credit_card">
                                <div class="payment-card shadow-sm">
                                    <img src="{{ asset('assets/img/credit_card.png') }}" onerror="this.style.display='none'" alt="Credit Card">
                                    <span>Credit / Debit Card</span>
                                </div>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="summary-card">
                    <h5 class="fw-bold mb-4 border-bottom pb-3">Ringkasan Pesanan</h5>
                    
                    <div class="mb-4">
                        @php 
                            $totalBelanja = 0; 
                            $ongkir = 35000; // Standar GoSend
                            $itemCount = 0;
                        @endphp

                        @foreach($cart as $id => $details)
                            @if(isset($products[$id]))
                                @php 
                                    $p = $products[$id]; 
                                    $totalBelanja += ($p->price * $details['quantity']);
                                    $itemCount++;
                                @endphp
                                
                                @if($itemCount <= 3)
                                <div class="d-flex gap-3 mb-3">
                                    <div class="bg-light rounded p-1 border" style="width: 50px; height: 50px; display: flex; align-items: center; justify-content: center;">
                                        <img src="{{ asset('assets/img/'.$p->name.'.png') }}" onerror="this.src='{{ asset('assets/img/default_part.png') }}'" style="max-width: 100%; max-height: 100%;">
                                    </div>
                                    <div class="flex-grow-1 overflow-hidden">
                                        <div class="text-truncate fw-bold text-dark" style="font-size: 13px;">{{ $p->name }}</div>
                                        <div class="text-muted small">Qty: {{ $details['quantity'] }}</div>
                                    </div>
                                    <div class="fw-bold text-dark" style="font-size: 13px;">Rp{{ number_format($p->price, 0, ',', '.') }}</div>
                                </div>
                                @endif
                            @endif
                        @endforeach
                        
                        @if(count($cart) > 3)
                            <div class="text-center text-primary fw-bold small mt-3 bg-light rounded-pill py-2 border">
                                + {{ count($cart) - 3 }} Produk Lainnya
                            </div>
                        @endif
                    </div>
                    
                    <div id="data-kalkulasi" data-belanja="{{ $totalBelanja }}" data-layanan="2000"></div>

                    <div class="summary-row fw-medium text-dark">
                        <span>Total Harga</span>
                        <span>Rp {{ number_format($totalBelanja, 0, ',', '.') }}</span>
                    </div>
                    <div class="summary-row fw-medium text-dark">
                        <span>Ongkos Kirim</span>
                        <span id="teks-ongkir">Rp 35.000</span>
                    </div>
                    <div class="summary-row">
                        <span>Biaya Layanan</span>
                        <span>Rp 2.000</span>
                    </div>
                    
                        <div class="summary-total">
                            <span>Total Tagihan</span>
                            <span style="color: #D72C84;" id="teks-total">Rp {{ number_format($totalBelanja + 35000 + 2000, 0, ',', '.') }}</span>
                        </div>
                        
                        <button type="submit" id="btn-submit-checkout" class="btn-pay">
                            <i class="bi bi-shield-lock-fill"></i> Bayar Sekarang
                        </button>
                    </div>
                </div>
        </div>
    </form>
</div>
@endsection

@section('scripts')
<!-- 1. Import Library Peta Leaflet JS -->
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script src="https://unpkg.com/leaflet-control-geocoder/dist/Control.Geocoder.js"></script>

<script>
    // ==========================================
    // FUNGSI 1: KONTROL TAB ALAMAT (PROFIL VS PETA)
    // ==========================================
    document.addEventListener("DOMContentLoaded", () => {
        const tabProfile = document.getElementById('tab-profile');
        const tabMap = document.getElementById('tab-map');
        const areaProfile = document.getElementById('area-profile-address');
        const areaMap = document.getElementById('area-map-address');
        const inputAddressType = document.getElementById('input_address_type');

        // LOGIKA CERDAS: Cek dulu apakah tombol tab-nya ada (mencegah error JS)
        if (tabProfile && tabMap) {
            tabProfile.addEventListener('click', () => {
                tabProfile.classList.add('active');
                tabMap.classList.remove('active');
                areaProfile.style.display = 'block';
                areaMap.style.display = 'none';
                inputAddressType.value = 'profile'; 
            });

            tabMap.addEventListener('click', () => {
                tabMap.classList.add('active');
                tabProfile.classList.remove('active');
                areaMap.style.display = 'block';
                areaProfile.style.display = 'none';
                inputAddressType.value = 'map'; 
                
                if(typeof initMap === 'function') {
                    setTimeout(() => { initMap(); }, 100);
                }
            });
        }

        // TRIGGER PETA OTOMATIS: Jika halaman dimuat dan default-nya adalah peta, langsung render!
        if (inputAddressType.value === 'map') {
            setTimeout(() => { initMap(); }, 300);
        }
    });

    // ==========================================
    // FUNGSI 2: MESIN PETA LEAFLET & GEOCODING
    // ==========================================
    let map, marker;

    function initMap() {
        // Cegah peta di-load dua kali yang bisa bikin error
        if (map) return; 

        // Titik kordinat default: Jakarta Timur (Biar langsung dekat dengan rumahmu)
        const startLat = -6.225014;
        const startLng = 106.900447;
        
        // Render Kanvas Peta
        map = L.map('map-container').setView([startLat, startLng], 14);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        // Buat pin marker yang bisa digeser (draggable)
        marker = L.marker([startLat, startLng], { draggable: true }).addTo(map);

        // Sub-fungsi: Mengamankan kordinat & menerjemahkannya jadi teks alamat (Reverse Geocoding)
        function updateLocation(lat, lng) {
            document.getElementById('input_map_lat').value = lat;
            document.getElementById('input_map_lng').value = lng;
            
            // Tanya ke server OpenStreetMap: "Ini jalan apa?"
            fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lng}`)
                .then(res => res.json())
                .then(data => {
                    const addressText = data.display_name;
                    document.getElementById('input_map_address_text').value = addressText;
                    
                    // Tampilkan kotak hijau feedback di layar
                    const feedbackBox = document.getElementById('map-feedback-box');
                    const feedbackText = document.getElementById('map-feedback-text');
                    feedbackBox.style.display = 'block';
                    feedbackText.innerHTML = `<strong>Titik aman dikunci!</strong><br><small>${addressText}</small>`;
                });
        }

        // Aksi saat pin marker selesai digeser manual
        marker.on('dragend', function (e) {
            const position = marker.getLatLng();
            updateLocation(position.lat, position.lng);
        });

        // Aksi adaptasi dari detail_acara.php: Pencarian lokasi lewat ketikan
        document.getElementById('btn-search-map').addEventListener('click', function() {
            const query = document.getElementById('map_search_input').value;
            if(!query) return;

            const btn = this;
            const originalText = btn.innerHTML;
            btn.innerHTML = '<span class="spinner-border spinner-border-sm" style="width: 1rem; height: 1rem;"></span>'; // Animasi loading

            fetch(`https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(query)}`)
                .then(res => res.json())
                .then(data => {
                    btn.innerHTML = originalText;
                    if(data && data.length > 0) {
                        const lat = parseFloat(data[0].lat);
                        const lon = parseFloat(data[0].lon);
                        
                        // Terbang ke lokasi baru dan pindahkan pin
                        map.setView([lat, lon], 16);
                        marker.setLatLng([lat, lon]);
                        updateLocation(lat, lon);
                    } else {
                        Swal.fire({ icon: 'warning', title: 'Oops!', text: 'Lokasi tidak ditemukan sayang. Coba gunakan nama jalan yang lebih spesifik ya!' });
                    }
                })
                .catch(err => {
                    btn.innerHTML = originalText;
                    Swal.fire({ icon: 'error', title: 'Error Jaringan', text: 'Duh, ada gangguan saat mencari lokasi.' });
                });
        });

        // Bikin tombol Enter bisa dipakai buat nyari lokasi
        document.getElementById('map_search_input').addEventListener('keypress', function (e) {
            if (e.key === 'Enter') {
                e.preventDefault(); 
                document.getElementById('btn-search-map').click();
            }
        });
        
        // Jalankan pelacakan alamat pertama kali saat peta dibuka
        updateLocation(startLat, startLng);
    }

    // ==========================================
    // FUNGSI 3: MESIN AJAX CHECKOUT (TANPA REFRESH)
    // ==========================================
    const checkoutForm = document.getElementById('checkout-form');
    const submitButton = document.getElementById('btn-submit-checkout');

    if (checkoutForm && submitButton) {
        checkoutForm.addEventListener('submit', function (e) {
            e.preventDefault();

            const btnSubmit = submitButton;
            const originalBtnHtml = btnSubmit.innerHTML;

            btnSubmit.disabled = true;
            btnSubmit.innerHTML = 'Memproses...';

            const formData = new FormData(this);
            const token = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');

            if (token) {
                formData.set('_token', token);
            }

            fetch('{{ url("checkout/process") }}', {
                method: 'POST',
                body: formData,
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
            .then(async (res) => {
                const data = await res.json().catch(() => ({}));
                if (!res.ok) {
                    throw new Error(data.message || 'Terjadi kesalahan sistem.');
                }
                return data;
            })
            .then((data) => {
                if (data.status === 'success') {
                    const mode = @json($mode ?? '');
                    window.location.href = '/payment/bca?mode=' + mode;
                } else {
                    btnSubmit.disabled = false;
                    btnSubmit.innerHTML = originalBtnHtml;
                    Swal.fire('Gagal!', data.message || 'Terjadi kesalahan sistem.', 'error');
                }
            })
            .catch((err) => {
                btnSubmit.disabled = false;
                btnSubmit.innerHTML = originalBtnHtml;
                console.error('Laporan Error Fetch:', err);
                Swal.fire('Error Sistem', 'Gagal memproses pesanan.', 'error');
            });
        });
    }

    // ==========================================
    // FUNGSI 1.5: UPDATE TOTAL HARGA REAL-TIME
    // ==========================================
    function updateTotalHarga() {
        const selectOngkir = document.getElementById('shipping_method');
        // Ambil harga ongkir dari atribut data-ongkir option yang dipilih
        const ongkir = parseInt(selectOngkir.options[selectOngkir.selectedIndex].getAttribute('data-ongkir'));
        
        // Ambil data base harga dari HTML
        const dataBox = document.getElementById('data-kalkulasi');
        const belanja = parseInt(dataBox.getAttribute('data-belanja'));
        const layanan = parseInt(dataBox.getAttribute('data-layanan'));
        
        // Kalkulasi
        const totalTagihan = belanja + ongkir + layanan;
        
        // Format ke Rupiah
        const formatRp = (angka) => new Intl.NumberFormat('id-ID').format(angka);
        
        // Update langsung ke layar tanpa loading
        document.getElementById('teks-ongkir').innerText = 'Rp ' + formatRp(ongkir);
        document.getElementById('teks-total').innerText = 'Rp ' + formatRp(totalTagihan);
    }
</script>
@endsection