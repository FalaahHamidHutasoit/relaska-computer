<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Product;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        \App\Models\Product::query()->delete(); // Kosongkan dummy

        // Panggil nama file yang kamu drag
        $sql = file_get_contents(database_path('db_pcbuilder.sql')); 
        \Illuminate\Support\Facades\DB::unprepared($sql);
    }
}