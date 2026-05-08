import 'package:flutter/material.dart';
import 'package:sproutly/utils/app_style.dart';
import 'package:sproutly/utils/settings_helper.dart';
import 'package:sproutly/widgets/pixel_image.dart';
import 'home_screen.dart';
import '../widgets/pixel_button.dart';
import '../utils/pixel_perfect_wrapper.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: PixelImage(
              "assets/images/bgs/title_bg.png",
              fit: BoxFit.cover,
            ),
          ),

          // Logo + tagline
          Positioned(
            top: 5 * 16.0,
            left: 1 * 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // logo
                PixelImage("assets/images/logo/logo.png"),

                const SizedBox(height: 4),

                const Text(
                  "GROW YOUR FOCUS!",
                  style: AppTextStyles.subtitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Button row
          Positioned(
            top: 17 * 16.0,
            left: 1 * 16.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // PLAY
                PixelButton(
                  upImage: "assets/images/ui/buttons/play_up.png",
                  downImage: "assets/images/ui/buttons/play_down.png",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const PixelPerfectWrapper(child: HomeScreen()),
                      ),
                    );
                    // navigate to home
                  },
                ),

                // SETTINGS
                PixelButton(
                  upImage: "assets/images/ui/buttons/settings_up.png",
                  downImage: "assets/images/ui/buttons/settings_down.png",
                  onTap: () => showSettings(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
