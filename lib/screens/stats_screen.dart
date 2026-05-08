import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sproutly/utils/app_style.dart';
import '../models/garden_state.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final garden = Provider.of<GardenState>(context);

    return Scaffold(
      backgroundColor: AppColors.background,

      body: Stack(
        children: [
          // content
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  _buildHeader(context, garden),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),

                        child: Column(
                          children: [
                            // core stats
                            _statCard(
                              "Sessions",
                              garden.completedSessions.toString(),
                              garden.completedSessions,
                              20,
                            ),
                            _statCard(
                              "Milestones",
                              _milestoneCount(garden).toString(),
                              _milestoneCount(garden),
                              4,
                            ),
                            _statCard(
                              "Plants Grown",
                              garden.fullyGrownPlants.toString(),
                              garden.fullyGrownPlants,
                              54,
                            ),

                            const SizedBox(height: 10),
                            Divider(color: AppColors.text.withOpacity(0.5)),
                            const SizedBox(height: 10),

                            // progress section
                            const Text(
                              "Garden Progress",
                              style: AppTextStyles.subtitle,
                            ),
                            const SizedBox(height: 6),
                            buildPixelProgress(garden.gardenCompletion / 100),
                            Text(
                              "${garden.gardenCompletion.toStringAsFixed(1)}%",
                              style: AppTextStyles.body,
                            ),

                            const SizedBox(height: 10),
                            Divider(color: AppColors.text.withOpacity(0.5)),
                            const SizedBox(height: 10),

                            // mini garden preview
                            const Text(
                              "Garden Preview",
                              style: AppTextStyles.subtitle,
                            ),
                            const SizedBox(height: 6),
                            miniGardenProgress(garden),

                            const SizedBox(height: 10),
                            Divider(color: AppColors.text.withOpacity(0.5)),
                            const SizedBox(height: 10),

                            // extra stats
                            const Text(
                              "Extra Stats",
                              style: AppTextStyles.subtitle,
                            ),
                            const SizedBox(height: 6),
                            _statCard(
                              "Score",
                              garden.productivityScore.toString(),
                              garden.productivityScore,
                              100,
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
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

  Widget _buildHeader(BuildContext context, GardenState garden) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text("← BACK", style: AppTextStyles.textBtn),
              ),
            ),
          ),

          Text("STATISTICS", style: AppTextStyles.title),

          const SizedBox(height: 6),

          Text(
            _getMotivationMessage(garden),
            style: AppTextStyles.body,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, int current, int max) {
    int blocks = 10;
    int filled = ((current / max) * blocks).clamp(0, blocks).round();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.statCard,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label.toUpperCase(), style: AppTextStyles.body),

              Text(value, style: AppTextStyles.body),
            ],
          ),

          const SizedBox(height: 6),

          Row(
            children: List.generate(blocks, (i) {
              return Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  color: i < filled
                      ? AppColors.progressFilled
                      : AppColors.progressEmpty,
                  // border: Border.all(color: AppColors.gardenBrown, width: 1),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildPixelProgress(double progress) {
    int totalBlocks = 10;
    int filled = (progress * totalBlocks).round();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalBlocks, (index) {
        return Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.all(1),
          color: index < filled
              ? AppColors.progressFilled
              : AppColors.gardenBrown,
        );
      }),
    );
  }

  Widget miniGardenProgress(GardenState garden) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.statCard,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: List.generate(9, (row) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(6, (col) {
              int index = row * 6 + col;
              final tile = garden.tiles[index];

              Color color;

              if (tile.stage == 3) {
                color = AppColors.progressFilled;
              } else if (tile.stage > 0) {
                color = AppColors.gardenLight;
              } else {
                color = AppColors.gardenBrown;
              }

              return Container(
                width: 7,
                height: 7,
                margin: const EdgeInsets.all(1),
                color: color,
              );
            }),
          );
        }),
      ),
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
