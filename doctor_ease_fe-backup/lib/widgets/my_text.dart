import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleText {
  final double size;
  final FontWeight weight;
  final Color color;

  StyleText({required this.size, required this.weight, required this.color});
}

class PoppinText extends StatelessWidget {
  const PoppinText({super.key, required this.text, required this.styles});

  final String text;
  final StyleText styles;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: styles.size,
        fontWeight: styles.weight,
        color: styles.color,
      ),
    );
  }
}

class MontSerratText extends StatelessWidget {
  const MontSerratText({super.key, required this.text, required this.styles});

  final String text;
  final StyleText styles;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: styles.size,
        fontWeight: styles.weight,
        color: styles.color,
      ),
    );
  }
}
