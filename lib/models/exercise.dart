import 'package:hylea/data/app_data.dart';

// models/exercise.dart
class Exercise {
  final String id;
  String name;
  String description;
  int repetitionsPerSet;
  ExerciseMode mode;
  String? imageUrl;
  String? gifUrl;
  String? videoUrl;
  String? linkUrl;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.repetitionsPerSet,
    required this.mode,
    this.imageUrl,
    this.gifUrl,
    this.videoUrl,
    this.linkUrl,
  });

  // Factory constructor to create an Exercise from a map
  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      repetitionsPerSet: map['repetitionsPerSet'],
      mode: ExerciseMode.values.firstWhere(
        (e) => e.toString().split('.').last == map['mode']),
      imageUrl: map['imageUrl'],
      gifUrl: map['gifUrl'],
      videoUrl: map['videoUrl'],
      linkUrl: map['linkUrl'],
    );
  }

  // Convert an Exercise object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'repetitionsPerSet': repetitionsPerSet,
      'mode': mode.toString().split('.').last,
      'imageUrl': imageUrl,
      'gifUrl': gifUrl,
      'videoUrl': videoUrl,
      'linkUrl': linkUrl,
    };
  }
}
