import 'package:flutter/material.dart';
import 'package:my_project/Config/Colors.dart';

var lightTheme = ThemeData();

var darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  appBarTheme: AppBarTheme(backgroundColor: dContainerColor),
  colorScheme: const ColorScheme.dark(
    primary: dPrimaryColor,
    onPrimary: dOnBackGroundColor,
    background: dBackGroundColor,
    onBackground: dOnBackGroundColor,
    primaryContainer: dContainerColor,
    onPrimaryContainer: dOnContainerColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: dBackGroundColor,
    filled: true,
    border: UnderlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      color: dPrimaryColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w800,
    ),
    headlineMedium: TextStyle(
      fontSize: 30,
      color: dOnBackGroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      color: dOnBackGroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      color: dOnBackGroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w200,
    ),
    labelLarge: TextStyle(
      fontSize: 12,
      color: dOnBackGroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontSize: 10,

      color: dOnBackGroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      color: dOnBackGroundColor,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      color: Color.fromRGBO(255, 255, 255, 0.5),
      fontFamily: "Poppins",
      fontWeight: FontWeight.w500,
    ),
  ),
);
