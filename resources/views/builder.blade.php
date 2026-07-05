@extends('layouts.app')

@section('title', 'PC Builder AI - Segera Hadir | RELASKA')

@section('styles')
<style>
    .under-dev-container {
        min-height: 75vh;
        display: flex;
        align-items: center;
        justify-content: center;
        background: linear-gradient(135deg, #0f172a 0%, #1e1e24 100%);
        border-radius: 30px;
        margin: 40px auto;
        padding: 60px 20px;
        color: white;
        position: relative;
        overflow: hidden;
        box-shadow: 0 20px 50px rgba(0,0,0,0.2);
    }
    .glow-effect {
        position: absolute;
        width: 300px;
        height: 300px;
        background: radial-gradient(circle, rgba(13, 110, 253, 0.25) 0%, rgba(0,0,0,0) 70%);
        top: -50px;
        right: -50px;
        border-radius: 50%;
    }
    .glow-effect-2 {
        position: absolute;
        width: 350px;
        height: 350px;
        background: radial-gradient(circle, rgba(255, 0, 122, 0.15) 0%, rgba(0,0,0,0) 70%);
        bottom: -80px;
        left: -80px;
        border-radius: 50%;
    }
    .dev-card {
        position: relative;
        z-index: 2;
        max-width: 650px;
        text-align: center;
    }
    .icon-wrapper {
        width: 110px;
        height: 110px;
        background: rgba(13, 110, 253, 0.15);
        border: 2px solid #0d6efd;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 25px;
        box-shadow: 0 0 25px rgba(13, 110, 253, 0.4);
        animation: pulse 2s infinite;
    }
    @keyframes pulse {
        0% { transform: scale(1); box-shadow: 0 0 25px rgba(13, 110, 253, 0.4); }
        50% { transform: scale(1.06); box-shadow: 0 0 45px rgba(13, 110, 253, 0.8); }
        100% { transform: scale(1); box-shadow: 0 0 25px rgba(13, 110, 253, 0.4); }
    }
    
</style>
@endsection

@section('content')
<div class="container mb-5">
    <div class="under-dev-container shadow-lg">
        <div class="glow-effect"></div>
        <div class="glow-effect-2"></div>
        
        <div class="dev-card">
            <!-- Ikon Berdenyut -->
            <div class="icon-wrapper">
                <i class="bi bi-cpu-fill fs-1 text-primary"></i>
            </div>
            
            <span class="badge bg-primary px-3 py-2 rounded-pill mb-3 fw-bold" style="letter-spacing: 1.5px; font-size: 0.75rem;">
                <i class="bi bi-gear-wide-connected me-1"></i> UNDER DEVELOPMENT
            </span>
            
            <h2 class="fw-bold mb-3" style="font-size: 2.4rem; letter-spacing: 1px;">
                RELASKA <span style="color: #00f2fe;">PC BUILDER </span>
            </h2>
            
            <p class="text-light opacity-75 mb-4" style="line-height: 1.7; font-size: 1rem;">
                Fitur simulasi perakitan PC pintar saat ini sedang dalam <b>tahap pengembangan intensif</b> oleh Tim RELASKA. Kami sedang menyempurnakan algoritma pengecekan kompatibilitas otomatis dan integrasi <i>Price Trend Radar</i> agar kamu bisa merakit PC tanpa takut salah beli!
            </p>
            
            <!-- Simulasi Progress Bar -->
            
            
            <!-- Tombol Aksi -->
            <div class="d-flex justify-content-center gap-3">
                <a href="{{ url('/') }}" class="btn btn-primary rounded-pill px-4 py-2 fw-bold shadow-lg">
                    <i class="bi bi-house-door-fill me-2"></i> Kembali ke Beranda
                </a>
                <a href="{{ url('products/category/all') }}" class="btn btn-outline-light rounded-pill px-4 py-2 fw-bold">
                    <i class="bi bi-bag-check-fill me-2"></i> Lihat Katalog Part
                </a>
            </div>
        </div>
    </div>
</div>
@endsection