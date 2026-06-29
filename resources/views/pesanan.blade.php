@extends('layouts.app')

@section('title', 'Status Pesanan - RELASKA')

@section('styles')
<style>
    body { background: #f4f7f6; }
    .page-container { margin-top: 40px; margin-bottom: 80px; }
</style>
@endsection

@section('content')

@php
    // SIMULASI DATA BACKEND: Anggap saja ini data yang dilempar dari Database/Controller
    $orders = [
        (object)[
            'id' => 1,
            'transaction_id' => 'RLK-260682',
            'created_at' => '2026-06-28 10:30:00',
            'status' => 'draft',
            'total_price' => 4500000,
            'type' => 'build'
        ],
        (object)[
            'id' => 2,
            'transaction_id' => 'RLK-260599',
            'created_at' => '2026-06-25 14:15:00',
            'status' => 'pending',
            'total_price' => 1250000,
            'type' => 'part'
        ],
        (object)[
            'id' => 3,
            'transaction_id' => 'RLK-260102',
            'created_at' => '2026-06-20 09:00:00',
            'status' => 'completed',
            'total_price' => 320000,
            'type' => 'part'
        ]
    ];
@endphp

<div class="container page-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-success mb-0"><i class="bi bi-box-seam me-2"></i>Daftar Pesanan</h3>
            <small class="text-muted">Pantau status pembelian part kamu di sini.</small>
        </div>
        <a href="{{ url('dashboard') }}" class="btn btn-outline-dark rounded-pill">
            <i class="bi bi-arrow-left"></i> Kembali
        </a>
    </div>

    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead class="bg-light">
                        <tr>
                            <th class="p-3 text-secondary">ID Transaksi & Waktu</th>
                            <th class="p-3 text-secondary">Status</th>
                            <th class="p-3 text-secondary">Total Harga</th>
                            <th class="p-3 text-end text-secondary">Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($orders as $o)
                        <tr>
                            <td class="p-3">
                                <div class="fw-bold text-dark">{{ $o->transaction_id ?? 'TRX-'.$o->id }}</div>
                                <small class="text-muted">{{ date('d M Y, H:i', strtotime($o->created_at)) }}</small>
                            </td>
                            
                            <td class="p-3">
    @if($o->status == 'draft')
        <span class="badge bg-warning text-dark"><i class="bi bi-clock"></i> Belum Dibayar</span>
    @elseif($o->status == 'waiting_approval')
        <span class="badge bg-info text-dark"><i class="bi bi-hourglass-split"></i> Menunggu Verifikasi</span>
    @elseif($o->status == 'paid')
        <span class="badge bg-success"><i class="bi bi-check-circle"></i> Lunas / Diproses</span>
    @elseif($o->status == 'rejected')
        <span class="badge bg-danger"><i class="bi bi-x-circle"></i> Dibatalkan</span>
    @endif
</td>

                            <td class="p-3 fw-bold text-primary">
                                Rp {{ number_format($o->total_price, 0, ',', '.') }}
                            </td>

                            <td class="text-end p-3">
                                @if($o->status == 'draft')
                                    <a href="{{ url('payment/bca') }}" class="btn btn-sm btn-warning text-dark rounded-pill px-3 fw-bold">Lanjut Bayar</a>
                                    <button class="btn btn-sm btn-light border text-danger rounded-pill px-3 ms-1" onclick="return confirm('Batalkan pesanan ini?')">
                                        <i class="bi bi-x-lg"></i>
                                    </button>
                                @else
                                    @if($o->type == 'build')
                                        <a href="{{ url('builder/result/'.$o->id) }}" class="btn btn-sm btn-outline-primary rounded-pill px-3">Detail Rakitan</a>
                                    @else
                                        <span class="text-muted small fw-bold"><i class="bi bi-check2-all"></i> Transaksi Berjalan</span>
                                    @endif
                                @endif
                            </td>                              
                        </tr>
                        @empty
                        <tr>
                            <td colspan="4" class="text-center py-5 text-muted">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                Belum ada pesanan masuk.
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection