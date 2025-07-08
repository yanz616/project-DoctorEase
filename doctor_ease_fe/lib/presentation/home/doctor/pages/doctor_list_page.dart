import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/doctor_bloc.dart';
import '../bloc/doctor_event.dart';
import '../bloc/doctor_state.dart';

class DoctorListPage extends StatelessWidget {
  const DoctorListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Dokter')),
      body: BlocBuilder<DoctorBloc, DoctorState>(
        builder: (context, state) {
          if (state is DoctorLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DoctorLoadedState) {
            return ListView.builder(
              itemCount: state.doctors.length,
              itemBuilder: (context, index) {
                final doctor = state.doctors[index];
                return ListTile(
                  title: Text(doctor.name),
                  subtitle: Text(doctor.specialization),
                );
              },
            );
          } else if (state is DoctorErrorState) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Tekan tombol untuk load dokter'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<DoctorBloc>().add(LoadDoctorsEvent());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
