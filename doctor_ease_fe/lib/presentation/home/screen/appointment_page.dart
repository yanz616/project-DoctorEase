import 'package:doctor_ease_fe/presentation/home/blocs/appointment/appointment_bloc.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/appointment/appointment_event.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/appointment/appointment_state.dart';
import 'package:doctor_ease_fe/presentation/home/screen/edit_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  void initState() {
    context.read<AppointmentBloc>().add(LoadAppointments());
    super.initState();
  }

  void _showDeleteConfirmation(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Yakin ingin menghapus appointment ini?'),
        actions: [
          TextButton(
            child: Text('Batal'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text('Hapus'),
            onPressed: () {
              Navigator.pop(context);
              context.read<AppointmentBloc>().add(DeleteAppointment(id: id));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Appointment Page")),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 16),
        child: BlocListener<AppointmentBloc, AppointmentState>(
          listener: (context, state) {
            if (state is LoadedAppointments) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Sedang di Delete")));
            } else if (state is SuccessDeleteAppointment) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.response.message)));
            } else if (state is FailureAppointment) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<AppointmentBloc, AppointmentState>(
            builder: (context, state) {
              if (state is LoadingAppointment) {
                return Center(child: CircularProgressIndicator());
              } else if (state is LoadedAppointments) {
                if (state.appointment.isEmpty) {
                  return Center(child: Text("Appointment Nt Found"));
                } else {
                  return Column(
                    children: [
                      // ElevatedButton(
                      //   onPressed: () {},
                      //   child: Text("Edit Appointment"),
                      // ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.appointment.length,
                          itemBuilder: (context, index) {
                            final appointment = state.appointment[index];
                            return Card(
                              child: Column(
                                children: [
                                  Text(
                                    "Name Doctor :${appointment.doctorId == appointment.doctor!.id ? appointment.doctor!.name : ""}",
                                  ),
                                  Text("Schedule : ${appointment.scheduledAt}"),
                                  Text("Purpose : ${appointment.purpose}"),
                                  Text("Status : ${appointment.status}"),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditAppointmentPage(
                                                    appointment: appointment,
                                                  ),
                                            ),
                                          );
                                        },
                                        style: TextButton.styleFrom(),
                                        child: Text("Edit Appointment"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _showDeleteConfirmation(
                                            context,
                                            appointment.id,
                                          );
                                        },
                                        child: Text("Delete"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              } else if (state is FailureAppointment) {
                return Center(
                  child: Text("Terjadi Kesalahan : ${state.error}"),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
