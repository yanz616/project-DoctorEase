// import 'package:doctor_ease_fe/presentation/doctor/pages/doctor_list_page.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> _checkLoginStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');

//     //jika token ada, langsung ke halaman doctor list
//     if (token != null) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => const DoctorListPage()),
//       );
//     } else {
//       //jika token tidak ada, langsung ke halaman
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => const LoginPage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child: CircularProgressIndicator()));
//   }
// }
