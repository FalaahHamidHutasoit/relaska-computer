<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    public function landing()
    {
        // 4 ID Produk Bintang (Intel i9, Samsung 990, Ryzen 9, MSI A520M)
        $highlightIds = [10, 95, 5, 21];
        $radarItems = [];

        foreach ($highlightIds as $id) {
            $product = \App\Models\Product::find($id);
            if (!$product) continue;

            $histories = \Illuminate\Support\Facades\DB::table('product_price_histories')
                ->where('product_id', $id)
                ->orderBy('recorded_date', 'asc')
                ->get();

            $n = count($histories);
            // Default Status
            $trendScore = 50; 
            $trendStatus = "Harga Stabil";
            $trendColor = "text-warning";
            $desc = "Data kurang untuk diprediksi";

            if ($n > 1) {
                $sumX = 0; $sumY = 0; $sumXY = 0; $sumX2 = 0;
                $x = 1; // Sumbu X mewakili urutan bulan (1, 2, 3...)
                foreach ($histories as $history) {
                    $y = $history->price; // Sumbu Y mewakili harga
                    $sumX += $x;
                    $sumY += $y;
                    $sumXY += ($x * $y);
                    $sumX2 += ($x * $x);
                    $x++;
                }

                // Kalkulasi Regresi Linear (Least Squares)
                $penyebut = ($n * $sumX2) - ($sumX * $sumX);
                $m = ($penyebut != 0) ? (($n * $sumXY) - ($sumX * $sumY)) / $penyebut : 0;
                $b = ($n > 0) ? ($sumY - $m * $sumX) / $n : 0;

                // Prediksi untuk periode berikutnya (Bulan ke n+1)
                $nextX = $n + 1;
                $prediksiHarga = ($m * $nextX) + $b;
                $hargaSekarang = $product->price;

                // Kalkulasi Persentase Perubahan
                $persentase = ($hargaSekarang > 0) ? (($prediksiHarga - $hargaSekarang) / $hargaSekarang) * 100 : 0;

                // Logika Validasi (Toleransi 5%)
                if ($persentase > 5) {
                    $trendScore = 15; // Jarum ke kiri (Hijau - Beli)
                    $trendStatus = "Harga akan naik, beli sekarang";
                    $trendColor = "text-success";
                    $desc = "Prediksi naik " . number_format($persentase, 1) . "%";
                } elseif ($persentase < -5) {
                    $trendScore = 85; // Jarum ke kanan (Merah - Tunda)
                    $trendStatus = "Harga akan turun, tahan dulu";
                    $trendColor = "text-danger";
                    $desc = "Prediksi turun " . number_format(abs($persentase), 1) . "%";
                } else {
                    $trendScore = 50; // Jarum di tengah (Kuning - Stabil)
                    $trendStatus = "Harga stabil";
                    $trendColor = "text-warning";
                    $desc = "Rentang " . number_format(abs($persentase), 1) . "%";
                }
            }

            $radarItems[] = [
                'id' => $product->id,
                'name' => $product->name,
                'price' => number_format($product->price, 0, ',', '.'),
                'img' => $product->name . '.png',
                'score' => $trendScore,
                'status' => $trendStatus,
                'color' => $trendColor,
                'desc' => $desc
            ];
        }

        // Lempar data asli hasil kalkulasi ke view landing
        return view('landing', compact('radarItems'));
    }

    public function productDetail($id)
    {
        $product = \App\Models\Product::findOrFail($id);

        $histories = \Illuminate\Support\Facades\DB::table('product_price_histories')
            ->where('product_id', $id)
            ->orderBy('recorded_date', 'asc')
            ->get();

        $n = count($histories);
        $trendScore = 50; 
        $trendStatus = "Harga Stabil";
        $trendColor = "text-warning";

        if ($n > 1) {
            $sumX = 0; $sumY = 0; $sumXY = 0; $sumX2 = 0;
            $x = 1;
            foreach ($histories as $history) {
                $y = $history->price;
                $sumX += $x;
                $sumY += $y;
                $sumXY += ($x * $y);
                $sumX2 += ($x * $x);
                $x++;
            }

            $penyebut = ($n * $sumX2) - ($sumX * $sumX);
            $m = ($penyebut != 0) ? (($n * $sumXY) - ($sumX * $sumY)) / $penyebut : 0;
            $b = ($n > 0) ? ($sumY - $m * $sumX) / $n : 0;

            $nextX = $n + 1;
            $prediksiHarga = ($m * $nextX) + $b;
            $hargaSekarang = $product->price;
            $persentase = ($hargaSekarang > 0) ? (($prediksiHarga - $hargaSekarang) / $hargaSekarang) * 100 : 0;

            if ($persentase > 5) {
                $trendScore = 15; 
                $trendStatus = "Harga akan naik, beli sekarang";
                $trendColor = "text-success";
            } elseif ($persentase < -5) {
                $trendScore = 85; 
                $trendStatus = "Harga akan turun, tahan dulu";
                $trendColor = "text-danger";
            } else {
                $trendScore = 50; 
                $trendStatus = "Harga stabil";
                $trendColor = "text-warning";
            }
        }

        return view('product-detail', [
            'product'     => $product,
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