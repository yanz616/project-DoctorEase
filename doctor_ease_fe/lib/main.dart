import 'package:doctor_ease_fe/data/service/auth_service.dart';
import 'package:doctor_ease_fe/data/service/doctor_service.dart';
import 'package:doctor_ease_fe/data/service/profile_service.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/login/login_bloc.dart';
import 'package:doctor_ease_fe/presentation/auth/blocs/register/register_bloc.dart';
import 'package:doctor_ease_fe/presentation/auth/pages/login_page.dart';
import 'package:doctor_ease_fe/presentation/home/doctor/bloc/doctor_bloc.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/me/me_bloc.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/update/update_bloc.dart';
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
        BlocProvider(create: (_) => RegisterBloc(authService: AuthService())),
        BlocProvider(create: (_) => LoginBloc(authService: AuthService())),
        BlocProvider(create: (_) => MeBloc(profileService: ProfileService())),
        BlocProvider(
          create: (_) => UpdateBloc(profileService: ProfileService()),
        ),
        BlocProvider(create: (_) => LoginBloc(authService: AuthService())),
        BlocProvider(create: (_) => DoctorBloc(DoctorService())),
      ],
      child: MaterialApp(
        title: 'Doctor Ease',
        theme: ThemeData(primarySwatch: Colors.green),
        home: LoginPage(),
      ),
    );
  }
}
