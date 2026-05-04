import 'package:flutter/material.dart';
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
    return Stack(
      children: [
        // background dim
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(color: Colors.black.withOpacity(0.6)),
        ),

        Center(
          child: Stack(
            children: [
              // PANEL BACKGROUND
              PixelImage(
                "assets/images/ui/panels/settings_panel.png",
                width: 8 * 16,
                height: 9 * 16,
              ),

              // INTERACTIVE LAYER
              SizedBox(
                width: 8 * 16,
                height: 9 * 16,
                child: Stack(
                  children: [
                    _buildToggle(
                      4,
                      "Sound",
                      sound,
                      (value) => setState(() => sound = value),
                    ),
                    _buildToggle(
                      6,
                      "Vibration",
                      vibration,
                      (value) => setState(() => vibration = value),
                    ),
                    _buildToggle(
                      8,
                      "Notifications",
                      notifications,
                      (value) => setState(() => notifications = value),
                    ),

                    _buildCloseButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToggle(
    int row,
    String label,
    bool value,
    Function(bool) onToggle,
  ) {
    return Positioned(
      top: row * 16.0,
      left: 1 * 16.0,
      right: 1 * 16.0,
      child: SizedBox(
        height: 32, // match toggle height
        child: Row(
          children: [
            // TEXT (flexible)
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 10),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // small spacing (pixel-friendly)
            const SizedBox(width: 4),

            // TOGGLE (fixed size)
            GestureDetector(
              onTap: () => onToggle(!value),
              child: SizedBox(
                width: 32,
                height: 32,
                child: PixelImage(
                  value
                      ? "assets/images/ui/buttons/toggle_on.png"
                      : "assets/images/ui/buttons/toggle_off.png",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Positioned(
      bottom: 8,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Text("Close", style: TextStyle(fontSize: 10)),
        ),
      ),
    );
  }
}
