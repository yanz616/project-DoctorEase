import 'package:doctor_ease_fe/core/constants/colors.dart';
import 'package:doctor_ease_fe/core/constants/font.dart';
import 'package:doctor_ease_fe/core/constants/text_color.dart';
import 'package:doctor_ease_fe/presentation/auth/pages/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    next();
    super.initState();
  }

  Future<void> next() async {
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border_sharp,
                  size: 50,
                  color: AppColors.lightBlue,
                ),
                Text(
                  'Doctor Ease',
                  style: TextColor.charcoalBlue.copyWith(
                    fontWeight: AppFontWeights.bold,
                    fontSize: 50,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
