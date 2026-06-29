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
    public function paymentBCA(Request $request)
    {
        // Kita cek apakah user datang dari jalur VIP (Beli Sekarang) atau Keranjang Biasa
        $mode = $request->query('mode');
        
        if ($mode === 'buynow') {
            $cart = session()->get('buy_now_cart', []);
        } else {
            $cart = session()->get('cart', []);
        }

        // Jika tidak ada transaksi aktif, kembalikan ke halaman utama
        if (empty($cart)) {
            return redirect('/')->with('msg', 'Tidak ada transaksi yang perlu dibayar.');
        }

        // Ambil detail produk untuk menghitung total nominal yang harus dibayar di halaman BCA
        $productIds = array_keys($cart);
        $products = \Illuminate\Support\Facades\DB::table('products')
                    ->whereIn('id', $productIds)
                    ->get()
                    ->keyBy('id');

        // Lempar data ke view payment-bca
        return view('payment-bca', compact('cart', 'products', 'mode'));
    }

    // Memproses data form checkout
    public function process(Request $request)
    {
        // Sebagai Backend Developer sejati, nanti di dalam fungsi ini kamu bakal:
        // 1. Validasi alamat pengiriman
        // 2. Simpan data ke tabel `builds`
        // 3. Simpan detail produk ke tabel `build_items`
        // 4. Hapus memori session keranjang
        
        // Tapi untuk sekarang, kita paksa balas "sukses" agar JavaScript 
        // bisa melompat ke halaman BCA!
        return response()->json([
            'status' => 'success',
            'message' => 'Pesanan berhasil diamankan.'
        ]);
    }

    // Fungsi untuk mengonfirmasi pembayaran
    public function confirmPayment(Request $request)
    {
        // Sebagai Backend Dev, nanti di sini kamu bikin query buat:
        // Update status transaksi di database dari 'Pending' menjadi 'Menunggu Verifikasi'

        // Karena pesanan sudah dibayar/dikonfirmasi, kita kosongkan keranjangnya
        session()->forget('cart');
        session()->forget('buy_now_cart');

        // Balas ke frontend (SweetAlert) bahwa proses sukses
        return response()->json([
            'status' => 'success',
            'message' => 'Pembayaran berhasil dikonfirmasi'
        ]);
    }
}