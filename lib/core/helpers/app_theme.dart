import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/colors_palette.dart';

abstract class AppTheme {
  static final lightTheme = ThemeData(
    dividerTheme: const DividerThemeData(
      thickness: 3,
    ),
    scaffoldBackgroundColor: Colors.white,
    cardTheme: const CardTheme(
      color: Colors.white,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsPalette.primaryColorApp,
      selectedIconTheme: IconThemeData(
        color: Colors.white,
      ),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.brown,
     
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: ColorsPalette.primaryColorApp,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
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
