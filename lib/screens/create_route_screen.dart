import 'package:flutter/material.dart';
import 'package:hylea/data/app_data.dart';
import 'package:hylea/models/route.dart';
import 'package:hylea/widgets/mode_tag.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart'; // For generating unique IDsgenerating unique IDs

// screens/create_route_screen.dart
class CreateRouteScreen extends StatefulWidget {
  final ExerciseRoute? route; // Null if creating, not null if editing

  const CreateRouteScreen({super.key, this.route});

  @override
  State<CreateRouteScreen> createState() => _CreateRouteScreenState();
}

class _CreateRouteScreenState extends State<CreateRouteScreen> {
  final _routeNameController = TextEditingController();
  final List<String> _selectedExerciseIds = [];
  final Uuid _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    if (widget.route != null) {
      _routeNameController.text = widget.route!.name;
      _selectedExerciseIds.addAll(widget.route!.exerciseIds);
    }
  }

  @override
  void dispose() {
    _routeNameController.dispose();
    super.dispose();
  }

  void _saveRoute() {
    if (_routeNameController.text.isEmpty || _selectedExerciseIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor, introduce un nombre y selecciona al menos un ejercicio.')),
      );
      return;
    }

    final appData = Provider.of<AppData>(context, listen: false);
    if (widget.route == null) {
      // Create new route
      final newRoute = ExerciseRoute(
        id: _uuid.v4(),
        name: _routeNameController.text,
        exerciseIds: List.from(_selectedExerciseIds),
      );
      appData.addRoute(newRoute);
    } else {
      // Update existing route
      widget.route!.name = _routeNameController.text;
      widget.route!.exerciseIds = List.from(_selectedExerciseIds);
      appData.updateRoute(widget.route!);
    }
    Navigator.pop(context); // Go back to routes list
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);
    final allExercises = appData.exercises;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.route == null ? 'Crear Ruta' : 'Editar Ruta'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _routeNameController,
              decoration: InputDecoration(
                labelText: 'Nombre de la Ruta',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.route),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allExercises.length,
              itemBuilder: (context, index) {
                final exercise = allExercises[index];
                final isSelected = _selectedExerciseIds.contains(exercise.id);
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: CheckboxListTile(
                    title: Text(exercise.name),
                    subtitle: ModeTag(mode: exercise.mode),
                    value: isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _selectedExerciseIds.add(exercise.id);
                        } else {
                          _selectedExerciseIds.remove(exercise.id);
                        }
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _saveRoute,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50), // Full width button
              ),
              child: Text(
                widget.route == null ? 'Guardar Ruta' : 'Actualizar Ruta',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}