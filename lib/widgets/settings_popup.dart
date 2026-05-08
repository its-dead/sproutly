import 'package:flutter/material.dart';
import 'package:sproutly/utils/app_style.dart';
import 'package:sproutly/widgets/pixel_image.dart';

class SettingsPopup extends StatefulWidget {
  const SettingsPopup({super.key});

  @override
  State<SettingsPopup> createState() => _SettingsPopupState();
}

class _SettingsPopupState extends State<SettingsPopup> {
  bool sound = false;
  bool vibration = false;
  bool notifications = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),

          Center(
            child: Transform.scale(
              scale: 2.0,
              child: SizedBox(
                width: 8 * 16.0,
                height: 9 * 16.0,
                child: Stack(
                  children: [
                    // panel image
                    Positioned.fill(
                      child: PixelImage(
                        "assets/images/ui/panels/settings_panel.png",
                        width: 8 * 16.0,
                        height: 9 * 16.0,
                      ),
                    ),

                    // content
                    Column(
                      children: [
                        const SizedBox(height: 40),

                        _buildToggle("Sound", false, (_) {}),
                        _buildToggle("Vibration", false, (_) {}),
                        _buildToggle("Notifications", false, (_) {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle(String label, bool value, Function(bool) onToggle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
      child: SizedBox(
        width: 6 * 16.0,
        height: 28.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.body,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            GestureDetector(
              onTap: () => onToggle(!value),
              child: SizedBox(
                width: 28.0,
                height: 28.0,
                child: PixelImage(
                  value
                      ? "assets/images/ui/buttons/toggle_on.png"
                      : "assets/images/ui/buttons/toggle_off.png",
                  width: 28.0,
                  height: 28.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
