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

        // 3. Hitung Statistik Pesanan
        $total_belanjaan = \Illuminate\Support\Facades\DB::table('builds')
            ->where('user_id', $user->id)
            ->where('status', 'draft')
            ->count();

        $totalProses = \Illuminate\Support\Facades\DB::table('builds')
            ->where('user_id', $user->id)
            ->whereIn('status', ['waiting_approval', 'paid'])
            ->count();

        // --- TAMBAHAN BARU: Tarik 3 pesanan terakhir dari Database ---
        $recentOrders = \Illuminate\Support\Facades\DB::table('builds')
            ->where('user_id', $user->id)
            ->orderBy('id', 'desc')
            ->limit(3)
            ->get();
        // -------------------------------------------------------------

        // 4. Lempar SEMUA data ke view (Pastiin 'recentOrders' tertulis di sini!)
        return view('dashboard', [
            'user'            => (array) $user, 
            'isDataLengkap'   => $isDataLengkap,
            'total_belanjaan' => $total_belanjaan,
            'totalProses'     => $totalProses,
            'recentOrders'    => $recentOrders, // <-- INI YANG BIKIN ERROR MERAH KALAU KELUPAAN
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