<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Doctor;
use App\Models\Specialization;

class DoctorController extends Controller
{
    public function index()
    {
        // ambil semua doctor dengan spesialisasinya
        $doctors = Doctor::with('specialization')->get();
        return response()->json($doctors);
    }

    public function show($id)
    {
        // ambil 1 doctor by id dengan spesialisasinya
        $doctor = Doctor::with('specialization')->findOrFail($id);
        return response()->json($doctor);
    }

}
