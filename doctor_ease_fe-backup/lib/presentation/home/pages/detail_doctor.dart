import 'package:doctor_ease_fe/data/models/doctor/doctor_model.dart';
import 'package:doctor_ease_fe/data/models/appointment/request/appointment_request.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/appointment/appointment_bloc.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/appointment/appointment_event.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/appointment/appointment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetailPage extends StatefulWidget {
  final Doctor doctor;

  const DoctorDetailPage({super.key, required this.doctor});

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  final TextEditingController _purposeCtrl = TextEditingController();
  DateTime? selectedDate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitAppointment() {
    if (_formKey.currentState?.validate() == true && selectedDate != null) {
      final request = AppointmentRequest(
        doctorId: widget.doctor.id,
        scheduledAt: selectedDate!.toIso8601String(),
        purpose: _purposeCtrl.text,
      );
      context.read<AppointmentBloc>().add(CreateAppointments(request: request));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.doctor.name)),
      body: BlocListener<AppointmentBloc, AppointmentState>(
        listener: (context, state) {
          if (state is SuccessAppointment) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.response.message)));
            Navigator.pop(context);
          } else if (state is FailureAppointment) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Spesialisasi: ${widget.doctor.specialization.name}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _purposeCtrl,
                  decoration: InputDecoration(labelText: "Tujuan Konsultasi"),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Tujuan wajib diisi'
                      : null,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    // Gunakan mounted context aman
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(Duration(days: 1)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if (picked != null && mounted) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  child: Text(
                    selectedDate == null
                        ? 'Pilih Tanggal'
                        : 'Tanggal: ${selectedDate!.toLocal()}'.split(' ')[0],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitAppointment,
                  child: Text("Buat Janji"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
