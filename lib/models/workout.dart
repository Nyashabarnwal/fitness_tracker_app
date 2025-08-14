class Workout {
  final String name;
  final int minutes;
  final int calories;
  final DateTime date;

  Workout({
    required this.name,
    required this.minutes,
    required this.calories,
    DateTime? date,
  }) : date = date ?? DateTime.now();
}
