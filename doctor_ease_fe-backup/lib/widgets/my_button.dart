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
    this.isLoading = false,
  });

  final VoidCallback onPressed;
  final double borderCircular;
  final double vertical;
  final String text;
  final StyleText styleText;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkCyan,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(borderCircular),
        ),
        padding: EdgeInsets.symmetric(vertical: vertical),
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: Duration(seconds: 1),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : PoppinText(
                  text: text,
                  styles: StyleText(
                    size: styleText.size,
                    weight: styleText.weight,
                    color: styleText.color,
                  ),
                ),
        ),
      ),
    );
  }
}
