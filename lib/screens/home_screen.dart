import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sproutly/utils/pixel_perfect_wrapper.dart';
import 'package:sproutly/utils/plant_assets.dart';
import 'package:sproutly/utils/settings_helper.dart';
import 'package:sproutly/widgets/feedback_overlay.dart';
import 'package:sproutly/widgets/pixel_button.dart';
import 'package:sproutly/widgets/pixel_image.dart';
import '../models/garden_state.dart';
import '../widgets/garden_grid.dart';
import '../widgets/timer_popup.dart';
import 'stats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<GardenState>(context, listen: false).loadGarden();
    });
  }

  void openTimer() {
    showDialog(
      context: context,
      builder: (_) => const PixelPerfectWrapper(child: TimerPopup()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final garden = Provider.of<GardenState>(context);
    const FeedbackOverlay();

    if (!garden.isLoaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: PixelImage(
              "assets/images/bgs/garden_bg.png",
              fit: BoxFit.cover,
            ),
          ),

          // Milestones
          _buildMilestones(),

          // Garden Grid
          _buildGardenGrid(),

          // Plant Layer
          _buildPlantLayer(),

          // Top bar
          _buildTopBar(),

          // Bottom nav
          _buildBottomNav(),

          FeedbackOverlay(),
        ],
      ),
    );
  }

  Widget _buildGardenGrid() {
    return Positioned(
      top: 9 * 16,
      left: 2 * 16,
      child: SizedBox(width: 6 * 16, height: 9 * 16, child: const GardenGrid()),
    );
  }

  Widget _buildPlantLayer() {
    final garden = context.watch<GardenState>();

    return Positioned.fill(
      child: Stack(
        children: List.generate(54, (index) {
          final tile = garden.tiles[index];

          if (tile.stage == 0) return const SizedBox();

          return Positioned(
            left: (index % 6) * 16.0 + (2 * 16),
            top: (index ~/ 6) * 16.0 + (9 * 16) - (tile.stage == 3 ? 16 : 0),
            child: PixelImage(
              getPlantAsset(tile),
              width: 16,
              height: tile.stage == 3 ? 32 : 16,
              fit: BoxFit.fill,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildMilestones() {
    final garden = context.watch<GardenState>();

    return Stack(
      children: [
        if (garden.hasHouse)
          Positioned.fill(
            child: PixelImage(
              "assets/images/decorations/house_layer.png",
              fit: BoxFit.cover,
            ),
          ),

        if (garden.hasLandscape)
          Positioned.fill(
            child: PixelImage(
              "assets/images/decorations/landscape_layer.png",
              fit: BoxFit.cover,
            ),
          ),

        if (garden.hasFlowers)
          Positioned.fill(
            child: PixelImage(
              "assets/images/decorations/flowers_layer.png",
              fit: BoxFit.cover,
            ),
          ),

        if (garden.hasPond)
          Positioned.fill(
            child: PixelImage(
              "assets/images/decorations/pond_layer.png",
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 0,
      right: 0,
      child: SizedBox(
        width: 10 * 16,
        height: 2 * 16,
        child: Align(
          alignment: Alignment.centerRight,
          child: PixelButton(
            upImage: "assets/images/ui/buttons/settings_up.png",
            downImage: "assets/images/ui/buttons/settings_down.png",
            onTap: () => showSettings(context),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Positioned(
      bottom: 0,
      left: 0,
      child: SizedBox(
        width: 10 * 16,
        height: 2 * 16,
        child: Stack(
          children: [
            // HOME
            PixelButton(
              upImage: "assets/images/ui/buttons/home_up.png",
              downImage: "assets/images/ui/buttons/home_down.png",
              onTap: () {},
            ),

            // TIMER
            PixelButton(
              upImage: "assets/images/ui/buttons/timer_up.png",
              downImage: "assets/images/ui/buttons/timer_down.png",
              onTap: openTimer,
            ),

            // STATS
            PixelButton(
              upImage: "assets/images/ui/buttons/stats_up.png",
              downImage: "assets/images/ui/buttons/stats_down.png",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const PixelPerfectWrapper(child: StatsScreen()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
