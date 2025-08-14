class RunEntry {
  final double kilometers; // e.g. 5.2
  final int minutes; // duration in minutes
  final DateTime date;

  RunEntry({required this.kilometers, required this.minutes, DateTime? date})
    : date = date ?? DateTime.now();

  double get paceMinPerKm => kilometers == 0 ? 0 : minutes / kilometers;
}
