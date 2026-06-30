@extends('layouts.app')

@section('title', 'Dashboard Profil - RELASKA')

@section('styles')
<script type="module" src="https://ajax.googleapis.com/ajax/libs/model-viewer/3.3.0/model-viewer.min.js"></script>
<style>
    body { font-family: 'Poppins', sans-serif; background-color: #f3f4f6; overflow-x: hidden; }
    
    .profile-banner-bg { background-image: url('{{ asset('assets/img/banner_cyber.png') }}'); background-size: cover; background-position: center; height: 250px; width: 100%; position: relative; background-color: #0a1128; }
    .profile-card-wrapper { margin-top: -120px; padding-right: 15px; position: relative; z-index: 5; }
    .card-profile { background: white; border-radius: 25px; border: none; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08); padding: 0 25px 25px 25px; overflow: visible; }
    .profile-header-overlap { position: relative; margin-bottom: 40px; }
    
    .profile-img-wrapper { position: absolute; top: -55px; left: 0px; width: 150px; height: 170px; border-radius: 25px; border: 8px solid #e0e2e7; overflow: hidden; z-index: 10; background: white; display: flex; align-items: center; justify-content: center; }
    .profile-img-wrapper img { width: 100%; height: 100%; object-fit: cover; }
    
    .initials-avatar { font-family: 'Montserrat', sans-serif; font-size: 4rem; font-weight: 800; color: #0d6efd; background-color: #e3f2fd; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; }
    
    .camera-icon-btn { position: absolute; top: 80px; left: 115px; background: #004e92; color: white; width: 35px; height: 35px; border-radius: 50%; display: flex; align-items: center; justify-content: center; border: none; z-index: 11; font-size: 0.9rem; box-shadow: 0 4px 8px rgba(0,0,0,0.15); cursor: pointer; transition: 0.2s; }
    .camera-icon-btn:hover { transform: scale(1.1); background: #003366; }

    .location-badge-pill { background-color: #cce5ff; color: #004085; display: inline-flex; align-items: center; gap: 8px; padding: 8px 20px; border-radius: 20px; font-weight: 700; font-size: 0.85rem; margin-bottom: 15px; }
    .user-detail-list .list-group-item { border: none; padding: 10px 0; border-bottom: 1px solid #f0f0f0; display: flex; justify-content: space-between; align-items: center; }
    .label-text { font-size: 0.85rem; color: #888; font-weight: 500; display: block; margin-bottom: 4px; }
    .value-text { font-size: 1rem; font-weight: 700; color: #333; margin: 0; line-height: 1.2; }
    .btn-edit-trigger { background: none; border: none; color: #0d6efd; cursor: pointer; transition: 0.2s; }
    .btn-edit-trigger:hover { color: #0a58ca; transform: translateX(3px); }
    
    .main-content-area { margin-top: -120px; position: relative; z-index: 5; }
    .card-dashboard { background: white; border-radius: 15px; border: none; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03); }
    .order-status-box { display: flex; flex-direction: column; align-items: center; justify-content: center; background-color: #f8f9fa; border-radius: 10px; padding: 15px 5px; color: #555; text-decoration: none; font-size: 0.75rem; transition: 0.3s; height: 100%; }
    .new-pc-builder-card { background-image: url('{{ asset('assets/img/3d_model_bg.JPG') }}'); background-color: #e2e8f0; background-size: cover; background-position: center; padding: 0; display: block; position: relative; height: 400px; border-radius: 15px; overflow: hidden; border: 1px solid rgba(0,0,0,0.1); }
    
    /* Footer */
    .footer { background: #1e1e1e; color: white; padding: 80px 0 40px; border-radius: 60px 60px 0 0; margin-top: 100px; width: 100%; }
    .footer-logo-main { max-height: 80px; margin-bottom: 10px; }
    .footer-brand-text { font-size: 32px; font-weight: 800; letter-spacing: 12px; text-transform: uppercase; margin-bottom: 5px; }
    .footer-brand-subtext { font-size: 14px; letter-spacing: 6px; color: #909090; text-transform: uppercase; margin-bottom: 40px; }
    .footer-divider { border-top: 1px solid rgba(255,255,255,0.1); margin: 40px 0; }
    .footer h6 { font-weight: 700; margin-bottom: 25px; font-size: 18px; }
    .footer-links-horizontal { display: flex; flex-wrap: wrap; justify-content: center; gap: 20px; }
    .footer-link { color: rgba(255,255,255,0.6); text-decoration: none; font-size: 14px; transition: 0.3s; white-space: nowrap; }
    .footer-link:hover { color: #fff; text-decoration: none; }
    .social-icons i { font-size: 24px; margin: 0 15px; color: white; cursor: pointer; transition: 0.3s; }
    .social-icons i:hover { transform: translateY(-5px); color: #0d6efd; }
    .copyright-text { font-size: 12px; color: rgba(255,255,255,0.4); margin-top: 30px; }
</style>
@endsection

@section('content')

<div class="profile-banner-bg"></div>

<div class="container mb-5">
    <div class="row">   
        
        <div class="col-lg-4 col-md-5 profile-card-wrapper">
            <div class="card-profile">
                <div class="profile-header-overlap mb-3">
                    <div class="profile-img-wrapper">
                        @if(!empty($user['profile_pic']))
                            <img src="{{ asset('assets/img/profiles/' . $user['profile_pic']) }}" alt="User" id="profileImagePreview">
                        @else
                            <div class="initials-avatar" id="initialsAvatar">
                                {{ strtoupper(substr($user['username'], 0, 1)) }}
                            </div>
                        @endif
                    </div>
                    
                    <div class="camera-icon-btn" onclick="document.getElementById('profilePicInput').click();" title="Ganti Foto">
                        <i class="fas fa-camera"></i>
                    </div>
                    <form id="formPhoto" style="display:none;">
                        <input type="file" id="profilePicInput" name="profile_pic" accept="image/*" onchange="uploadPhoto()">
                    </form>

                    <div style="margin-left: 165px; padding-top: 15px; min-height: 120px;">
                        <div class="location-badge-pill mb-2" style="padding: 6px 15px; font-size: 0.75rem; margin-bottom: 8px;">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/9/9f/Flag_of_Indonesia.svg" width="16" alt="ID"> 
                            Jakarta, Indonesia
                        </div>
                        
                        <div>
                            <h3 class="fw-bold mb-0 text-truncate" style="max-width: 150px; font-size: 1.6rem;">{{ $user['fullname'] ?: $user['username'] }}</h3>
                            <p class="text-muted mb-0" style="font-weight: 500; font-size: 0.85rem;">{{ $user['username'] }}@gmail.com</p>
                        </div>
                    </div>
                </div>
                
                <div class="px-2">
                    <div class="d-flex justify-content-end mb-3" style="margin-top: -20px;">
                        <button class="btn btn-sm btn-outline-primary rounded-pill px-4 shadow-sm" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                            <i class="bi bi-pencil-square"></i> Edit
                        </button>
                    </div>

                    <div class="list-group user-detail-list mb-4">
                        <div class="list-group-item" style="cursor: pointer;" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                            <div>
                                <span class="label-text">Nomor Telepon</span>
                                <p class="value-text">
                                    {!! !empty($user['phone']) ? '+62 ' . $user['phone'] : '<span class="text-muted small fst-italic">Belum diisi</span>' !!}
                                </p>
                            </div>
                            <button class="btn-edit-trigger"><i class="fas fa-chevron-right"></i></button>
                        </div>

                        <div class="list-group-item" style="cursor: pointer;" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                            <div>
                                <span class="label-text">Jenis Kelamin</span>
                                <p class="value-text">
                                    {!! !empty($user['gender']) ? $user['gender'] : '<span class="text-muted small fst-italic">-</span>' !!}
                                </p>
                            </div>
                            <button class="btn-edit-trigger"><i class="fas fa-chevron-right"></i></button>
                        </div>

                        <div class="list-group-item" style="cursor: pointer;" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                            <div>
                                <span class="label-text">Tanggal Lahir</span>
                                <p class="value-text">
                                    {!! !empty($user['dob']) ? date('d M Y', strtotime($user['dob'])) : '<span class="text-muted small fst-italic">-</span>' !!}
                                </p>
                            </div>
                            <button class="btn-edit-trigger"><i class="fas fa-chevron-right"></i></button>
                        </div>

                        <div class="list-group-item align-items-start" style="cursor: pointer;" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                            <div>
                                <span class="label-text">Alamat Rumah</span>
                                <p class="value-text lh-sm">
                                    {!! !empty($user['address']) ? $user['address'] : '<span class="text-muted small fst-italic">Belum diisi</span>' !!}
                                </p>
                            </div>
                            <button class="btn-edit-trigger mt-2"><i class="fas fa-chevron-right"></i></button>
                        </div>
                    </div>

                    <a href="{{ url('auth/logout') }}" class="nav-link text-danger fw-bold text-center border rounded-3 py-2 bg-light">
                        <i class="bi bi-box-arrow-right me-2"></i> Logout
                    </a>
                </div>
            </div>
        </div>

        <div class="col-lg-8 col-md-7 main-content-area">
             <div class="card-dashboard mb-4 p-4">
                <div class="row g-4">
                    <div class="col-md-5 border-end-md">
                        <div class="d-flex align-items-center mb-3"><i class="far fa-clock me-2 fs-5"></i><h6 class="fw-bold mb-0">Riwayat Notifikasi</h6></div>
                        
                        <div class="d-flex align-items-start gap-3 mt-4">
                            <i class="far fa-bell text-dark" style="font-size: 2.5rem;"></i>
                            <div>
                                @if(!$isDataLengkap)
                                    <div class="text-danger fw-bold text-xs mb-1">
                                        <span style="display:inline-block; width:8px; height:8px; background:red; border-radius:50%; margin-right:5px;"></span> 
                                        ACTION REQUIRED
                                    </div>
                                    <p class="text-muted text-small lh-sm mb-0">
                                        Halo, <b>{{ $user['username'] }}</b>! Profil kamu belum lengkap nih. Yuk lengkapi data diri (Alamat, No HP) agar proses pesanan lebih lancar.
                                    </p>
                                    <button class="btn btn-sm btn-link p-0 text-decoration-none small mt-1" data-bs-toggle="modal" data-bs-target="#editProfileModal">Lengkapi Sekarang &rarr;</button>
                                @else
                                    <div class="text-success fw-bold text-xs mb-1">
                                        <i class="bi bi-check-circle-fill me-1"></i> YOU'RE ALL SET!
                                    </div>
                                    <p class="text-muted text-small lh-sm mb-0">
                                        Data diri kamu sudah lengkap. Selamat berbelanja dan merakit PC impianmu!
                                    </p>
                                @endif
                            </div>
                        </div>

                    </div>
                    <div class="col-md-7">
                         <div class="row text-center gx-2 h-100">
                            <div class="col-3 position-relative">
                                <a href="{{ url('dashboard/rakitan') }}" class="order-status-box">
                                    <i class="fas fa-desktop mb-2 fs-5 text-primary"></i> <span style="font-weight: 600;">Rakitan Saya</span>
                                </a>
                                @if(isset($total_belanjaan) && $total_belanjaan > 0)
                                    <span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-warning text-dark border border-light shadow-sm" style="margin-left: 15px; margin-top: 5px; font-size: 0.65rem;">
                                        {{ $total_belanjaan }}
                                    </span>
                                @endif
                            </div>

                            <div class="col-3 position-relative">
                                <a href="{{ url('dashboard/pesanan') }}" class="order-status-box">
                                    <i class="fas fa-box-open mb-2 fs-5"></i>
                                    <span style="font-weight: 600;">Dikemas</span>
                                </a>

                                @if(isset($totalProses) && $totalProses > 0)
                                    <span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-danger border border-light shadow-sm" 
                                          style="margin-left: 15px; margin-top: 5px; font-size: 0.65rem;">
                                        {{ $totalProses }}
                                    </span>
                                @endif
                            </div>

                            <div class="col-3">
                                <a href="#" class="order-status-box">
                                    <i class="fas fa-truck mb-2 fs-5"></i> <span>Dikirim</span>
                                </a>
                            </div>
                            <div class="col-3">
                                <a href="#" class="order-status-box">
                                    <i class="fas fa-star mb-2 fs-5"></i> <span>Penilaian</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- KARTU PREVIEW PESANAN TERBARU (Pengganti 3D Model) -->
            <div class="card-dashboard p-4 shadow-sm bg-white" style="border-radius: 15px;">
                <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                    <h6 class="fw-bold mb-0">
                        <i class="fas fa-shopping-bag text-primary me-2"></i> Pesanan Terakhir
                    </h6>
                </div>

                <div class="table-responsive">
                    <table class="table table-borderless align-middle mb-0">
                        <tbody>
                            @forelse($recentOrders as $order)
                                <tr class="border-bottom">
                                    <td class="ps-0 py-3">
                                        <div class="fw-bold text-dark text-truncate" style="max-width: 250px;">{{ $order->name }}</div>
                                        <small class="text-muted">{{ date('d M Y, H:i', strtotime($order->created_at)) }}</small>
                                    </td>
                                    <td class="py-3">
                                        @if($order->status == 'draft')
                                            <span class="badge bg-warning text-dark rounded-pill px-3 py-2">Belum Dibayar</span>
                                        @elseif($order->status == 'waiting_approval')
                                            <span class="badge bg-info text-dark rounded-pill px-3 py-2">Menunggu Verifikasi</span>
                                        @else
                                            <span class="badge bg-success rounded-pill px-3 py-2">Diproses</span>
                                        @endif
                                    </td>
                                    <td class="text-end pe-0 py-3 fw-bold text-primary">
                                        Rp {{ number_format($order->total_price, 0, ',', '.') }}
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="3" class="text-center text-muted py-4">Belum ada transaksi.</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>

                <!-- Bagian Tombol Arahkan ke Pesanan Saya -->
                <div class="text-center mt-4">
                    <p class="text-muted small mb-2">Ingin memantau seluruh riwayat pesanan?</p>
                    <a href="{{ url('dashboard/pesanan') }}" class="btn btn-outline-primary rounded-pill px-4 fw-bold shadow-sm">
                        Lihat Semua Pesanan <i class="bi bi-arrow-right ms-2"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="editProfileModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow-lg">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title fw-bold">Lengkapi Data Diri</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <form id="formEditProfile">
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Nama Lengkap</label>
                        <input type="text" name="fullname" class="form-control" value="{{ $user['fullname'] }}">
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Nomor Telepon</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted">+62</span>
                            <input type="number" name="phone" class="form-control" placeholder="812..." value="{{ $user['phone'] }}">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-6">
                            <label class="form-label small fw-bold text-muted">Jenis Kelamin</label>
                            <select name="gender" class="form-select">
                                <option value="">- Pilih -</option>
                                <option value="Laki-laki" {{ $user['gender'] == 'Laki-laki' ? 'selected' : '' }}>Laki-laki</option>
                                <option value="Perempuan" {{ $user['gender'] == 'Perempuan' ? 'selected' : '' }}>Perempuan</option>
                            </select>
                        </div>
                        <div class="col-6">
                            <label class="form-label small fw-bold text-muted">Tanggal Lahir</label>
                            <input type="date" name="dob" class="form-control" value="{{ $user['dob'] }}">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted">Alamat Lengkap</label>
                        <textarea name="address" class="form-control" rows="3" placeholder="Masukkan alamat lengkap...">{{ $user['address'] }}</textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Batal</button>
                <button type="button" onclick="saveProfile()" class="btn btn-primary rounded-pill px-4">Simpan Data</button>
            </div>
        </div>
    </div>
</div>

<

<script>
    // Penambahan CSRF Token untuk Laravel pada header Fetch AJAX
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    function uploadPhoto() {
        const fileInput = document.getElementById('profilePicInput');
        if (fileInput.files.length === 0) return;

        const formData = new FormData();
        formData.append('profile_pic', fileInput.files[0]);

        Swal.fire({
            title: 'Mengupload...',
            didOpen: () => { Swal.showLoading() }
        });

        // Pastikan Rute POST dashboard/updateProfile sudah dibuat di web.php
        fetch('{{ url("dashboard/updateProfile") }}', {
            method: 'POST',
            body: formData,
            headers: { 
                'X-Requested-With': 'XMLHttpRequest',
                'X-CSRF-TOKEN': csrfToken
            }
        })
        .then(res => res.json())
        .then(data => {
            if(data.status === 'success') {
                location.reload();
            } else {
                Swal.fire('Gagal', 'Upload foto gagal.', 'error');
            }
        });
    }

    function saveProfile() {
        const form = document.getElementById('formEditProfile');
        const formData = new FormData(form);

        Swal.fire({
            title: 'Menyimpan...',
            didOpen: () => { Swal.showLoading() }
        });

        fetch('{{ url("dashboard/updateProfile") }}', {
            method: 'POST',
            body: formData,
            headers: { 
                'X-Requested-With': 'XMLHttpRequest',
                'X-CSRF-TOKEN': csrfToken
            }
        })
        .then(res => res.json())
        .then(data => {
            if(data.status === 'success') {
                Swal.fire({
                    icon: 'success',
                    title: 'Berhasil!',
                    text: 'Data diri berhasil diperbarui.',
                    timer: 1000,
                    showConfirmButton: false
                }).then(() => {
                    location.reload(); 
                });
            } else {
                Swal.fire('Gagal', data.message || 'Error sistem', 'error');
            }
        })
        .catch(err => {
            console.error(err);
            Swal.fire('Error', 'Kesalahan jaringan', 'error');
        });
    }

    document.querySelector('#pc-viewer').addEventListener('error', (event) => {
        console.error("Gagal load model 3D. Pastikan file office_pc.glb ada di folder public/assets/3d/", event);
    });
</script>
@endsection