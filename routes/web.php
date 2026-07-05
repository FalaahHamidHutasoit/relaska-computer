<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\DashboardController;

// ==========================================
// RUTE AUTENTIKASI (LOGIN & REGISTER)
// ==========================================
Route::get('/login', function () { return view('login'); });
Route::get('/register', function () { return view('register'); });
Route::post('/auth/registerProcess', [AuthController::class, 'registerProcess']);
Route::post('/auth/loginProcess', [AuthController::class, 'loginProcess']);
Route::get('/auth/logout', function () {
    session()->flush(); 
    return redirect('/')->with('msg', 'Kamu berhasil logout.');
});

// ==========================================
// RUTE KATALOG & LANDING PAGE
// ==========================================
Route::get('/', [HomeController::class, 'landing']);
Route::get('/product/{id}', [HomeController::class, 'productDetail']);
Route::get('products/category/{ids?}', [HomeController::class, 'productCategory']);
Route::get('/home/ajaxSearch', [HomeController::class, 'ajaxSearch']);

// ==========================================
// RUTE E-COMMERCE (TRANSAKSI & KERANJANG)
// ==========================================
Route::get('/cart', [CartController::class, 'index']);
Route::post('/cart/add', [CartController::class, 'add']);
Route::post('/cart/update', [CartController::class, 'update']);
Route::post('/cart/remove', [CartController::class, 'remove']);
Route::post('/cart/buy-now', [CartController::class, 'buyNow']);

// Checkout & Pembayaran
Route::get('/checkout', [CartController::class, 'checkout']);
Route::post('/checkout/process', [CartController::class, 'process']);
Route::get('/payment/bca/{id?}', [CartController::class, 'paymentBca']);
Route::post('/cart/confirmPayment', [CartController::class, 'confirmPayment']);

// ==========================================
// RUTE DASHBOARD USER (PROFIL & PESANAN)
// ==========================================
Route::get('/dashboard', [DashboardController::class, 'index']);
Route::get('/dashboard/pesanan', [DashboardController::class, 'pesanan']);
Route::post('/dashboard/updateProfile', [DashboardController::class, 'updateProfile']);

// ==========================================
// RUTE EKSKLUSIF (PC BUILDER & GENERATOR DATA)
// ==========================================
// Rute Halaman Coming Soon PC Builder
Route::get('/builder', function () {
    return view('builder');
});

// Rute Generator Data Dummy 6 Bulan (Buat Regresi UTS)
Route::get('/generate-history', function () {
    $products = \Illuminate\Support\Facades\DB::table('products')->get();
    $historyData = [];
    $now = now();

    foreach ($products as $product) {
        $basePrice = $product->price;

        for ($i = 6; $i >= 1; $i--) {
            $randomFluctuation = rand(-10, 10) / 100; 
            $historicalPrice = $basePrice + ($basePrice * $randomFluctuation);

            $historyData[] = [
                'product_id' => $product->id,
                'price' => $historicalPrice,
                'recorded_date' => $now->copy()->subMonths($i)->format('Y-m-d'), 
                'created_at' => now(),
                'updated_at' => now(),
            ];
        }
    }

    \Illuminate\Support\Facades\DB::table('product_price_histories')->insert($historyData);

    return "Mantap! Data riwayat harga 6 bulan terakhir untuk semua komponen berhasil di-generate!";
});