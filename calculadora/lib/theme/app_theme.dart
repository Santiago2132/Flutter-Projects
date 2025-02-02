import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.amber, // Color principal amarillo
    primary: Colors.amber,
    secondary: Colors.red, // Color secundario rojo
    surface: Colors.white,
    background: Colors.grey[100]!,
    error: Colors.redAccent, // Color para errores
  ),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    elevation: 2,
    backgroundColor: Colors.amber, // AppBar en color amarillo
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.amber, // Botones flotantes en amarillo
    elevation: 4,
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);