<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->foreignId('category_id')->constrained('categories')->onDelete('cascade');
            $table->string('name');
            $table->integer('stock')->default(0);
            $table->decimal('price', 15, 2);
            $table->integer('tier')->default(1);
            $table->integer('capacity')->default(0);
            $table->string('image')->nullable();
            $table->text('description')->nullable();
            $table->string('brand', 100)->nullable();
            $table->string('socket_type', 50)->nullable();
            $table->string('memory_type', 20)->nullable();
            $table->integer('wattage')->nullable();
            $table->string('form_factor', 50)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
