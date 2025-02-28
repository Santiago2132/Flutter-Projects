import 'package:flutter/material.dart';

class PerfilUsuario extends StatelessWidget {
  final String urlImagen;
  final String nombreCompleto;
  final String profesion;
  final String universidad;
  final String bachillerato;
  final int edad;

  const PerfilUsuario({
    super.key,
    required this.urlImagen,
    required this.nombreCompleto,
    required this.profesion,
    required this.universidad,
    required this.bachillerato,
    required this.edad,
  });

  static const TextStyle estiloNombre = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle estiloDetalle = TextStyle(
    fontSize: 18,
    color: Colors.black54,
  );

  static const TextStyle estiloTituloDetalle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(urlImagen),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                nombreCompleto,
                style: estiloNombre,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              Text(
                profesion,
                style: estiloDetalle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        _buildDetallePerfil(
                          titulo: 'Universidad',
                          valor: universidad,
                        ),
                        const SizedBox(height: 15),

                        _buildDetallePerfil(
                          titulo: 'Bachillerato',
                          valor: bachillerato,
                        ),
                        const SizedBox(height: 15),

                        _buildDetallePerfil(
                          titulo: 'Edad',
                          valor: '$edad años',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Regresar a la lista',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetallePerfil({required String titulo, required String valor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: estiloTituloDetalle,
        ),
        const SizedBox(height: 5),
        Text(
          valor,
          style: estiloDetalle,
        ),
      ],
    );
  }
}//🐢