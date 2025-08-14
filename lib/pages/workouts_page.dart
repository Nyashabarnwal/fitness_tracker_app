import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/fitness_provider.dart';
import '../models/workout.dart';
import '../widgets/workout_tile.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fp = context.watch<FitnessProvider>();

    void openAddSheet() {
      final nameCtrl = TextEditingController();
      final minCtrl = TextEditingController();
      final calCtrl = TextEditingController();

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) => Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Workout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Name (e.g. Push Day)',
                ),
              ),
              TextField(
                controller: minCtrl,
                decoration: const InputDecoration(labelText: 'Minutes'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: calCtrl,
                decoration: const InputDecoration(labelText: 'Calories'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (nameCtrl.text.isEmpty) return;
                  final minutes = int.tryParse(minCtrl.text) ?? 0;
                  final calories = int.tryParse(calCtrl.text) ?? 0;
                  context.read<FitnessProvider>().addWorkout(
                    Workout(
                      name: nameCtrl.text.trim(),
                      minutes: minutes,
                      calories: calories,
                    ),
                  );
                  Navigator.pop(ctx);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: openAddSheet,
        child: const Icon(Icons.add),
      ),
      body: fp.workouts.isEmpty
          ? const Center(child: Text('No workouts yet. Tap + to add.'))
          : ListView.builder(
              itemCount: fp.workouts.length,
              itemBuilder: (c, i) => WorkoutTile(
                w: fp.workouts[i],
                onDelete: () =>
                    context.read<FitnessProvider>().removeWorkout(i),
              ),
            ),
    );
  }
}
