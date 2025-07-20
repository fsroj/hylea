import 'package:flutter/material.dart';
import 'package:hylea/data/app_data.dart';
import 'package:hylea/screens/add_edit_exercise_screen.dart';
import 'package:hylea/widgets/exercise_card.dart';
import 'package:provider/provider.dart';

// screens/mode_exercises_screen.dart
class ModeExercisesScreen extends StatelessWidget {
  final ExerciseMode mode;

  const ModeExercisesScreen({super.key, required this.mode});

  String _getModeTitle(ExerciseMode mode) {
    switch (mode) {
      case ExerciseMode.model:
        return 'Ejercicios Modo Modelo';
      case ExerciseMode.hiit:
        return 'Ejercicios Modo HIIT';
      case ExerciseMode.runner:
        return 'Ejercicios Modo Corredor';
      case ExerciseMode.cuello:
        return 'Ejercicios Modo Cuello';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getModeTitle(mode)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditExerciseScreen(
                    mode: mode,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<AppData>(
        builder: (context, appData, child) {
          final exercises = appData.getExercisesByMode(mode);
          if (exercises.isEmpty) {
            return const Center(
              child: Text('No hay ejercicios en este modo aún.'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return ExerciseCard(
                exercise: exercise,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditExerciseScreen(
                        mode: mode,
                        exercise: exercise,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}