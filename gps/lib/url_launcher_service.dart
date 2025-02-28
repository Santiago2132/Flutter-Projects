import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  Future<void> abrirUrl(final String sUrl) async {
    final Uri oUri = Uri.parse(sUrl);
    try {
      await launchUrl(
        oUri,
        mode: LaunchMode.externalApplication,
      );
    } catch (oError) {
      throw Exception('No fue posible abrir la url: $sUrl.');
    }
  }
}