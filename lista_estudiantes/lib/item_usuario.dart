import 'package:flutter/material.dart';
import 'package:lista_estudiantes/perfil_uduario.dart';


class ItemUsuario extends StatelessWidget {
  final String urlImagen;
  final String nombreCompleto;
  final String profesion;
  final String universidad;
  final String bachillerato;
  final int edad;

  const ItemUsuario({
    super.key,
    required this.urlImagen,
    required this.nombreCompleto,
    required this.profesion,
    required this.universidad,
    required this.bachillerato,
    required this.edad,
  });

  static const TextStyle estiloNombre = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle estiloProfesion = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );

  static const TextStyle estiloUniversidad = TextStyle(
    fontSize: 16,
    color: Colors.black54,
  );

  static const EdgeInsets paddingContenido = EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(urlImagen),
            ),
          ),
          Expanded(
            child: Padding(
              padding: paddingContenido,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nombreCompleto,
                    style: estiloNombre,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    profesion,
                    style: estiloProfesion,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    universidad,
                    style: estiloUniversidad,
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PerfilUsuario(
                            urlImagen: urlImagen,
                            nombreCompleto: nombreCompleto,
                            profesion: profesion,
                            universidad: universidad,
                            bachillerato: bachillerato,
                            edad: edad,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Ver perfil',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}//🐢