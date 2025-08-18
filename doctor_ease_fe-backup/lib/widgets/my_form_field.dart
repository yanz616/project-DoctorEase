import 'package:doctor_ease_fe/core/constants/colors.dart';
import 'package:doctor_ease_fe/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFormField extends StatelessWidget {
  const MyFormField({
    super.key,
    required this.controller,
    this.obscure = false,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    required this.color,
    required this.hintStyle,
    this.errorText,
    this.showToggleIcon = false,
    this.onToggle,
  });

  final TextEditingController controller;
  final bool obscure;
  final String hintText;
  final Icon prefixIcon;
  final Icon? suffixIcon;
  final Color color;
  final StyleText hintStyle;
  final String? errorText;
  final bool showToggleIcon;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: showToggleIcon
            ? IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: errorText != null ? Colors.red : Colors.grey,
                ),
                onPressed: onToggle,
              )
            : suffixIcon,
        fillColor: color,
        hintStyle: GoogleFonts.poppins(
          fontSize: hintStyle.size,
          fontWeight: hintStyle.weight,
          color: errorText != null ? Colors.red : hintStyle.color,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: errorText != null ? Colors.red : AppColors.darkCyan,
            width: 1,
          ),
        ),
        errorText: errorText,
      ),
    );
  }
}
