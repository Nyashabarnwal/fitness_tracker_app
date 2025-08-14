import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/fitness_provider.dart';
import '../widgets/stat_card.dart';
import 'workouts_page.dart';
import 'runs_page.dart';
import 'nutrition_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final fp = context.watch<FitnessProvider>();

    final pages = const [WorkoutsPage(), RunsPage(), NutritionPage()];

    return Scaffold(
      appBar: AppBar(title: const Text('Fitness Tracker')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                StatCard(
                  title: 'Workout Minutes (today)',
                  value: '${fp.todayWorkoutMinutes}',
                  icon: Icons.timer,
                ),
                StatCard(
                  title: 'Run Distance (today)',
                  value: '${fp.todayRunKm.toStringAsFixed(2)} km',
                  icon: Icons.directions_run,
                ),
                StatCard(
                  title: 'Calories Consumed (today)',
                  value: '${fp.todayCaloriesConsumed} kcal',
                  icon: Icons.local_fire_department,
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Expanded(child: pages[_index]),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),
          NavigationDestination(
            icon: Icon(Icons.run_circle_outlined),
            label: 'Runs',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant),
            label: 'Nutrition',
          ),
        ],
      ),
    );
  }
}
