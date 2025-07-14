import 'package:doctor_ease_fe/presentation/home/doctor/bloc/doctor_bloc.dart';
import 'package:doctor_ease_fe/presentation/home/doctor/bloc/doctor_event.dart';
import 'package:doctor_ease_fe/presentation/home/doctor/bloc/doctor_state.dart';
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
    //
    super.initState();
    context.read<DoctorBloc>().add(LoadDoctorsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctor List')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: BlocBuilder<DoctorBloc, DoctorState>(
          builder: (context, state) {
            if (state is DoctorLoadingState) {
              return CircularProgressIndicator();
            } else if (state is DoctorLoadedState) {
              if (state.doctors.isEmpty) {
                return Text('Doctor Kosong');
              } else {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        );
                      },
                      child: Text('profile'),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = state.doctors[index];
                          return ListTile(
                            title: Text(doctor.name),
                            subtitle: Text(doctor.specialization),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            } else if (state is DoctorErrorState) {
              return Text('Error: ${state.error}');
            }
            return Container(); // initial empty state
          },
        ),
      ),
    );
  }
}
