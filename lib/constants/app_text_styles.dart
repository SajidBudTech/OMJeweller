import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  //Text Sized
  static TextStyle h0TitleTextStyle({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w800,
  }) {
    return GoogleFonts.poppins(
      fontSize: 30,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle h1TitleTextStyle({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration decoration,
  }) {
    // GoogleFonts.poppins()
    return GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle h2TitleTextStyle({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration decoration,
  }) {
    return GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle h3TitleTextStyle({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle h16TitleTextStyle({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    TextDecoration decoration,
  }) {
    return GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle h4TitleTextStyle({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    TextDecoration decoration,
  }) {
    return GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle h5TitleTextStyle({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration decoration,
  }) {
    return GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
    );
  }

  static TextStyle h7TitleTextStyle({
    Color color = Colors.grey,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration decoration,
  }) {
    return GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
    );
  }


  static TextStyle h6TitleTextStyle(
      {Color color = Colors.black, FontWeight fontWeight = FontWeight.w200}) {
    return GoogleFonts.poppins(
        fontSize: 8, fontWeight: fontWeight, color: color);
  }
}
