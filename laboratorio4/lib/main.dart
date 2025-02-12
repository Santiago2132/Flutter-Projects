import 'package:flutter/material.dart';
import 'item_usuario.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  Widget build(BuildContext context) {
    // Lista de usuarios con datos de ejemplo
    List<Map<String, dynamic>> aItems = [
      {
        "imagen": "7.png",
        "nombres": "Andrea Silva",
        "carrera": "Ingeniería civil",
        "promedio": "3.9"
      },
      {
        "imagen": "5.png",
        "nombres": "Carlos Pérez",
        "carrera": "Medicina",
        "promedio": "4.1"
      },
      {
        "imagen": "3.png",
        "nombres": "María Gómez",
        "carrera": "Derecho",
        "promedio": "4.5"
      },
    ];

    // Convertir los mapas en widgets ItemUsuario
    List<ItemUsuario> awItems = aItems.map((item) {
      return ItemUsuario(
        sImagen: item["imagen"].toString(),
        sNombres: item["nombres"].toString(),
        sCarrera: item["carrera"].toString(),
        sPromedio: item["promedio"].toString(),
      );
    }).toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Usuarios'),
        ),
        body: ListView(
          children: awItems,
        ),
      ),
    );
  }
}