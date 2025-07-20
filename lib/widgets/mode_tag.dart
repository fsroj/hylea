import 'package:flutter/material.dart';
import 'package:hylea/data/app_data.dart';

// widgets/mode_tag.dart
class ModeTag extends StatelessWidget {
  final ExerciseMode mode;

  const ModeTag({super.key, required this.mode});

  Color _getModeColor(ExerciseMode mode) {
    switch (mode) {
      case ExerciseMode.model:
        return Colors.blue.shade700;
      case ExerciseMode.hiit:
        return Colors.red.shade700;
      case ExerciseMode.runner:
        return Colors.green.shade700;
      case ExerciseMode.cuello:
        return Colors.purple.shade700;
    }
  }

  String _getModeName(ExerciseMode mode) {
    switch (mode) {
      case ExerciseMode.model:
        return 'MODEL';
      case ExerciseMode.hiit:
        return 'HIIT';
      case ExerciseMode.runner:
        return 'RUNNER';
      case ExerciseMode.cuello:
        return 'CUELLO';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getModeColor(mode),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _getModeName(mode),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}