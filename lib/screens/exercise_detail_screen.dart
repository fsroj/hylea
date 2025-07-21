// screens/exercise_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hylea/models/exercise.dart';
import 'package:hylea/widgets/mode_tag.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailScreen({super.key, required this.exercise});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication); // Intenta abrir en app externa
    } else {
      // Si la app no está disponible, intenta abrir en navegador
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.inAppWebView); // Abre en webview si no puede en externa
      } else {
        // Mostrar mensaje de error si no se puede abrir de ninguna forma
        print('Could not launch $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Ejercicio'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView( // Usar SingleChildScrollView para evitar desbordamiento
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: ModeTag(mode: exercise.mode),
            ),
            const SizedBox(height: 24.0),
            Text(
              exercise.name,
              style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              exercise.description,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildDetailRow(
              context,
              Icons.repeat,
              'Repeticiones por Serie:',
              exercise.repetitionsPerSet.toString(),
            ),
            const SizedBox(height: 8.0),
            _buildDetailRow(
              context,
              Icons.category,
              'Modo:',
              exercise.mode.toString().split('.').last.toUpperCase(),
            ),
            if (exercise.imageUrl != null && exercise.imageUrl!.isNotEmpty)
              _buildMediaSection(
                context,
                'Imagen',
                Image.network(exercise.imageUrl!, fit: BoxFit.cover),
              ),
            if (exercise.gifUrl != null && exercise.gifUrl!.isNotEmpty)
              _buildMediaSection(
                context,
                'GIF',
                // Considera usar un paquete como cached_network_image o flutter_gifimage
                // para manejar mejor los GIFs si son grandes. Por ahora, Image.network funciona.
                Image.network(exercise.gifUrl!, fit: BoxFit.cover),
              ),
            if (exercise.videoUrl != null && exercise.videoUrl!.isNotEmpty)
              _buildMediaSection(
                context,
                'Video (URL)',
                // Para videos, necesitarás un paquete como video_player o chewie.
                // Por simplicidad, aquí solo mostramos el enlace.
                Text(exercise.videoUrl!),
                onTap: () => _launchURL(exercise.videoUrl!), // Permite abrir el video en navegador/app
              ),
            if (exercise.linkUrl != null && exercise.linkUrl!.isNotEmpty)
              _buildConsultLink(context, exercise.linkUrl!),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para mostrar imagen/GIF/Video
  Widget _buildMediaSection(BuildContext context, String title, Widget mediaWidget, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          GestureDetector(
            onTap: onTap, // Permite que la sección entera sea interactiva
            child: Container(
              height: 200, // Altura fija para los medios
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              clipBehavior: Clip.antiAlias, // Recortar contenido que se desborde
              child: mediaWidget,
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para el enlace de consulta
  Widget _buildConsultLink(BuildContext context, String url) {
    IconData icon;
    String label;

    if (url.contains('youtube.com') || url.contains('youtu.be')) {
      icon = Icons.play_circle_filled;
      label = 'Ver en YouTube';
    } else if (url.contains('tiktok.com')) {
      icon = Icons.tiktok; // Necesitarás importar icon_font_icons o similar para este ícono.
                          // Por ahora, usaremos Icons.link.
      icon = Icons.link; // Temporalmente usamos Icons.link si no tienes el ícono de TikTok.
      label = 'Ver en TikTok';
    } else {
      icon = Icons.link;
      label = 'Abrir Enlace de Consulta';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(icon, color: Theme.of(context).primaryColor),
          title: Text(label),
          subtitle: Text(url, overflow: TextOverflow.ellipsis),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _launchURL(url),
        ),
      ),
    );
  }
}