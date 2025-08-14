class Meal {
  final String name;
  final int calories;
  final DateTime date;

  Meal({required this.name, required this.calories, DateTime? date})
    : date = date ?? DateTime.now();
}
