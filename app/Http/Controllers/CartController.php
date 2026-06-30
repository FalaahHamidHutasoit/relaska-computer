<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CartController extends Controller
{
    // Tambahkan ini di bawah fungsi add() yang kemarin
    public function index()
    {
        // Ambil isi keranjang
        $cart = session()->get('cart', []);
        
        // Ambil ID semua produk yang ada di keranjang
        $productIds = array_keys($cart);
        
        // Panggil database untuk mengambil detail produknya
        $products = \Illuminate\Support\Facades\DB::table('products')
                    ->whereIn('id', $productIds)
                    ->get()
                    ->keyBy('id'); // Jadikan ID sebagai kunci array agar mudah dipanggil

        return view('cart', compact('cart', 'products'));
    }

    public function add(Request $request)
    {
        // 1. Tangkap data yang dikirim oleh fetch JavaScript
        $productId = $request->product_id;
        $quantity = (int) $request->quantity;

        // 2. Buka brankas Session keranjang (jika kosong, buat array baru)
        $cart = session()->get('cart', []);

        // 3. Logika Cerdas: Cek apakah barang sudah ada di keranjang
        if(isset($cart[$productId])) {
            // Jika sudah ada, cukup tambahkan jumlah (qty)-nya saja
            $cart[$productId]['quantity'] += $quantity;
        } else {
            // Jika belum ada, buat kotak baru untuk produk tersebut
            $cart[$productId] = [
                'quantity' => $quantity
            ];
        }

        // 4. Simpan kembali data terbaru ke dalam brankas Session
        session()->put('cart', $cart);

        // 5. Kirim balasan JSON dengan status sukses agar ditangkap oleh SweetAlert
        // Kita hitung jumlah item unik di keranjang untuk mengupdate angka di Navbar
        return response()->json([
            'status' => 'success',
            'cart_count' => count($cart)
        ]);
    }

    // Fungsi mengubah jumlah barang
    public function update(Request $request)
    {
        $id = $request->id;
        $qty = $request->quantity;
        $cart = session()->get('cart', []);
        
        if(isset($cart[$id])) {
            $cart[$id]['quantity'] = $qty;
            session()->put('cart', $cart);
            return response()->json(['status' => 'success']);
        }
        return response()->json(['status' => 'error']);
    }

    // Fungsi menghapus barang sepenuhnya
    public function remove(Request $request)
    {
        $id = $request->id;
        $cart = session()->get('cart', []);
        
        if(isset($cart[$id])) {
            unset($cart[$id]); // Hapus dari memori array
            session()->put('cart', $cart);
            return response()->json([
                'status' => 'success',
                'cart_count' => count($cart) // Kirim sisa item untuk update Navbar
            ]);
        }
        return response()->json(['status' => 'error']);
    }

    // Menampilkan Halaman Checkout
    public function checkout(Request $request)
    {
        // 1. Cek dari URL, apakah user masuk lewat jalur "Beli Sekarang"?
        $mode = $request->query('mode');

        if ($mode === 'buynow') {
            // Jika ya, buka brankas VIP
            $cart = session()->get('buy_now_cart', []);
        } else {
            // Jika tidak, buka brankas keranjang biasa
            $cart = session()->get('cart', []);
        }
        
        // 2. Cegah user masuk kalau kosong
        if(empty($cart)) {
            return redirect('/cart')->with('msg', 'Tidak ada barang untuk diproses!');
        }
        
        // 3. Ambil data produk dari database seperti biasa
        $productIds = array_keys($cart);
        $products = \Illuminate\Support\Facades\DB::table('products')
                    ->whereIn('id', $productIds)
                    ->get()
                    ->keyBy('id');
                    
        return view('checkout', compact('cart', 'products', 'mode'));
    }

    // Fungsi khusus untuk Beli Sekarang
    public function buyNow(Request $request)
    {
        $productId = $request->product_id;
        $quantity = (int) $request->quantity;

        // Bikin keranjang khusus jalur VIP
        $buyNowCart = [
            $productId => [
                'quantity' => $quantity
            ]
        ];

        // Simpan ke session BARU bernama 'buy_now_cart' 
        session()->put('buy_now_cart', $buyNowCart);

        return response()->json([
            'status' => 'success'
        ]);

        // 4. Simpan ke session
        session()->put('cart', $cart);

        return response()->json([
            'status' => 'success'
        ]);
    }

    // Menampilkan Halaman Pembayaran BCA
    public function paymentBCA($id = null)
    {
        $username = session('username');
        $user = \Illuminate\Support\Facades\DB::table('users')->where('username', $username)->first();

        if (!$user) return redirect('/')->with('error', 'Silakan login terlebih dahulu.');

        if ($id) {
            // Jika user ngeklik "Lanjut Bayar" dari tabel Pesanan Saya
            $order = \Illuminate\Support\Facades\DB::table('builds')
                ->where('id', $id)
                ->where('user_id', $user->id)
                ->first();
        } else {
            // Jika user baru aja checkout (Otomatis ambil tagihan terbaru)
            $order = \Illuminate\Support\Facades\DB::table('builds')
                ->where('user_id', $user->id)
                ->where('status', 'draft')
                ->orderBy('id', 'desc')
                ->first();
        }

        if (!$order) return redirect('/')->with('msg', 'Transaksi tidak ditemukan.');

        return view('payment-bca', compact('order'));
    }

    // Memproses data form checkout
    // Memproses data form checkout
    public function process(Request $request)
    {
        // 1. Ambil data user yang sedang login
        $username = session('username');
        $user = \Illuminate\Support\Facades\DB::table('users')->where('username', $username)->first();

        if (!$user) {
            return response()->json(['status' => 'error', 'message' => 'Sesi login tidak valid.']);
        }

        // 2. Tentukan Keranjang Mana yang Diproses (Keranjang Biasa vs Beli Sekarang)
        $mode = $request->input('mode');
        if ($mode === 'buynow') {
            $cart = session()->get('buy_now_cart', []);
        } else {
            $cart = session()->get('cart', []);
        }

        if (empty($cart)) {
            return response()->json(['status' => 'error', 'message' => 'Keranjang kosong.']);
        }

        // 3. Kalkulasi Total Harga Murni dari Database
        $productIds = array_keys($cart);
        $products = \Illuminate\Support\Facades\DB::table('products')->whereIn('id', $productIds)->get()->keyBy('id');

        $total_price = 0;
        foreach ($cart as $id => $details) {
            if (isset($products[$id])) {
                $total_price += $products[$id]->price * $details['quantity'];
            }
        } // <-- FOREACH DITUTUP DI SINI

        // BIKIN LOGIC NAMA PESANAN PINTAR
        $firstProductId = array_key_first($cart);
        $firstProductName = isset($products[$firstProductId]) ? $products[$firstProductId]->name : 'Komponen PC';

        if (count($cart) == 1) {
            $orderName = $firstProductName;
        } else {
            $orderName = $firstProductName . ' + ' . (count($cart) - 1) . ' item lainnya';
        }

        // Tambahkan ongkir tetap dan biaya layanan
        $total_price += 35000 + 2000;

        // 4. Simpan ke tabel `builds` (Sebagai Struk Utama/Header)
        $build_id = \Illuminate\Support\Facades\DB::table('builds')->insertGetId([
            'user_id'     => $user->id,
            'name'        => $orderName, // <-- SEKARANG MENGGUNAKAN VARIABEL NAMA PINTAR
            'total_price' => $total_price,
            'status'      => 'draft',
            'type'        => 'order',
            'created_at'  => now(),
            'updated_at'  => now()
        ]);

        // 5. Simpan ke tabel `build_items` (Sebagai Rincian Barang)
        $buildItemsData = [];
        foreach ($cart as $id => $details) {
            if (isset($products[$id])) {
                $buildItemsData[] = [
                    'build_id'          => $build_id,
                    'product_id'        => $id,
                    'quantity'          => $details['quantity'],
                    'price_at_purchase' => $products[$id]->price
                ];
            }
        }
        \Illuminate\Support\Facades\DB::table('build_items')->insert($buildItemsData);

        // 6. Kembalikan respon sukses
        return response()->json([
            'status' => 'success',
            'message' => 'Pesanan berhasil diamankan.'
        ]);
    }

    // Fungsi untuk mengonfirmasi pembayaran
    public function confirmPayment(\Illuminate\Http\Request $request)
    {
        $username = session('username');
        $user = \Illuminate\Support\Facades\DB::table('users')->where('username', $username)->first();
        
        // Tangkap ID yang dikirim dari JS
        $order_id = $request->input('order_id'); 

        if ($user && $order_id) {
            // HANYA update pesanan dengan ID yang dibayar ini saja
            \Illuminate\Support\Facades\DB::table('builds')
                ->where('id', $order_id)
                ->where('user_id', $user->id)
                ->update(['status' => 'waiting_approval']);
        }

        session()->forget('cart');
        session()->forget('buy_now_cart');

        return response()->json(['status' => 'success']);
    }
}