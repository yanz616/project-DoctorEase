<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Specialization;

class SpecializationSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $specialization = [
            'Dentist',
            'Stroke',
            'Heart Attack',
            'Cardiologist'
        ];

        foreach ($specialization as $name) {
            Specialization::UpdateOrCreate(
                ['name' => $name],
            );
        }
    }
}
