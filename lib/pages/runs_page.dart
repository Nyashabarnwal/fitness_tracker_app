import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/fitness_provider.dart';
import '../models/run_entry.dart';
import '../widgets/run_tile.dart';

class RunsPage extends StatelessWidget {
  const RunsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fp = context.watch<FitnessProvider>();

    void openAddSheet() {
      final kmCtrl = TextEditingController();
      final minCtrl = TextEditingController();

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
                'Add Run',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: kmCtrl,
                decoration: const InputDecoration(labelText: 'Kilometers'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              TextField(
                controller: minCtrl,
                decoration: const InputDecoration(labelText: 'Minutes'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  final km = double.tryParse(kmCtrl.text) ?? 0;
                  final min = int.tryParse(minCtrl.text) ?? 0;
                  context.read<FitnessProvider>().addRun(
                    RunEntry(kilometers: km, minutes: min),
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
      body: fp.runs.isEmpty
          ? const Center(child: Text('No runs yet. Tap + to add.'))
          : ListView.builder(
              itemCount: fp.runs.length,
              itemBuilder: (c, i) => RunTile(
                r: fp.runs[i],
                onDelete: () => context.read<FitnessProvider>().removeRun(i),
              ),
            ),
    );
  }
}
