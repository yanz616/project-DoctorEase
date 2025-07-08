import 'package:doctor_ease_fe/data/service/auth_service.dart';
import 'package:doctor_ease_fe/data/service/doctor_service.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/register/register_bloc.dart';
import 'package:doctor_ease_fe/presentation/auth/pages/register_page.dart';
import 'package:doctor_ease_fe/presentation/home/doctor/bloc/doctor_bloc.dart';
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
      providers: [
        BlocProvider(create: (_) => DoctorBloc(DoctorService())),
        BlocProvider(create: (_) => RegisterBloc(authService: AuthService())),
      ],
      child: MaterialApp(
        title: 'Doctor Ease',
        theme: ThemeData(primarySwatch: Colors.green),
        home: RegisterPage(),
      ),
    );
  }
}
