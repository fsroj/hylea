import 'package:flutter/material.dart';
import 'package:hylea/models/exercise.dart';
import 'package:hylea/models/route.dart';
import 'package:uuid/uuid.dart'; // For generating unique IDsgenerating unique IDs

// data/app_data.dart
enum ExerciseMode {
  model,
  hiit,
  runner,
  cuello,
}

class AppData extends ChangeNotifier {

  // Initial dummy data for exercises
  final List<Exercise> _exercises = [
    Exercise(
      id: const Uuid().v4(),
      name: 'Sentadilla con Barra',
      description: 'Ejercicio de fuerza para piernas y glúteos.',
      repetitionsPerSet: 10,
      mode: ExerciseMode.model,
    ),
    Exercise(
      id: const Uuid().v4(),
      name: 'Press de Banca',
      description: 'Ejercicio para pecho, hombros y tríceps.',
      repetitionsPerSet: 8,
      mode: ExerciseMode.model,
    ),
    Exercise(
      id: const Uuid().v4(),
      name: 'Burpees',
      description: 'Ejercicio de cuerpo completo de alta intensidad.',
      repetitionsPerSet: 15,
      mode: ExerciseMode.hiit,
    ),
    Exercise(
      id: const Uuid().v4(),
      name: 'Saltos de Tijera',
      description: 'Ejercicio cardiovascular rápido.',
      repetitionsPerSet: 20,
      mode: ExerciseMode.hiit,
    ),
    Exercise(
      id: const Uuid().v4(),
      name: 'Carrera Larga',
      description: 'Mantener un ritmo constante para resistencia.',
      repetitionsPerSet: 0, // Not applicable for running, could be duration
      mode: ExerciseMode.runner,
    ),
    Exercise(
      id: const Uuid().v4(),
      name: 'Estiramiento de Cuello Lateral',
      description: 'Estiramiento suave para el cuello.',
      repetitionsPerSet: 1, // Hold for a duration
      mode: ExerciseMode.cuello,
    ),
  ];

  final List<ExerciseRoute> _routes = [];

  List<Exercise> get exercises => List.unmodifiable(_exercises);
  List<ExerciseRoute> get routes => List.unmodifiable(_routes);

  // Get exercises filtered by mode
  List<Exercise> getExercisesByMode(ExerciseMode mode) {
    return _exercises.where((e) => e.mode == mode).toList();
  }

  // Get a single exercise by ID
  Exercise? getExerciseById(String id) {
    try {
      return _exercises.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  // Add a new exercise
  void addExercise(Exercise exercise) {
    _exercises.add(exercise);
    notifyListeners();
  }

  // Update an existing exercise
  void updateExercise(Exercise updatedExercise) {
    final index =
        _exercises.indexWhere((e) => e.id == updatedExercise.id);
    if (index != -1) {
      _exercises[index] = updatedExercise;
      notifyListeners();
    }
  }

  // Delete an exercise
  void deleteExercise(String id) {
    _exercises.removeWhere((e) => e.id == id);
    // Also remove from any routes that contain this exercise
    for (var route in _routes) {
      route.exerciseIds.remove(id);
    }
    notifyListeners();
  }

  // Add a new route
  void addRoute(ExerciseRoute route) {
    _routes.add(route);
    notifyListeners();
  }

  // Update an existing route
  void updateRoute(ExerciseRoute updatedRoute) {
    final index = _routes.indexWhere((r) => r.id == updatedRoute.id);
    if (index != -1) {
      _routes[index] = updatedRoute;
      notifyListeners();
    }
  }

  // Delete a route
  void deleteRoute(String id) {
    _routes.removeWhere((r) => r.id == id);
    notifyListeners();
  }
}