import 'package:flutter/material.dart';

class ItemUsuario extends StatelessWidget {
  final String sImagen;
  final String sNombres;
  final String sCarrera;
  final String sPromedio;

  const ItemUsuario({
    super.key,
    required this.sImagen,
    required this.sNombres,
    required this.sCarrera,
    required this.sPromedio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Parte izquierda: Imagen
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/$sImagen'),
          ),
          const SizedBox(width: 15),
          
          // Parte derecha: Información
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sNombres,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(sCarrera),
                Text("Promedio: $sPromedio"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}