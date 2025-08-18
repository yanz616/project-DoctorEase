<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Doctor;
use App\Models\Specialization;

class DoctorSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $doctors = [
            [
                'name'              => 'Dr. John Doe',
                'specialization_id' => 1, // Cardiology
                'photo'             => 'https://via.placeholder.com/150'
            ],
            [
                'name'              => 'Dr. Sarah Smith',
                'specialization_id' => 2, // Neurology
                'photo'             => 'https://via.placeholder.com/150'
            ],
            [
                'name'              => 'Dr. Michael Johnson',
                'specialization_id' => 3, // Dermatology
                'photo'             => 'https://via.placeholder.com/150'
            ]
        ];

        foreach ($doctors as $doctor) {
            Doctor::create($doctor);
        }
    }
}
