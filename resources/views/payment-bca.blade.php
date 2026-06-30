@extends('layouts.app')

@section('title', 'Pembayaran BCA - RELASKA Computer')

@section('styles')
<style>
    body { background-color: #f0f4f8; }
    .payment-header { background: #0066ae; color: white; padding: 20px 0; border-radius: 0 0 30px 30px; }
    .payment-card { background: white; border-radius: 20px; padding: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); margin-top: -30px; }
    .va-box { background: #f8f9fa; border: 2px dashed #0066ae; border-radius: 15px; padding: 20px; display: flex; justify-content: space-between; align-items: center; }
    .va-number { font-size: 1.5rem; font-weight: 800; color: #0066ae; letter-spacing: 2px; }
    .total-amount { font-size: 1.8rem; font-weight: 800; color: #333; }
    .btn-copy { background: none; border: none; color: #0066ae; font-weight: 700; font-size: 0.9rem; }
    .instruction-item { border-bottom: 1px solid #eee; padding: 15px 0; }
    .instruction-item:last-child { border-bottom: none; }
    .step-num { width: 25px; height: 25px; background: #0066ae; color: white; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; font-size: 0.8rem; font-weight: 700; margin-right: 10px; }
    .btn-check-status { background: #1a2a3a; color: white; border: none; width: 100%; padding: 15px; border-radius: 12px; font-weight: 800; margin-top: 30px; }
</style>
@endsection

@section('navbar')
<div class="payment-header text-center">
    <div class="container">
        <img src="https://upload.wikimedia.org/wikipedia/commons/5/5c/Bank_Central_Asia.svg" height="30" class="mb-3" style="filter: brightness(0) invert(1);">
        <h5 class="fw-bold">Virtual Account BCA</h5>
    </div>
</div>
@endsection

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="payment-card mb-4">
                <div class="text-center mb-4">
                    <p class="text-muted small mb-1">Total Tagihan</p>
                    <h2 class="total-amount">Rp {{ number_format($order->total_price, 0, ',', '.') }}</h2>
                    <span class="badge bg-warning text-dark px-3 py-2 rounded-pill small">Menunggu Pembayaran</span>
                </div>

                <div class="mb-4">
                    <label class="form-label small fw-bold text-muted">Nomor Virtual Account</label>
                    <div class="va-box">
                        <span class="va-number" id="vaNum">{{ $no_va ?? '3901 0812 3456 7890' }}</span>
                        <button class="btn-copy" onclick="copyText()"><i class="bi bi-copy me-1"></i> SALIN</button>
                    </div>
                </div>

                <div class="alert alert-info border-0 rounded-4 d-flex align-items-center gap-3">
                    <i class="bi bi-clock-history fs-3"></i>
                    <small>Bayar pesanan dalam <b>24 jam</b> sebelum nomor VA ini kedaluwarsa.</small>
                </div>
            </div>

            <div class="payment-card">
                <h6 class="fw-bold mb-4 border-bottom pb-3">Instruksi Pembayaran</h6>
                
                <div class="instruction-item">
                    <span class="step-num">1</span>
                    <span class="small fw-semibold">Buka aplikasi <b>m-BCA</b> atau <b>KlikBCA</b>.</span>
                </div>
                <div class="instruction-item">
                    <span class="step-num">2</span>
                    <span class="small fw-semibold">Pilih menu <b>m-Transfer</b> > <b>BCA Virtual Account</b>.</span>
                </div>
                <div class="instruction-item">
                    <span class="step-num">3</span>
                    <span class="small fw-semibold">Masukkan nomor VA <b>{{ $no_va ?? '3901 0812 3456 7890' }}</b>.</span>
                </div>
                <div class="instruction-item">
                    <span class="step-num">4</span>
                    <span class="small fw-semibold">Periksa detail pesanan (<b>RELASKA - {{ session('username') }}</b>).</span>
                </div>
                <div class="instruction-item">
                    <span class="step-num">5</span>
                    <span class="small fw-semibold">Masukkan PIN m-BCA dan simpan bukti bayar.</span>
                </div>

                <button class="btn-check-status" onclick="checkPayment()">SAYA SUDAH BAYAR</button>
                <a href="{{ url('/') }}" class="btn btn-link w-100 text-decoration-none text-muted small mt-3">Bayar Nanti</a>
            </div>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script>
    function copyText() {
        const va = document.getElementById('vaNum').innerText;
        navigator.clipboard.writeText(va);
        Swal.fire({ title: 'Disalin!', text: 'Nomor VA berhasil disalin.', icon: 'success', toast: true, position: 'top-end', showConfirmButton: false, timer: 2000 });
    }

    function checkPayment() {
        Swal.fire({
            title: 'Konfirmasi Pembayaran?', text: "Pastikan Anda sudah melakukan transfer sesuai nominal.", icon: 'warning', showCancelButton: true, confirmButtonColor: '#0066ae', confirmButtonText: 'Ya, Saya Sudah Transfer'
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({ title: 'Memproses...', didOpen: () => { Swal.showLoading() } });
                // Sisipkan order_id dan ubah headers
                fetch('{{ url("cart/confirmPayment") }}', {
                    method: 'POST', 
                    body: JSON.stringify({ order_id: {{ $order->id }} }), // Kirim ID Pesanan
                    headers: { 
                        'Content-Type': 'application/json', // Tambahkan ini
                        'X-Requested-With': 'XMLHttpRequest', 
                        'X-CSRF-TOKEN': '{{ csrf_token() }}' 
                    }
                })
                .then(res => res.json())
                .then(data => {
                    if(data.status === 'success') {
                        Swal.fire({ title: 'Berhasil!', text: 'Pembayaran sedang diverifikasi Admin. Cek status di Dashboard.', icon: 'success' }).then(() => {
                            window.location.href = "{{ url('dashboard') }}";
                        });
                    } else {
                        Swal.fire('Gagal', 'Terjadi kesalahan sistem.', 'error');
                    }
                });
            }
        });
    }
</script>
@endsection