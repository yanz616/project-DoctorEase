<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Doctor;
use App\Models\Appointment;
use App\Models\Specialization;

class AdminController extends Controller
{
    // Ambil semua doctor
    // public function doctors()
    // {
    //     return response()->json(Doctor::all());
    // }
    public function doctors()
    {
        return response()->json(Doctor::with('specialization')->get());
    }

    // public function getDoctor($id)
    // {
    //     $doctor = Doctor::find($id);
    
    //     if (!$doctor) {
    //         return response()->json(['message' => 'Doctor not found'], 404);
    //     }

    //     return response()->json($doctor);
    // }
    public function getDoctor($id)
    {
        $doctor = Doctor::with('specialization')->find($id);

        if (!$doctor) {
            return response()->json(['message' => 'Doctor not found'], 404);
        }

        return response()->json($doctor);
    }

    // Tambah doctor
    // public function storeDoctor(Request $request)
    // {
    //     $data = $request->validate([
    //         'name' => 'required|string',
    //         'specialization' => 'required|string',
    //         'photo' => 'nullable|url',
    //     ]);

    //     $doctor = Doctor::create($data);
    //     return response()->json($doctor, 201);
    // }
    public function storeDoctor(Request $request)
    {
        $data = $request->validate([
            'name'              => 'required|string',
            'specialization_id' => 'required|exists:specializations,id',
            'photo'             => 'nullable|url',
        ]);

        $doctor = Doctor::create($data);
        return response()->json($doctor->load('specialization'), 201);
    }

    // Update doctor
    // public function updateDoctor(Request $request, $id)
    // {
    //     $doctor = Doctor::findOrFail($id);

    //     $data = $request->validate([
    //         'name' => 'sometimes|string',
    //         'specialization' => 'sometimes|string',
    //         'photo' => 'nullable|url',
    //     ]);

    //     $doctor->update($data);
    //     return response()->json($doctor);
    // }
    public function updateDoctor(Request $request, $id)
    {
        $doctor = Doctor::findOrFail($id);

        $data = $request->validate([
            'name'              => 'sometimes|string',
            'specialization_id' => 'sometimes|exists:specializations,id',
            'photo'             => 'nullable|url',
        ]);

        $doctor->update($data);
        return response()->json($doctor->load('specialization'));
    }

    // Hapus doctor
    public function destroyDoctor($id)
    {
        $doctor = Doctor::findOrFail($id);
        $doctor->delete();
        return response()->json(['message' => 'Doctor deleted']);
    }

    // Ambil semua appointment (sudah ada sebelumnya)
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

    // Update appointment (status, jadwal, dll)
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

    // Hapus appointment
    public function destroyAppointment($id)
    {
        $appointment = Appointment::findOrFail($id);
        $appointment->delete();
        return response()->json(['message' => 'Appointment deleted']);
    }

    // Ambil semua user
    public function users()
    {
        return response()->json(User::all());
    }

    //get user by id
    public function getUser($id)
    {
        $user = User::find($id);
    
        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        return response()->json($user);
    }

    public function specialization()
    {
        return response()->json(Specialization::all());
    }

    public function getSpecialization($id)
    {
        $specialization = specialization::find($id);
    
        if (!$specialization) {
            return response()->json(['message' => 'Specialization not found'], 404);
        }

        return response()->json($specialization);
    }

    public function storeSpecialization(Request $request)
    {
        $validated = $request->validate([
            'name'      => 'required|string|max:255',
        ]);

        $specialization = Specialization::create([
            'name' => $validated['name'],
        ]);

        return response()->json([
            'message' => 'Specialization created successfully',
            'data'    => $specialization
        ], 201);
    }


    // public function updateSpecialization(Request $request, $id)
    // {
    //     $specialization = Specialization::findOrFail($id);

    //     $validated = $request->validate([
    //         'name' => 'sometimes|required|string|max:255',
    //     ]);

    //     $specialization->update($validated);

    //     // refresh supaya data terbaru ikut diresponse
    //     $specialization->refresh();

    //     return response()->json([
    //         'message' => 'Specialization updated successfully',
    //         'data'    => $specialization
    //     ]);
    // }
    public function updateSpecialization(Request $request, $id)
    {
        $specialization = Specialization::findOrFail($id);

        $validated = $request->validate([
            'name' => 'required|string|max:255',
        ]);

        $specialization->name = $validated['name'];
        $specialization->save();

        return response()->json([
            'message' => 'Specialization updated successfully',
            'data'    => $specialization
        ]);
    }


    public function destroySpecialization($id)
    {
        $specialization = Specialization::findOrFail($id);
        $specialization->delete();

        return response()->json(['message' => 'Specialization deleted successfully']);
    }

    // // Update user
    // public function updateUser(Request $request, $id)
    // {
    //     $user = User::findOrFail($id);

    //     $data = $request->validate([
    //         'name' => 'sometimes|string',
    //         'email' => 'sometimes|email|unique:users,email,' . $id,
    //         'is_admin' => 'sometimes|boolean'
    //     ]);

    //     $user->update($data);
    //     return response()->json($user);
    // }

    // // Hapus user
    // public function destroyUser($id)
    // {
    //     try {
    //         $user = User::findOrFail($id);
    //         $user->delete();
    //         return response()->json(['message' => 'User deleted']);
    //     } catch (\Exception $e) {
    //         return response()->json(['error' => 'User not found or failed to delete'], 500);
    //     }
    // }

}
