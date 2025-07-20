import 'package:flutter/material.dart';
import 'package:hylea/data/app_data.dart';
import 'package:hylea/models/exercise.dart';
import 'package:hylea/models/route.dart';
import 'package:hylea/screens/exercise_detail_screen.dart';
import 'package:hylea/widgets/exercise_card.dart';
import 'package:provider/provider.dart';

// screens/route_detail_screen.dart
class RouteDetailScreen extends StatefulWidget {
  final ExerciseRoute route;

  const RouteDetailScreen({super.key, required this.route});

  @override
  State<RouteDetailScreen> createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen> {
  // Map to store completion status for each exercise in the current route
  final Map<String, bool> _completedExercises = {};

  @override
  void initState() {
    super.initState();
    // Initialize all exercises in the route as not completed
    for (var id in widget.route.exerciseIds) {
      _completedExercises[id] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);
    final exercisesInRoute = widget.route.exerciseIds
        .map((id) => appData.getExerciseById(id))
        .whereType<Exercise>() // Filter out nulls if an exercise was deleted
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.route.name),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: exercisesInRoute.isEmpty
          ? const Center(
              child: Text('Esta ruta no tiene ejercicios definidos.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: exercisesInRoute.length,
              itemBuilder: (context, index) {
                final exercise = exercisesInRoute[index];
                return ExerciseCard(
                  exercise: exercise,
                  showCheckbox: true,
                  isCompleted: _completedExercises[exercise.id] ?? false,
                  onCheckboxChanged: (bool? value) {
                    setState(() {
                      _completedExercises[exercise.id] = value ?? false;
                    });
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExerciseDetailScreen(exercise: exercise),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}