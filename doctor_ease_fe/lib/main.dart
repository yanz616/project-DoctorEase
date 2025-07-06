import 'package:doctor_ease_fe/data/service/doctor_service.dart';
import 'package:doctor_ease_fe/presentation/doctor/bloc/doctor_bloc.dart%20';
import 'package:doctor_ease_fe/presentation/doctor/pages/doctor_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => DoctorBloc(DoctorService()))],
      child: MaterialApp(
        title: 'Doctor Ease',
        theme: ThemeData(primarySwatch: Colors.green),
        home: DoctorListPage(),
      ),
    );
  }
}
