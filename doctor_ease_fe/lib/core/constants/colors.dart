import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xff1B4242);
  static const youngGreen = Color(0xff3FA796);
  static const orange = Color(0xffF79329);
  static const red = Color(0xffD55353);
  static const price = Color(0xff2C96F1);
  static const bg1 = Color(0xff222831);
  static const bg2 = Color(0xff31363F);
  static const white = Color(0xffffffff);
  static const whiteGrey = Color(0xffEAF3F2);
  static const black = Color(0xff181A20);
  static const grey = Color(0xffCDCDCD);
  static const greyText = Color(0xff636363);
}

class AppFontWeights {
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraBold = FontWeight.w800;
  static const black = FontWeight.w900;
}

class AppTextStyles {
  static final white = GoogleFonts.poppins(color: AppColors.white);
  static final hint = GoogleFonts.poppins(color: AppColors.grey);
  static final green = GoogleFonts.poppins(color: AppColors.youngGreen);
  static final whiteGrey = GoogleFonts.poppins(color: AppColors.whiteGrey);
  static final primary = GoogleFonts.poppins(color: AppColors.primary);
  static final greyText = GoogleFonts.poppins(color: AppColors.greyText);
  static final black = GoogleFonts.poppins(color: AppColors.black);
  static final price = GoogleFonts.poppins(color: AppColors.price);
  static final red = GoogleFonts.poppins(color: AppColors.red);
}
