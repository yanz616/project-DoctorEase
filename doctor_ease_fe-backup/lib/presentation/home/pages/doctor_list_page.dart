import 'package:doctor_ease_fe/presentation/home/blocs/doctor/doctor_bloc.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/doctor/doctor_event.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/doctor/doctor_state.dart';
import 'package:doctor_ease_fe/presentation/home/pages/detail_doctor.dart';
import 'package:doctor_ease_fe/presentation/profile/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorBloc>().add(LoadDoctorsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctor List')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<DoctorBloc, DoctorState>(
          builder: (context, state) {
            if (state is DoctorLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DoctorLoadedState) {
              if (state.doctors.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      },
                      child: const Text('Profile'),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text('Tidak ada dokter tersedia.'),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      },
                      child: const Text('Profile'),
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: state.doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = state.doctors[index];
                          return ListTile(
                            title: Text(doctor.name),
                            subtitle: Text(doctor.specialization.name),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // 👇 Navigasi ke halaman detail doctor
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DoctorDetailPage(doctor: doctor),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            } else if (state is DoctorErrorState) {
              return Center(child: Text('Terjadi kesalahan: ${state.error}'));
            }
            return const SizedBox.shrink(); // initial or unknown state
          },
        ),
      ),
    );
  }
}
