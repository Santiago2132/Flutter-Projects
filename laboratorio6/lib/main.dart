import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const VistaRuta1(),
        '/vista2': (context) => const VistaRuta2(parametro: 'Hola'),
      },
    );
  }
}

class VistaRuta1 extends StatelessWidget {
  const VistaRuta1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vista 1', style: TextStyle(fontSize: 24))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Método Push con parámetro
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VistaRuta2(parametro: 'Hola'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text('Ir a Vista 2 (Push)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Método PushNamed con parámetro
                Navigator.pushNamed(context, '/vista2');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text('Ir a Vista 2 (PushNamed)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Ir a Vista 3 usando Get y esperar una respuesta
                final respuesta = await Get.to(() => const VistaRuta3());
                // Mostrar la respuesta recibida en un SnackBar con animación
                if (respuesta != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Respuesta recibida: $respuesta', style: const TextStyle(fontSize: 18)),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(20),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text('Ir a Vista 3 (Get.to)'),
            ),
          ],
        ),
      ),
    );
  }
}

class VistaRuta2 extends StatelessWidget {
  final String parametro;

  const VistaRuta2({Key? key, required this.parametro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vista 2', style: TextStyle(fontSize: 24))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mostrar el parámetro recibido con una animación
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                'Parámetro recibido: $parametro',
                key: ValueKey(parametro), // Cambia la clave para forzar la animación
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Regresar a Vista 1
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text('Regresar a Vista 1'),
            ),
          ],
        ),
      ),
    );
  }
}

class VistaRuta3 extends StatelessWidget {
  const VistaRuta3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vista 3', style: TextStyle(fontSize: 24))),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Regresar a Vista 1 con respuesta
            Get.back(result: 'Mundo');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: const TextStyle(fontSize: 20),
          ),
          child: const Text('Regresar a Vista 1 con respuesta'),
        ),
      ),
    );
  }
}