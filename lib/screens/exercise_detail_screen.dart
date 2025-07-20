import 'package:flutter/material.dart';
import 'package:hylea/models/exercise.dart';
import 'package:hylea/widgets/mode_tag.dart';

// screens/exercise_detail_screen.dart
class ExerciseDetailScreen extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailScreen({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Ejercicio'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
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
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      BuildContext context, IconData icon, String label, String value) {
    return Row(
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
    );
  }
}