<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Specialization;


class SpecializationController extends Controller
{

    public function index()
    {
        return response()->json(Specialization::all(),201);
    }

    public function show($id)
    {
        // tampilkan spesialisasi dengan daftar dokternya
        $specialization = Specialization::with('doctors')->findOrFail($id);
        return response()->json($specialization);
    }

}
