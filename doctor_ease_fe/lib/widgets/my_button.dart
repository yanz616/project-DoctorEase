import 'package:doctor_ease_fe/core/constants/colors.dart';
import 'package:doctor_ease_fe/widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onPressed,
    required this.borderCircular,
    required this.vertical,
    required this.text,
    required this.styleText,
  });

  final VoidCallback onPressed;
  final double borderCircular;
  final double vertical;
  final String text;
  final StyleText styleText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkCyan,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(borderCircular),
        ),
        padding: EdgeInsets.symmetric(vertical: vertical),
      ),
      child: Center(
        child: PoppinText(
          text: text,
          styles: StyleText(
            size: styleText.size,
            weight: styleText.weight,
            color: styleText.color,
          ),
        ),
      ),
    );
  }
}
