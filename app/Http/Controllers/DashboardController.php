<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    // Fungsi untuk Halaman Profil
    public function index()
    {
        // 1. Ambil data user dari database
        $username = session('username');
        $user = \Illuminate\Support\Facades\DB::table('users')->where('username', $username)->first();

        // 2. Logic Cek Kelengkapan Profil
        $isDataLengkap = !empty($user->phone) && !empty($user->gender) && !empty($user->dob) && !empty($user->address);

        // 3. Hitung Statistik Pesanan Asli dari Database
        $total_belanjaan = \Illuminate\Support\Facades\DB::table('builds')
            ->where('user_id', $user->id)
            ->where('status', 'draft')
            ->count();

        $totalProsesDB = \Illuminate\Support\Facades\DB::table('builds')
            ->where('user_id', $user->id)
            ->whereIn('status', ['waiting_approval', 'paid', 'processing'])
            ->count();

        // --- DATA TAB 1: RAKITAN SAYA (Asli dari Database) ---
        $rakitanOrders = \Illuminate\Support\Facades\DB::table('builds')
            ->where('user_id', $user->id)
            ->where('type', '!=', 'order') 
            ->orderBy('id', 'desc')
            ->get();

        // --- DATA TAB 2: DIKEMAS (Database + Dummy jika kosong) ---
        $dikemasOrders = \Illuminate\Support\Facades\DB::table('builds')
            ->where('user_id', $user->id)
            ->whereIn('status', ['waiting_approval', 'paid', 'processing'])
            ->orderBy('id', 'desc')
            ->get();

        // Jika data dikemas asli kosong, kita kasih dummy biar tampilan tetap ramai!
        if ($dikemasOrders->isEmpty()) {
            $dikemasOrders = collect([
                (object)[
                    'name' => 'MSI GeForce RTX 4070 Super 12GB',
                    'total_price' => 10500000,
                    'updated_at' => now()->subHours(2),
                    'dummy_resi' => '-'
                ],
                (object)[
                    'name' => 'Corsair Vengeance RGB 32GB (2x16GB) DDR5',
                    'total_price' => 1850000,
                    'updated_at' => now()->subHours(5),
                    'dummy_resi' => '-'
                ]
            ]);
            $totalProses = 2; // Badge angka jadi 2
        } else {
            $totalProses = $totalProsesDB;
        }

        // --- DATA TAB 3: DIKIRIM (Khusus Data Dummy Simulasi) ---
        $dikirimOrders = collect([
            (object)[
                'name' => 'Samsung 990 PRO NVMe M.2 SSD 2TB',
                'total_price' => 2950000,
                'updated_at' => now()->subDays(1),
                'dummy_resi' => 'JNE - RLK99283741'
            ],
            (object)[
                'name' => 'NZXT Kraken Elite 360 RGB Liquid Cooler',
                'total_price' => 4200000,
                'updated_at' => now()->subDays(2),
                'dummy_resi' => 'JNT - RLK88123456'
            ]
        ]);

        // --- DATA TAB 4: PENILAIAN / SELESAI (Khusus Data Dummy Simulasi) ---
        $penilaianOrders = collect([
            (object)[
                'name' => 'LG UltraGear 27" QHD 165Hz Gaming Monitor',
                'total_price' => 4500000,
                'updated_at' => now()->subDays(5),
                'status_rating' => 'Belum Dinilai'
            ],
            (object)[
                'name' => 'Logitech G PRO X Superlight Wireless Mouse',
                'total_price' => 1950000,
                'updated_at' => now()->subDays(7),
                'status_rating' => 'Belum Dinilai'
            ]
        ]);

        // Lempar semua datanya ke View Blade
        return view('dashboard', [
            'user'            => (array) $user, 
            'isDataLengkap'   => $isDataLengkap,
            'total_belanjaan' => $total_belanjaan,
            'totalProses'     => $totalProses,
            'rakitanOrders'   => $rakitanOrders,
            'dikemasOrders'   => $dikemasOrders,
            'dikirimOrders'   => $dikirimOrders,
            'penilaianOrders' => $penilaianOrders,
        ]);
    }
    
    // Fungsi untuk Halaman Riwayat Pesanan
    public function pesanan()
    {
        $username = session('username');
        $user = DB::table('users')->where('username', $username)->first();

        // Ambil semua transaksi milik user ini, urutkan dari yang paling baru
        $orders = DB::table('builds')
            ->where('user_id', $user->id)
            ->orderBy('created_at', 'desc')
            ->get();

        return view('pesanan', compact('orders'));
    }

    // Fungsi untuk memproses Edit Data Diri & Upload Foto
    public function updateProfile(\Illuminate\Http\Request $request)
    {
        $username = session('username');
        
        // Siapkan keranjang data yang mau di-update ke tabel users
        $updateData = [
            'updated_at' => now()
        ];

        // 1. Cek apakah ada inputan teks yang dikirim (dari form Edit Data Diri)
        if ($request->has('fullname')) {
            $updateData['fullname'] = $request->input('fullname');
            $updateData['phone']    = $request->input('phone');
            $updateData['gender']   = $request->input('gender');
            $updateData['dob']      = $request->input('dob');
            $updateData['address']  = $request->input('address');
        }

        // 2. Cek apakah ada file foto yang di-upload (dari ikon Kamera)
        if ($request->hasFile('profile_pic')) {
            $file = $request->file('profile_pic');
            
            // Bikin nama file unik biar nggak bentrok (contoh: 17098273_foto.jpg)
            $filename = time() . '_' . $file->getClientOriginalName();
            
            // Pindahkan file fisik ke folder public/assets/img/profiles/
            $file->move(public_path('assets/img/profiles'), $filename);
            
            // Masukkan nama filenya ke keranjang data
            $updateData['profile_pic'] = $filename;
        }

        // 3. Eksekusi query UPDATE ke database
        $updateStatus = \Illuminate\Support\Facades\DB::table('users')
            ->where('username', $username)
            ->update($updateData);

        if ($updateStatus !== false) {
            // Jika berhasil, balas dengan status success agar JS bisa me-reload halaman
            return response()->json([
                'status' => 'success',
                'message' => 'Data profil berhasil diperbarui.'
            ]);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Gagal memperbarui profil di database.'
            ]);
        }
    }
}