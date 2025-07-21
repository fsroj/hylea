import 'package:flutter/material.dart';
import 'package:hylea/data/app_data.dart';
import 'package:hylea/models/exercise.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart'; // For generating unique IDsgenerating unique IDs

// screens/add_edit_exercise_screen.dart
class AddEditExerciseScreen extends StatefulWidget {
  final ExerciseMode mode;
  final Exercise? exercise; // Null if adding, not null if editing

  const AddEditExerciseScreen({
    super.key,
    required this.mode,
    this.exercise,
  });

  @override
  State<AddEditExerciseScreen> createState() => _AddEditExerciseScreenState();
}

class _AddEditExerciseScreenState extends State<AddEditExerciseScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _repetitionsController;
  late TextEditingController _imageUrlController;
  late TextEditingController _gifUrlController;
  late TextEditingController _videoUrlController;
  late TextEditingController _linkUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.exercise?.name ?? '');
    _descriptionController = TextEditingController(text: widget.exercise?.description ?? '');
    _repetitionsController = TextEditingController(text: widget.exercise?.repetitionsPerSet.toString() ?? '');
    _imageUrlController = TextEditingController(text: widget.exercise?.imageUrl ?? '');
    _gifUrlController = TextEditingController(text: widget.exercise?.gifUrl ?? '');
    _videoUrlController = TextEditingController(text: widget.exercise?.videoUrl ?? '');
    _linkUrlController = TextEditingController(text: widget.exercise?.linkUrl ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _repetitionsController.dispose();
    _imageUrlController.dispose();
    _gifUrlController.dispose();
    _videoUrlController.dispose();
    _linkUrlController.dispose();
    super.dispose();
  }

  void _saveExercise() {
    if (_formKey.currentState!.validate()) {
      final appData = Provider.of<AppData>(context, listen: false);
      final String name = _nameController.text;
      final String description = _descriptionController.text;
      final int repetitions = int.parse(_repetitionsController.text);
      final String? imageUrl = _imageUrlController.text.isNotEmpty ? _imageUrlController.text : null;
      final String? gifUrl = _gifUrlController.text.isNotEmpty ? _gifUrlController.text : null;
      final String? videoUrl = _videoUrlController.text.isNotEmpty ? _videoUrlController.text : null;
      final String? linkUrl = _linkUrlController.text.isNotEmpty ? _linkUrlController.text : null;

      if (widget.exercise == null) {
        // Add new exercise
        final newExercise = Exercise(
          id: const Uuid().v4(),
          name: name,
          description: description,
          repetitionsPerSet: repetitions,
          mode: widget.mode,
          imageUrl: imageUrl,
          gifUrl: gifUrl,
          videoUrl: videoUrl,
          linkUrl: linkUrl,
        );
        appData.addExercise(newExercise);
      } else {
        // Update existing exercise
        widget.exercise!.name = name;
        widget.exercise!.description = description;
        widget.exercise!.repetitionsPerSet = repetitions;
        widget.exercise!.imageUrl = imageUrl;
        widget.exercise!.gifUrl = gifUrl;
        widget.exercise!.videoUrl = videoUrl;
        widget.exercise!.linkUrl = linkUrl;
        appData.updateExercise(widget.exercise!);
      }
      Navigator.pop(context);
    }
  }

  void _deleteExercise() {
    if (widget.exercise != null) {
      Provider.of<AppData>(context, listen: false)
          .deleteExercise(widget.exercise!.id);
      Navigator.pop(context); // Pop from edit screen
      Navigator.pop(context); // Pop from mode exercises screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise == null
            ? 'Añadir Ejercicio'
            : 'Editar Ejercicio'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (widget.exercise != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: _deleteExercise,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre del Ejercicio',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.label),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.description),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce una descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _repetitionsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Repeticiones por Serie',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.repeat),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un número de repeticiones';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, introduce un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                  labelText: 'URL de Imagen (opcional)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.image),
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _gifUrlController,
                decoration: InputDecoration(
                  labelText: 'URL de GIF (opcional)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.gif),
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _videoUrlController,
                decoration: InputDecoration(
                  labelText: 'URL de Video (opcional)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.video_library),
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _linkUrlController,
                decoration: InputDecoration(
                  labelText: 'URL de Enlace (opcional)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(Icons.link),
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveExercise,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  widget.exercise == null ? 'Guardar Ejercicio' : 'Actualizar',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}