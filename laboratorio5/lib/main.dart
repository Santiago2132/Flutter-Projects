import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'item_usuario.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Usuarios'),
        ),
        body: FutureBuilder<List<ItemUsuario>>(
          future: fetchUsuarios(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay datos disponibles.'));
            } else {
              return ListView(children: snapshot.data!);
            }
          },
        ),
      ),
    );
  }

  Future<List<ItemUsuario>> fetchUsuarios() async {
    final response = await http.get(Uri.https('api.npoint.io', 'bffbb3b6b3ad5e711dd2'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['resultado'] == 'ok') {
        List<dynamic> items = data['items'];
        return items.map((item) {
          return ItemUsuario(
            sImagen: item['imagen'].toString(),
            sNombres: item['nombre'].toString(),
            sCarrera: item['carrera'].toString(),
            sPromedio: item['promedio'].toString(),
          );
        }).toList();
      } else {
        throw Exception('Error en la respuesta del servidor');
      }
    } else {
      throw Exception('Error al cargar los datos');
    }
  }
}