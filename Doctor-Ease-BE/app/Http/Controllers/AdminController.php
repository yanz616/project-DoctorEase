<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Doctor;
use App\Models\Appointment;
use App\Models\Specialization;

class AdminController extends Controller
{
    // ==========================
    // DOCTOR CRUD
    // ==========================
    public function doctors()
    {
        $doctors = Doctor::with('specialization')->get();
        return response()->json($doctors);
    }

    public function getDoctor($id)
    {
        $doctor = Doctor::with('specialization')->findOrFail($id);
        return response()->json($doctor);
    }

    public function storeDoctor(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'photo' => 'nullable|string',
            'specialization_id' => 'required|exists:specializations,id',
        ]);

        $doctor = Doctor::create($validated);

        return response()->json($doctor, 201);
    }

    public function updateDoctor(Request $request, $id)
    {
        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'photo' => 'nullable|string',
            'specialization_id' => 'sometimes|exists:specializations,id',
        ]);

        $doctor = Doctor::findOrFail($id);
        $doctor->update($validated);

        return response()->json($doctor);
    }

    public function destroyDoctor($id)
    {
        $doctor = Doctor::findOrFail($id);
        $doctor->delete();

        return response()->json(['message' => 'Doctor deleted successfully']);
    }

    // ==========================
    // SPECIALIZATION CRUD
    // ==========================
    public function specializations()
    {
        return response()->json(Specialization::all());
    }

    public function getSpecialization($id)
    {
        $specialization = Specialization::with('doctors')->findOrFail($id);
        return response()->json($specialization);
    }

    public function storeSpecialization(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'icon' => 'nullable|string',
        ]);

        $specialization = Specialization::create($validated);

        return response()->json($specialization, 201);
    }

    public function updateSpecialization(Request $request, $id)
    {
        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'icon' => 'nullable|string',
        ]);

        $specialization = Specialization::findOrFail($id);
        $specialization->update($validated);

        return response()->json($specialization);
    }

    public function destroySpecialization($id)
    {
        $specialization = Specialization::findOrFail($id);
        $specialization->delete();

        return response()->json(['message' => 'Specialization deleted successfully']);
    }

    // ==========================
    // APPOINTMENT CRUD (sudah ada)
    // ==========================
    public function appointments()
    {
        return response()->json(Appointment::with('user', 'doctor')->get());
    }

    public function getAppointment($id)
    {   
        $appointment = Appointment::find($id);
    
        if (!$appointment) {
            return response()->json(['message' => 'Appointment not found'], 404);
        }

        return response()->json($appointment);
    }

    public function updateAppointment(Request $request, $id)
    {
        $appointment = Appointment::findOrFail($id);

        $data = $request->validate([
            'scheduled_at' => 'sometimes|date',
            'purpose' => 'sometimes|string',
            'status' => 'sometimes|in:approved,canceled,completed'
        ]);

        $appointment->update($data);
        return response()->json($appointment);
    }

    public function destroyAppointment($id)
    {
        $appointment = Appointment::findOrFail($id);
        $appointment->delete();
        return response()->json(['message' => 'Appointment deleted']);
    }

    // ==========================
    // USER
    // ==========================
    public function users()
    {
        return response()->json(User::all());
    }

    public function getUser($id)
    {
        $user = User::find($id);
    
        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        return response()->json($user);
    }
}
