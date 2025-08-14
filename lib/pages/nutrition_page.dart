import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/fitness_provider.dart';
import '../models/meal.dart';
import '../widgets/meal_tile.dart';

class NutritionPage extends StatelessWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fp = context.watch<FitnessProvider>();

    void openAddSheet() {
      final nameCtrl = TextEditingController();
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
                'Add Meal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Meal name (e.g. Oats)',
                ),
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
                  final calories = int.tryParse(calCtrl.text) ?? 0;
                  context.read<FitnessProvider>().addMeal(
                    Meal(name: nameCtrl.text.trim(), calories: calories),
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
      body: fp.meals.isEmpty
          ? const Center(child: Text('No meals yet. Tap + to add.'))
          : ListView.builder(
              itemCount: fp.meals.length,
              itemBuilder: (c, i) => MealTile(
                m: fp.meals[i],
                onDelete: () => context.read<FitnessProvider>().removeMeal(i),
              ),
            ),
    );
  }
}
