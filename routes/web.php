<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\DashboardController;

// Rute untuk memproses data Form (metode POST)
Route::post('/auth/registerProcess', [AuthController::class, 'registerProcess']);
Route::post('/auth/loginProcess', [AuthController::class, 'loginProcess']);

// Rute untuk Logout (menghancurkan session)
Route::get('/auth/logout', function () {
    session()->flush(); 
    return redirect('/')->with('msg', 'Kamu berhasil logout.');
});

// Rute Landing Page & Detail Produk (Katalog)
Route::get('/', [HomeController::class, 'landing']);
Route::get('/product/{id}', [HomeController::class, 'productDetail']);

// Rute untuk Kategori Dinamis (Bisa tangkap ID tunggal "1" atau multi "1,2")
Route::get('products/category/{ids?}', [HomeController::class, 'productCategory']);

// Rute Tampilan Autentikasi (UI Saja)
Route::get('/login', function () { return view('login'); });
Route::get('/register', function () { return view('register'); });

// Rute E-Commerce (Cart, Checkout, Payment)
Route::get('/cart', [CartController::class, 'index']);
Route::get('/checkout', [CartController::class, 'checkout']);
// Ganti rute payment bca yang lama jadi ini:
Route::get('/payment/bca/{id?}', [App\Http\Controllers\CartController::class, 'paymentBca']);

Route::post('/cart/add', [CartController::class, 'add']);
// Rute untuk memproses kuantitas dan hapus item keranjang via AJAX
Route::post('/cart/update', [CartController::class, 'update']);
Route::post('/cart/remove', [CartController::class, 'remove']);

// Rute Halaman Checkout
Route::get('/checkout', [CartController::class, 'checkout']);
// Rute untuk fitur Live Search AJAX di halaman depan
Route::get('/home/ajaxSearch', [HomeController::class, 'ajaxSearch']);  
Route::post('/cart/buy-now', [CartController::class, 'buyNow']);
// Rute untuk memproses data pesanan saat klik "Bayar Sekarang"
Route::post('/checkout/process', [CartController::class, 'process']);
Route::post('/cart/confirmPayment', [CartController::class, 'confirmPayment']);
// Cari rute /dashboard sementara kemarin, ganti jadi ini:
Route::get('/dashboard', [DashboardController::class, 'index']);
Route::get('/dashboard/pesanan', [DashboardController::class, 'pesanan']);
// Rute untuk menerima lemparan data form edit profil dan upload foto
Route::post('/dashboard/updateProfile', [App\Http\Controllers\DashboardController::class, 'updateProfile']);