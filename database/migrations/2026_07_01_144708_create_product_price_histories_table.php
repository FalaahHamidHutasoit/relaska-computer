<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('product_price_histories', function (Blueprint $table) {
            $table->id();
            // Menyambungkan ke tabel products milikmu
            $table->unsignedBigInteger('product_id'); 
            
            // Menyimpan harga pada bulan tersebut
            $table->decimal('price', 15, 2); 
            
            // Mencatat kapan harga ini berlaku (Bulan & Tahun)
            $table->date('recorded_date'); 
            
            $table->timestamps();

            // Relasi ON DELETE CASCADE (Kalau produk dihapus, riwayatnya ikut terhapus)
            $table->foreign('product_id')->references('id')->on('products')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('product_price_histories');
    }
};