import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/garden_state.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final garden = Provider.of<GardenState>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF3E7D3),

      body: Stack(
        children: [
          // content
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  _buildHeader(garden),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // core stats
                          _statCard(
                            "Sessions",
                            garden.completedSessions.toString(),
                          ),
                          _statCard(
                            "Milestones",
                            _milestoneCount(garden).toString(),
                          ),
                          _statCard(
                            "Plants Grown",
                            garden.fullyGrownPlants.toString(),
                          ),

                          const SizedBox(height: 12),

                          // progress section
                          const Text("Garden Progress"),
                          buildPixelProgress(garden.gardenCompletion / 100),
                          Text(
                            "${garden.gardenCompletion.toStringAsFixed(1)}%",
                            style: const TextStyle(fontSize: 10),
                          ),

                          const SizedBox(height: 12),

                          // mini garden preview
                          const Text("Garden Preview"),
                          miniGardenProgress(garden),

                          const SizedBox(height: 12),

                          // extra stats
                          const Text("Extra Stats"),
                          _statCard(
                            "Score",
                            garden.productivityScore.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(GardenState garden) {
    return Column(
      children: [
        Text(
          _getMotivationMessage(garden),
          style: const TextStyle(fontSize: 10),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
      ],
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
