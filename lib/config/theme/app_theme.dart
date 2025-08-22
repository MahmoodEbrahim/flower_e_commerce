import 'package:flutter/material.dart';
import 'app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'font_manger.dart';
import 'font_style_manger.dart';


class AppTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.White,
      appBarTheme: AppBarTheme(
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        
        iconTheme: IconThemeData(color: AppColors.black),
        titleTextStyle: GoogleFonts.roboto(
          color: AppColors.black,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.pink[50],
          foregroundColor: AppColors.white,
          textStyle: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color:  AppColors.gray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: AppColors.gray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: AppColors.gray, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: AppColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: AppColors.red, width: 2.0),
        ),
        labelStyle: GoogleFonts.roboto(color: AppColors.black, fontSize: 16),
        hintStyle: GoogleFonts.roboto(color: AppColors.black[40], fontSize: 14),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),


      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.pink,
          unselectedItemColor: AppColors.gray,
          showUnselectedLabels: true,
          selectedLabelStyle:getMediumStyle(color: AppColors.Pink,
              fontSize: FontSize.s12
          ),
          unselectedLabelStyle: getMediumStyle(color: AppColors.gray,
              fontSize: FontSize.s12
          ),
          type: BottomNavigationBarType.fixed
      ),


    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.White),
      checkColor:  WidgetStatePropertyAll(AppColors.gray),
      overlayColor: WidgetStatePropertyAll(AppColors.White),
      side: BorderSide(
        color: AppColors.gray,
        width: 2
      ),
    )



  );
}