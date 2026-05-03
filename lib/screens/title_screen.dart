import 'package:flutter/material.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PixelImage("assets/images/logo/logo.png", width: 150),
            const SizedBox(height: 40),

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
              },
            ),

            const SizedBox(height: 20),

            PixelButton(
              upImage: "assets/images/ui/buttons/settings_up.png",
              downImage: "assets/images/ui/buttons/settings_down.png",
              onTap: () => showSettings(context),
            ),
          ],
        ),
      ),
    );
  }
}
