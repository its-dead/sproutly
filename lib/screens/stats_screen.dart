import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/garden_state.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final garden = Provider.of<GardenState>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Statistics")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Motivation
              Center(
                child: Text(
                  _getMotivationMessage(garden),
                  style: const TextStyle(fontSize: 10),
                ),
              ),

              const SizedBox(height: 16),
              Divider(thickness: 1),

              // Core stats
              _statCard("Sessions", garden.completedSessions.toString()),
              _statCard("Milestones", _milestoneCount(garden).toString()),
              _statCard("Plants Grown", garden.fullyGrownPlants.toString()),

              const SizedBox(height: 16),
              Divider(thickness: 1),

              // Progress section
              const Text("Garden Progress"),
              const SizedBox(height: 8),

              buildPixelProgress(garden.gardenCompletion / 100),

              const SizedBox(height: 6),

              Text(
                "${garden.gardenCompletion.toStringAsFixed(1)}%",
                style: const TextStyle(fontSize: 10),
              ),

              const SizedBox(height: 20),

              // Mini garden preview
              const Text("Garden Preview"),
              const SizedBox(height: 8),

              Center(child: miniGardenProgress(garden)),

              const SizedBox(height: 20),
              Divider(thickness: 1),

              // Extra stats
              _statCard("Score", garden.productivityScore.toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.brown.shade200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value)],
      ),
    );
  }

  Widget statBar(String label, int value, int max) {
    int blocks = 10;
    int filled = ((value / max) * blocks).round();

    return Row(
      children: [
        SizedBox(width: 80, child: Text(label)),
        Row(
          children: List.generate(blocks, (i) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.all(1),
              color: i < filled ? Colors.green : Colors.grey,
            );
          }),
        ),
      ],
    );
  }

  Widget buildPixelProgress(double progress) {
    int totalBlocks = 10;
    int filled = (progress * totalBlocks).round();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalBlocks, (index) {
        return Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.all(1),
          color: index < filled ? Colors.green : Colors.brown,
        );
      }),
    );
  }

  Widget miniGardenProgress(GardenState garden) {
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: garden.tiles.map((tile) {
        return Container(
          width: 6,
          height: 6,
          color: tile.stage == 3
              ? Colors.green
              : tile.stage > 0
              ? Colors.lightGreen
              : Colors.brown,
        );
      }).toList(),
    );
  }

  int _milestoneCount(GardenState garden) {
    int count = 0;
    if (garden.hasHouse) count++;
    if (garden.hasLandscape) count++;
    if (garden.hasFlowers) count++;
    if (garden.hasPond) count++;
    return count;
  }

  String _getMotivationMessage(GardenState garden) {
    if (garden.completedSessions < 5) {
      return "Keep going ⚘ your garden is just starting!";
    } else if (garden.completedSessions < 15) {
      return "Nice progress ✮ consistency is key!";
    } else {
      return "You're on fire ঌ your garden is thriving!";
    }
  }
}
