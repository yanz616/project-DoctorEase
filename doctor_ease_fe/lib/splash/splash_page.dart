import 'package:doctor_ease_fe/core/constants/colors.dart';
import 'package:doctor_ease_fe/core/constants/font.dart';
import 'package:doctor_ease_fe/presentation/auth/pages/login_page.dart';
import 'package:doctor_ease_fe/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
      backgroundColor: AppColors.darkCyan,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage("assets/icons/Vector.png")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MontSerratText(
                text: "Doctor",
                styles: StyleText(
                  size: 14,
                  weight: AppFontWeights.semiBold,
                  color: AppColors.white,
                ),
              ),
              Gap(2),
              MontSerratText(
                text: "Ease",
                styles: StyleText(
                  size: 16,
                  weight: AppFontWeights.extraBold,
                  color: AppColors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
