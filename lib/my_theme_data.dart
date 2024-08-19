import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app1/app_Colors.dart';

class MyThemeData {
  static final ThemeData LightTheme = ThemeData(
      primaryColor: AppColors.PrimaryColor,
      scaffoldBackgroundColor: AppColors.BackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.PrimaryColor,
        elevation: 0,
      ),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      )),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.PrimaryColor,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.PrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: AppColors.WhiteColor, width: 6),
          )),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.WhiteColor),
        bodyMedium: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.BlackColor),
      ));

  static final ThemeData DarkTheme = ThemeData(
      primaryColor: AppColors.PrimaryColor,
      scaffoldBackgroundColor: AppColors.BackgroundDArkColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.PrimaryColor,
        elevation: 0,
      ),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      )),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.PrimaryColor,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.PrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: AppColors.WhiteColor, width: 6),
          )),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.BlackColor),
        bodyMedium: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.BlackColor),
      ));
}
