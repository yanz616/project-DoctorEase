<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Doctor;
use App\Models\Specialization;

class DoctorController extends Controller
{
    public function index()
    {
        $doctors = Doctor::with('specialization')->get();

        return response()->json($doctors);
    }

    public function getDoctorsBySpecialization($specializationId)
    {
        $doctors = Specialization::with('doctors')->findOrFail($specializationId);

        return response()->json([
            'specialization' => $doctors->name,
            'data' => $doctors->doctors
        ]);
    }

}
