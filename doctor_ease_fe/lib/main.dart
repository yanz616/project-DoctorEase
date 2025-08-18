import 'package:doctor_ease_fe/data/repositories/auth_repository.dart';
import 'package:doctor_ease_fe/presentation/blocs/auth/auth_bloc.dart';
import 'package:doctor_ease_fe/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(authRepository: AuthRepository())),
      ],
      child: MaterialApp(
        title: "Doctor Ease",
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
