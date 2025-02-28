import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> obtenerGps() async {
    bool bGpsHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!bGpsHabilitado) {
      throw Exception('Por favor habilite el servicio de ubicación.');
    }

    LocationPermission bGpsPermiso = await Geolocator.checkPermission();
    if (bGpsPermiso == LocationPermission.denied) {
      bGpsPermiso = await Geolocator.requestPermission();
      if (bGpsPermiso == LocationPermission.denied) {
        throw Exception('Se denegó el permiso para obtener la ubicación.');
      }
    }

    if (bGpsPermiso == LocationPermission.deniedForever) {
      throw Exception('Se denegó el permiso para obtener la ubicación de forma permanente.');
    }

    return await Geolocator.getCurrentPosition();
  }
}