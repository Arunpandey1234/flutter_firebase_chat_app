import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200, // Added missing comma
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
  ),
);
