<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    // Fungsi untuk Halaman Profil
    public function index()
    {
        // 1. Ambil data user yang sedang login
        $username = session('username');
        $user = DB::table('users')->where('username', $username)->first();

        // 2. Hitung statistik pesanan dari tabel builds
        $total_belanjaan = DB::table('builds')
            ->where('user_id', $user->id)
            ->where('status', 'draft') // Belum dibayar
            ->count();

        $totalProses = DB::table('builds')
            ->where('user_id', $user->id)
            ->whereIn('status', ['waiting_approval', 'paid']) // Sedang diproses admin
            ->count();

        // 3. Lempar data asli ke view dashboard
        // Kita ubah object $user jadi array karena view kita pakai sintaks $user['fullname']
        return view('dashboard', [
            'user' => (array) $user, 
            'total_belanjaan' => $total_belanjaan,
            'totalProses' => $totalProses,
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
}