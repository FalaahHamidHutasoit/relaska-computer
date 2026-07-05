<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    public function landing()
    {
        return view('landing');
    }

    public function productDetail($id)
    {
        // Mengambil 1 data produk spesifik berdasarkan ID dari database MySQL
        $product = \App\Models\Product::findOrFail($id);

        // 1. Ambil data produk (asumsi ID produk didapat dari parameter URL)
        // $product = \Illuminate\Support\Facades\DB::table('products')->where('id', $id)->first();

        // 2. Tarik riwayat harga 6 bulan terakhir dari yang terlama ke terbaru (ASC)
        $histories = \Illuminate\Support\Facades\DB::table('product_price_histories')
            ->where('product_id', $id) // Sesuaikan dengan id produk yang sedang dilihat
            ->orderBy('recorded_date', 'asc')
            ->get();

        // 3. VARIABEL DEFAULT JIKA DATA KOSONG
        $trendScore = 50; // Jarum speedometer di tengah (0-100)
        $trendStatus = "Data Kurang";
        $trendColor = "text-secondary"; // Warna teks (Opsional untuk UI)

        // 4. MESIN REGRESI LINEAR SEDERHANA
        $n = count($histories);
        if ($n > 1) {
            $sumX = 0; $sumY = 0; $sumXY = 0; $sumX2 = 0;
            $x = 1; // Sumbu X adalah waktu (Bulan 1, 2, 3...)

            foreach ($histories as $history) {
                $y = $history->price; // Sumbu Y adalah harga
                $sumX += $x;
                $sumY += $y;
                $sumXY += ($x * $y);
                $sumX2 += ($x * $x);
                $x++;
            }

            // Rumus mencari B (Slope/Kemiringan Tren)
            $pembilang = ($n * $sumXY) - ($sumX * $sumY);
            $penyebut = ($n * $sumX2) - ($sumX * $sumX);
            $slope = ($penyebut != 0) ? ($pembilang / $penyebut) : 0;

            // 5. INTERPRETASI SLOPE MENJADI SKOR SPEEDOMETER (0 - 100)
            if ($slope > 50000) { 
                // Harga naik drastis (> Rp 50.000 / bulan)
                $trendScore = 90; // Jarum mentok kanan
                $trendStatus = "Sangat Mahal (Tunda Beli)";
                $trendColor = "text-danger";
            } elseif ($slope > 0) { 
                // Harga mulai naik
                $trendScore = 70;
                $trendStatus = "Tren Naik";
                $trendColor = "text-warning";
            } elseif ($slope < -50000) { 
                // Harga turun drastis (Diskon besar-besaran)
                $trendScore = 10; // Jarum mentok kiri
                $trendStatus = "Sangat Murah (Beli Sekarang!)";
                $trendColor = "text-success";
            } elseif ($slope < 0) { 
                // Harga mulai turun
                $trendScore = 30;
                $trendStatus = "Tren Turun (Aman Dibeli)";
                $trendColor = "text-success";
            } else { 
                // Harga Stabil
                $trendScore = 50; // Jarum di tengah
                $trendStatus = "Harga Normal / Stabil";
                $trendColor = "text-primary";
            }
        }
        // 6. Lempar hasil regresi ke View Blade
        return view('product-detail', [
            'product'     => $product, // <-- Tanda // dihapus supaya datanya ikut terlempar
            'trendScore'  => $trendScore,
            'trendStatus' => $trendStatus,
            'trendColor'  => $trendColor
        ]);
    }

    public function productCategory(\Illuminate\Http\Request $request, $ids = 'all')
    {
        $brand = $request->query('brand');
        $query = \App\Models\Product::query();

        if ($ids !== 'all') {
            $categoryIds = explode(',', $ids);
            $query->whereIn('category_id', $categoryIds);
            $title = 'Kategori Pilihan';
            $selected_cats = $categoryIds;
        } else {
            $title = 'Semua Produk'; 
            $selected_cats = ['all'];
        }

        if ($brand) {
            $query->where('brand', $brand);
        }

        // Tetap pakai paginate(12) agar backend ringan
        $products = $query->orderBy('tier', 'desc')->orderBy('created_at', 'desc')->paginate(12);

        // 🌟 KEAJAIBAN INFINITE SCROLL: Jika request dari AJAX, kirim potongan HTML saja
        if ($request->ajax()) {
            return view('product_cards', compact('products'))->render();
        }

        return view('category', [
            'products'       => $products,
            'title'          => $title,
            'selected_cats'  => $selected_cats,
            'selected_brand' => $brand
        ]);
    }

    public function ajaxSearch(\Illuminate\Http\Request $request)
    {
        $query = $request->query('query');

        // Jika ketikan kosong, kembalikan array kosong
        if (!$query) {
            return response()->json([]);
        }

        // Cari produk yang namanya mengandung kata kunci
        $products = \App\Models\Product::where('name', 'like', '%' . $query . '%')
                    ->limit(5) // Batasi 5 hasil saja biar dropdown rapi
                    ->get(['id', 'name', 'price', 'category_id']);

        return response()->json($products);
    }
}