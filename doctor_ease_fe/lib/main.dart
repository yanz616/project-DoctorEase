import 'package:doctor_ease_fe/data/service/appoinment_service.dart';
import 'package:doctor_ease_fe/data/service/auth_service.dart';
import 'package:doctor_ease_fe/data/service/doctor_service.dart';
import 'package:doctor_ease_fe/data/service/profile_service.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/auth_bloc.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/appointment/appointment_bloc.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/doctor/doctor_bloc.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/profile_bloc.dart';
import 'package:doctor_ease_fe/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // inisialisasi MultiBlocProvider untuk menyediakan beberapa bloc
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(authService: AuthService())),
        BlocProvider(create: (_) => ProfileBloc(service: ProfileService())),

        BlocProvider(create: (_) => DoctorBloc(doctorService: DoctorService())),
        BlocProvider(
          create: (_) => AppointmentBloc(service: AppointmentService()),
        ),
      ],
      child: MaterialApp(
        title: 'Doctor Ease',
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
