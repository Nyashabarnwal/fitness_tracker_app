import 'package:flutter/material.dart';
import '../models/workout.dart';

class WorkoutTile extends StatelessWidget {
  final Workout w;
  final VoidCallback onDelete;
  const WorkoutTile({super.key, required this.w, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.fitness_center),
      title: Text(w.name),
      subtitle: Text('${w.minutes} min • ${w.calories} kcal'),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      ),
    );
  }
}
