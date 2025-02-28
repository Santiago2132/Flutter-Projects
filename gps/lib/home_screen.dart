import 'package:flutter/material.dart';
import 'location_service.dart';
import 'url_launcher_service.dart';

// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  final LocationService _locationService = LocationService();
  final UrlLauncherService _urlLauncherService = UrlLauncherService();

  Future<void> _obtenerUbicacionYAbirMapa(BuildContext context) async {
    try {
      final position = await _locationService.obtenerGps();
      final url = 'http://www.google.com/maps/place/${position.latitude},${position.longitude}';
      await _urlLauncherService.abrirUrl(url);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localización y Google Maps'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _obtenerUbicacionYAbirMapa(context),
          child: Text('Obtener Ubicación y Abrir en Google Maps'),
        ),
      ),
    );
  }
}