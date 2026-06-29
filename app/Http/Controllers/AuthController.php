<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    // --- MESIN 1: PROSES DAFTAR AKUN BARU (REGISTER) ---
    public function registerProcess(Request $request)
    {
        // 1. Validasi input form
        $request->validate([
            'fullname' => 'required|string|max:255',
            'username' => 'required|string|max:255',
            'password' => 'required|string|min:6',
        ]);

        // 2. Simpan ke database MySQL, password diamankan dengan Hash
        DB::table('users')->insert([
            'fullname'     => $request->fullname,
            'username' => $request->username,
            'password' => Hash::make($request->password),
        ]);

        // 3. Set memori session agar langsung login
        session([
            'logged_in' => true,
            'username'  => $request->username,
            'role'      => 'user'
        ]);

        // 4. Redirect ke halaman tujuan atau halaman utama
        if ($request->filled('redirect')) {
            return redirect($request->redirect);
        }
        return redirect('/');
    }

    // --- MESIN 2: PROSES MASUK AKUN (LOGIN) ---
    public function loginProcess(Request $request)
    {
        // 1. Validasi input form
        $request->validate([
            'username' => 'required|string',
            'password' => 'required|string',
        ]);

        // 2. Cari user di database berdasarkan username
        $user = DB::table('users')->where('username', $request->username)->first();

        // 3. Cek apakah user ada dan passwordnya cocok
        if ($user && Hash::check($request->password, $user->password)) {
            
            // 4. Set memori session jika berhasil
            session([
                'logged_in' => true,
                'username'  => $user->username,
                'role'      => $user->role ?? 'user'
            ]);

            // 5. Redirect ke halaman tujuan atau halaman utama
            if ($request->filled('redirect')) {
                return redirect($request->redirect);
            }
            return redirect('/');
        }

        // 6. Jika gagal, tendang balik ke form login beserta pesan error
        return back()->with('msg', 'Username atau Password salah, silakan coba lagi!');
    }
}