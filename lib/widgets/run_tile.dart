import 'package:flutter/material.dart';
import '../models/run_entry.dart';

class RunTile extends StatelessWidget {
  final RunEntry r;
  final VoidCallback onDelete;
  const RunTile({super.key, required this.r, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final pace = r.kilometers == 0
        ? '-'
        : '${(r.paceMinPerKm).toStringAsFixed(1)} min/km';
    return ListTile(
      leading: const Icon(Icons.directions_run),
      title: Text('${r.kilometers.toStringAsFixed(2)} km'),
      subtitle: Text('${r.minutes} min • $pace'),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      ),
    );
  }
}
