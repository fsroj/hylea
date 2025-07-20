import 'package:flutter/material.dart';
import 'package:hylea/data/app_data.dart';
import 'package:hylea/screens/mode_exercises_screen.dart';
import 'package:hylea/widgets/mode_tag.dart';

// screens/modes_screen.dart
class ModesScreen extends StatelessWidget {
  const ModesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modos de Enfoque'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: ExerciseMode.values.map((mode) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: ModeTag(mode: mode),
                title: Text(
                  _getModeTitle(mode),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ModeExercisesScreen(mode: mode),
                    ),
                  );
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getModeTitle(ExerciseMode mode) {
    switch (mode) {
      case ExerciseMode.model:
        return 'Modo Modelo';
      case ExerciseMode.hiit:
        return 'Modo HIIT';
      case ExerciseMode.runner:
        return 'Modo Corredor';
      case ExerciseMode.cuello:
        return 'Modo Cuello';
    }
  }
}