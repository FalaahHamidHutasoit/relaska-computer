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
        
        // Langsung dilempar ke view detail yang sudah ada
        return view('product-detail', compact('product'));
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