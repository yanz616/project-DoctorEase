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
        $dentistId = Specialization::where('name', 'Dentist')->first()->id ?? null;

        Doctor::Create([
            'name'=>'Dr. Linda',
            'Specialization_id'=> $dentistId,
            'description' => 'test aja dulu',
            'photo' => 'https://i.pinimg.com/1200x/29/86/1e/29861ea3420bde3ce1dcea7051564c04.jpg'
        ]);
    }
}
