import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_ease_fe/data/models/appointment/appointment_model.dart';
import 'package:doctor_ease_fe/data/models/appointment/request/appointment_request.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/appointment/appointment_bloc.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/appointment/appointment_event.dart';

class EditAppointmentPage extends StatefulWidget {
  final AppointmentModel appointment;

  const EditAppointmentPage({super.key, required this.appointment});

  @override
  State<EditAppointmentPage> createState() => _EditAppointmentPageState();
}

class _EditAppointmentPageState extends State<EditAppointmentPage> {
  late TextEditingController purposeController;
  DateTime? selectedDate;

  @override
  void initState() {
    purposeController = TextEditingController(text: widget.appointment.purpose);
    selectedDate = DateTime.parse(widget.appointment.scheduledAt);
    super.initState();
  }

  void _updateAppointment() {
    final request = AppointmentRequest(
      doctorId: widget.appointment.doctorId,
      scheduledAt: selectedDate!.toIso8601String(),
      purpose: purposeController.text,
    );

    context.read<AppointmentBloc>().add(
      UpdateAppointment(id: widget.appointment.id, request: request),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Appointment")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: purposeController,
              decoration: InputDecoration(labelText: "Tujuan Konsultasi"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  setState(() => selectedDate = picked);
                }
              },
              child: Text(
                selectedDate == null
                    ? "Pilih Tanggal"
                    : "Tanggal: ${selectedDate!.toLocal()}".split(" ")[0],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateAppointment,
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
