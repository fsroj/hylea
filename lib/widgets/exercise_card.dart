import 'package:flutter/material.dart';
import 'package:hylea/models/exercise.dart';
import 'package:hylea/widgets/mode_tag.dart';

// widgets/exercise_card.dart
class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback onTap;
  final bool showCheckbox;
  final bool? isCompleted;
  final ValueChanged<bool?>? onCheckboxChanged;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onTap,
    this.showCheckbox = false,
    this.isCompleted,
    this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ModeTag(mode: exercise.mode),
                    const SizedBox(height: 8.0),
                    Text(
                      exercise.name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Repeticiones por serie: ${exercise.repetitionsPerSet}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (showCheckbox)
                Checkbox(
                  value: isCompleted,
                  onChanged: onCheckboxChanged,
                  activeColor: Theme.of(context).primaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}