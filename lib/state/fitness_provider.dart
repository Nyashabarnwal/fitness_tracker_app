import 'package:flutter/foundation.dart';
import '../models/workout.dart';
import '../models/run_entry.dart';
import '../models/meal.dart';

class FitnessProvider extends ChangeNotifier {
  final List<Workout> _workouts = [];
  final List<RunEntry> _runs = [];
  final List<Meal> _meals = [];

  List<Workout> get workouts => List.unmodifiable(_workouts);
  List<RunEntry> get runs => List.unmodifiable(_runs);
  List<Meal> get meals => List.unmodifiable(_meals);

  // add
  void addWorkout(Workout w) {
    _workouts.add(w);
    notifyListeners();
  }

  void addRun(RunEntry r) {
    _runs.add(r);
    notifyListeners();
  }

  void addMeal(Meal m) {
    _meals.add(m);
    notifyListeners();
  }

  // remove
  void removeWorkout(int i) {
    _workouts.removeAt(i);
    notifyListeners();
  }

  void removeRun(int i) {
    _runs.removeAt(i);
    notifyListeners();
  }

  void removeMeal(int i) {
    _meals.removeAt(i);
    notifyListeners();
  }

  // daily stats (today)
  DateTime get _today => DateTime.now();
  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  int get todayWorkoutMinutes => _workouts
      .where((w) => _isSameDay(w.date, _today))
      .fold(0, (p, w) => p + w.minutes);

  int get todayWorkoutCalories => _workouts
      .where((w) => _isSameDay(w.date, _today))
      .fold(0, (p, w) => p + w.calories);

  double get todayRunKm => _runs
      .where((r) => _isSameDay(r.date, _today))
      .fold(0.0, (p, r) => p + r.kilometers);

  int get todayRunMinutes => _runs
      .where((r) => _isSameDay(r.date, _today))
      .fold(0, (p, r) => p + r.minutes);

  int get todayCaloriesConsumed => _meals
      .where((m) => _isSameDay(m.date, _today))
      .fold(0, (p, m) => p + m.calories);
}
