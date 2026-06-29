<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Seeder;

class CategorySeeder extends Seeder
{
    public function run(): void
    {
        $categories = [
            ['name' => 'Processor', 'slug' => 'processor'],
            ['name' => 'Motherboard', 'slug' => 'motherboard'],
            ['name' => 'RAM', 'slug' => 'ram'],
            ['name' => 'VGA', 'slug' => 'vga'],
            ['name' => 'Storage', 'slug' => 'storage'],
            ['name' => 'Power Supply', 'slug' => 'psu'],
            ['name' => 'Casing', 'slug' => 'case'],
            ['name' => 'CPU Cooler', 'slug' => 'cooler'],
        ];

        foreach ($categories as $category) {
            Category::create($category);
        }
    }
}
