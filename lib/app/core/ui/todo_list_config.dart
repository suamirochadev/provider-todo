import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListConfig {
  TodoListConfig._();

  static ThemeData get theme => ThemeData(
    textTheme: GoogleFonts.mandaliTextTheme(),
    primaryColor: const Color(0xff5c77ce),
    primaryColorLight: const Color(0xffABC8F7),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff5c77ce),
        foregroundColor: const Color(0xffffffff),
      )
    ),
  );
}
