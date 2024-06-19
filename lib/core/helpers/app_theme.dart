import 'package:flutter/material.dart';

abstract class AppTheme {
  static final lightTheme = ThemeData(
    dividerTheme: const DividerThemeData(
      thickness: 3,
    ),
    scaffoldBackgroundColor: Colors.white,
    cardTheme: const CardTheme(
      color: Colors.white,
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 19,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(0xFF50B0A2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    useMaterial3: true,
  );
}