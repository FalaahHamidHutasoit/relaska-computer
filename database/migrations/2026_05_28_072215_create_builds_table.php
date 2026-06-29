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
        Schema::create('builds', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained('users')->onDelete('set null');
            $table->string('name', 100)->default('Rakitan User');
            $table->string('category', 50)->nullable();
            $table->decimal('total_price', 15, 2)->nullable();
            $table->enum('status', ['draft', 'waiting_approval', 'paid', 'rejected'])->default('draft');
            $table->enum('type', ['build', 'order'])->default('build');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('builds');
    }
};
