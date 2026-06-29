@extends('layouts.app')

@section('title', 'Keranjang Belanja - RELASKA')

@section('styles')
<style>
    body { background-color: #f8f9fa; }
    .cart-container { margin-top: 40px; margin-bottom: 80px; }
    
    /* Desain Kartu Keranjang */
    .cart-card { background: #fff; border-radius: 20px; padding: 25px; border: 1px solid #f0f0f0; margin-bottom: 20px; }
    .cart-item { display: flex; align-items: center; padding-bottom: 20px; border-bottom: 1px solid #f1f1f1; margin-bottom: 20px; }
    .cart-item:last-child { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }
    
    .cart-img-box { width: 100px; height: 100px; background: #fdfdfd; border-radius: 15px; display: flex; align-items: center; justify-content: center; padding: 10px; border: 1px solid #eee; flex-shrink: 0; }
    .cart-img-box img { max-width: 100%; max-height: 100%; object-fit: contain; }
    
    /* Tombol Plus Minus Kuantitas */
    .qty-control { display: inline-flex; align-items: center; background: #f8f9fa; border-radius: 10px; border: 1px solid #e9ecef; overflow: hidden; }
    .btn-qty { background: transparent; border: none; padding: 5px 15px; font-weight: bold; color: #495057; transition: 0.2s; }
    .btn-qty:hover { background: #e9ecef; }
    .qty-input { width: 40px; text-align: center; border: none; background: transparent; font-weight: 600; font-size: 14px; outline: none; pointer-events: none; }
    
    /* Tombol Hapus */
    .btn-remove { color: #dc3545; background: rgba(220, 53, 69, 0.1); border: none; border-radius: 10px; padding: 8px 12px; font-size: 14px; transition: 0.3s; }
    .btn-remove:hover { background: #dc3545; color: white; }

    /* Ringkasan Belanja */
    .summary-card { background: #fff; border-radius: 20px; padding: 30px; border: 1px solid #f0f0f0; position: sticky; top: 140px; }
    .summary-row { display: flex; justify-content: space-between; margin-bottom: 15px; color: #6c757d; font-size: 15px; }
    .summary-total { display: flex; justify-content: space-between; margin-top: 20px; padding-top: 20px; border-top: 2px dashed #eee; font-size: 18px; font-weight: 800; color: #1a2a3a; }
    
    /* Tombol Gradient RELASKA */
    .btn-checkout { background: linear-gradient(to right, #ff5e62, #ff9966); color: white; border: none; border-radius: 12px; padding: 15px; font-weight: 700; font-size: 16px; width: 100%; transition: 0.3s; box-shadow: 0 10px 20px rgba(255, 94, 98, 0.2); margin-top: 25px; }
    .btn-checkout:hover { transform: translateY(-3px); box-shadow: 0 15px 25px rgba(255, 94, 98, 0.3); color: white; }
</style>
@endsection

@section('content')
<div class="container cart-container">
    <h3 class="fw-bold mb-4" style="color: #1a2a3a;">Keranjang Belanja</h3>

    @if(count($cart) > 0)
        <div class="row g-4">
            <div class="col-lg-8">
                <div class="cart-card shadow-sm">
                    
                    <div class="d-flex align-items-center mb-4 pb-3 border-bottom">
                        <div class="form-check custom-checkbox">
                            <input class="form-check-input border-secondary" type="checkbox" id="selectAll" checked style="width: 20px; height: 20px; cursor: pointer;">
                            <label class="form-check-label ms-2 fw-bold" for="selectAll" style="cursor: pointer; padding-top: 2px;">
                                Pilih Semua Barang
                            </label>
                        </div>
                    </div>

                    @php $totalBelanja = 0; @endphp

                    @foreach($cart as $id => $details)
                        @if(isset($products[$id]))
                            @php $p = $products[$id]; @endphp
                            <!-- Tambahkan ID dan atribut data-price di sini -->
                            <div class="cart-item" id="item-{{ $id }}" data-price="{{ $p->price }}">
                                <div class="form-check me-3">
                                    <!-- Tambahkan event onchange="calculateTotal()" -->
                                    <input class="form-check-input border-secondary item-check" type="checkbox" checked onchange="calculateTotal()" style="width: 20px; height: 20px; cursor: pointer;">
                                </div>
                                
                                <a href="{{ url('product/'.$p->id) }}" class="cart-img-box text-decoration-none">
                                    <img src="{{ asset('assets/img/'.$p->name.'.png') }}" onerror="this.src='{{ asset('assets/img/default_part.png') }}'" alt="">
                                </a>
                                
                                <div class="ms-4 flex-grow-1">
                                    <a href="{{ url('product/'.$p->id) }}" class="text-decoration-none text-dark">
                                        <h6 class="fw-bold mb-1" style="line-height: 1.4;">{{ $p->name }}</h6>
                                    </a>
                                    @php
                                        $catMap = [ 1=>'Processor', 2=>'Motherboard', 3=>'RAM', 4=>'VGA', 5=>'Storage', 6=>'Power Supply', 7=>'Casing', 8=>'CPU Cooler', 9=>'Case Fan', 10=>'Monitor', 11=>'Keyboard', 12=>'Mouse', 13=>'Headset' ];
                                        $namaKategori = $catMap[$p->category_id] ?? 'Komponen';
                                    @endphp
                                    <div class="text-muted small mb-2">Kategori: {{ $namaKategori }}</div>
                                    <h5 class="fw-bold mb-0" style="color: #ff4d6d;">Rp {{ number_format($p->price, 0, ',', '.') }}</h5>
                                </div>
                                
                                <div class="ms-3 d-flex flex-column align-items-end gap-3">
                                    <div class="qty-control">
                                        <!-- ID untuk input dan parameter untuk tombol -->
                                        <button class="btn-qty" onclick="updateQty({{ $id }}, -1)">-</button>
                                        <input type="text" class="qty-input" id="qty-{{ $id }}" value="{{ $details['quantity'] }}" readonly>
                                        <button class="btn-qty" onclick="updateQty({{ $id }}, 1)">+</button>
                                    </div>
                                    <button class="btn-remove" onclick="removeItem({{ $id }})">
                                        <i class="bi bi-trash3-fill"></i> Hapus
                                    </button>
                                </div>
                            </div>
                        @endif
                    @endforeach

                </div>
            </div>

            <div class="col-lg-4">
                <div class="summary-card shadow-sm">
                    <h5 class="fw-bold mb-4 border-bottom pb-3">Ringkasan Belanja</h5>
                    
                    <div class="summary-row">
                        <!-- Tambahkan ID summary-count dan total-harga -->
                        <span>Total Harga (<span id="summary-count">{{ count($cart) }}</span> barang)</span>
                        <span class="fw-bold text-dark" id="total-harga">Rp {{ number_format($totalBelanja ?? 0, 0, ',', '.') }}</span>
                    </div>
                    <div class="summary-row">
                        <span>Diskon Produk</span>
                        <span class="text-success fw-bold">- Rp 0</span>
                    </div>
                    
                    <div class="summary-total">
                        <span>Total Tagihan</span>
                        <!-- Tambahkan ID total-tagihan -->
                        <span style="color: #ff4d6d;" id="total-tagihan">Rp {{ number_format($totalBelanja ?? 0, 0, ',', '.') }}</span>
                    </div>
                    
                    <!-- Tombol diubah menjadi tag <a> agar berfungsi sebagai link -->
                    <a href="{{ url('checkout') }}" class="btn-checkout text-center text-decoration-none d-block mt-4">
                        Checkout Sekarang <i class="bi bi-arrow-right-circle ms-2"></i>
                    </a>
                </div>
            </div>
        </div>

    @else
        <div class="cart-card shadow-sm text-center py-5">
            <img src="{{ asset('assets/img/Icon Logo RELASKA rounded.png') }}" style="width: 120px; opacity: 0.1; margin-bottom: 20px; filter: grayscale(100%);">
            <h4 class="fw-bold mb-2">Keranjangmu masih kosong nih!</h4>
            <p class="text-muted mb-4">Yuk, cari dan temukan komponen PC impianmu sekarang.</p>
            <a href="{{ url('products/category/all') }}" class="btn btn-primary rounded-pill px-5 py-2 fw-bold shadow-sm" style="background: linear-gradient(90deg, #0A97D8 0%, #008cffff 100%); border: none;">
                Mulai Belanja
            </a>
        </div>
    @endif
</div>
@endsection

@section('scripts')
<script>
    // 1. Format Rupiah Instan
    const formatRupiah = (number) => {
        return new Intl.NumberFormat('id-ID').format(number);
    };

    // 2. Mesin Kalkulasi Total Pintar (Frontend Only)
    function calculateTotal() {
        let total = 0;
        let checkedCount = 0;
        const items = document.querySelectorAll('.cart-item');
        
        items.forEach(item => {
            const checkbox = item.querySelector('.item-check');
            // Hanya hitung barang yang dicentang
            if (checkbox && checkbox.checked) {
                const price = parseFloat(item.getAttribute('data-price'));
                const qty = parseInt(item.querySelector('.qty-input').value);
                total += price * qty;
                checkedCount += qty;
            }
        });

        // Update UI secara real-time
        document.getElementById('total-harga').innerText = 'Rp ' + formatRupiah(total);
        document.getElementById('total-tagihan').innerText = 'Rp ' + formatRupiah(total);
        document.getElementById('summary-count').innerText = checkedCount;
        
        // Logika Pilih Semua (Otomatis centang jika semua item tercentang manual)
        const selectAll = document.getElementById('selectAll');
        if (selectAll) {
            selectAll.checked = (document.querySelectorAll('.item-check:checked').length === items.length && items.length > 0);
        }
    }

    // 3. Aksi Tombol Pilih Semua
    const selectAll = document.getElementById('selectAll');
    if (selectAll) {
        selectAll.addEventListener('change', (e) => {
            document.querySelectorAll('.item-check').forEach(check => {
                check.checked = e.target.checked;
            });
            calculateTotal(); // Hitung ulang setelah pilih semua
        });
    }

    // 4. Aksi Update Kuantitas (Tanpa Reload)
    function updateQty(id, change) {
        const input = document.getElementById('qty-' + id);
        let currentQty = parseInt(input.value);
        let newQty = currentQty + change;
        
        // LOGIKA CERDAS BARU: Jika user menekan minus saat qty = 1, 
        // langsung oper tugasnya ke fungsi removeItem (Hapus)
        if (newQty < 1) {
            removeItem(id);
            return; 
        }
        
        // Update layar langsung (Optimistic UI) agar terasa super cepat
        input.value = newQty;
        calculateTotal();

        // Diam-diam lapor ke server
        let formData = new FormData();
        formData.append('id', id);
        formData.append('quantity', newQty);
        formData.append('_token', '{{ csrf_token() }}');

        fetch('{{ url("cart/update") }}', { method: 'POST', body: formData, headers: { "X-Requested-With": "XMLHttpRequest" } })
        .catch(err => {
            // Jika koneksi putus, kembalikan angka ke semula
            input.value = currentQty;
            calculateTotal();
        });
    }

    // 5. Aksi Hapus Item dengan Animasi Mulus
    function removeItem(id) {
        Swal.fire({
            title: 'Hapus Komponen?',
            text: "Barang ini akan lenyap dari keranjangmu.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            confirmButtonText: 'Ya, Hapus!',
            cancelButtonText: 'Batal'
        }).then((result) => {
            if (result.isConfirmed) {
                let formData = new FormData();
                formData.append('id', id);
                formData.append('_token', '{{ csrf_token() }}');

                fetch('{{ url("cart/remove") }}', { method: 'POST', body: formData, headers: { "X-Requested-With": "XMLHttpRequest" } })
                .then(res => res.json())
                .then(data => {
                    if(data.status === 'success') {
                        const item = document.getElementById('item-' + id);
                        // Animasi menghilang (Fade out & geser kiri)
                        item.style.transition = 'all 0.5s ease';
                        item.style.opacity = '0';
                        item.style.transform = 'translateX(-50px)';
                        
                        setTimeout(() => {
                            item.remove();
                            calculateTotal(); // Hitung ulang harga setelah barang dihapus
                            document.getElementById('cart-count').innerText = data.cart_count; // Update Navbar
                            
                            // Jika keranjang sudah benar-benar kosong, reload halaman agar UI kosong muncul
                            if(data.cart_count === 0) {
                                window.location.reload();
                            }
                        }, 500);
                    }
                });
            }
        });
    }

    // Hitung total saat pertama kali halaman dimuat
    document.addEventListener("DOMContentLoaded", calculateTotal);
</script>
@endsection