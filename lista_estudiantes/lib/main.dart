import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'item_usuario.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      color: Color.fromARGB(255, 255, 249, 255),
      fontSize: 19,
      fontWeight: FontWeight.bold,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Lista de Usuarios',
            style: titleStyle
            ),
          backgroundColor: Colors.pink,
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
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return snapshot.data![index];
                },
              );
            }
          },
        ),
      ),
    );
  }
}

Future<List<ItemUsuario>> fetchUsuarios() async {
  final response = await http.get(Uri.parse('https://api.npoint.io/5cb393746e518d1d8880'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> elementos = data['elementos'];

    return elementos.map((elemento) {
      return ItemUsuario(
        urlImagen: elemento['urlImagen'],
        nombreCompleto: elemento['nombreCompleto'],
        profesion: elemento['profesion'],
        universidad: elemento['estudios'][0]['universidad'],
        bachillerato: elemento['estudios'][0]['bachillerato'],
        edad: elemento['edad'],
      );
    }).toList();
  } else {
    throw Exception('Failed to load usuarios');
  }
}//🐢