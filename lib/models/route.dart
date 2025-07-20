class ExerciseRoute {
  final String id;
  String name;
  List<String> exerciseIds; // List of exercise IDs in this route

  ExerciseRoute({
    required this.id,
    required this.name,
    required this.exerciseIds,
  });

  // Factory constructor to create an ExerciseRoute from a map
  factory ExerciseRoute.fromMap(Map<String, dynamic> map) {
    return ExerciseRoute(
      id: map['id'],
      name: map['name'],
      exerciseIds: List<String>.from(map['exerciseIds']),
    );
  }

  // Convert an ExerciseRoute object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'exerciseIds': exerciseIds,
    };
  }
}