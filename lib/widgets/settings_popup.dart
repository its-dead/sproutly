import 'package:flutter/material.dart';

class SettingsOverlay extends StatelessWidget {
  const SettingsOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // background dim
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(color: Colors.black.withOpacity(0.6)),
        ),

        // 📦 panel
        Center(
          child: Container(
            width: 10 * 16.0,
            height: 12 * 16.0,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.brown.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Text("Settings", style: TextStyle(fontSize: 12)),

                const SizedBox(height: 8),

                // example toggles (you can expand later)
                _buildOption("Sound", true),
                _buildOption("Vibration", true),
                _buildOption("Notifications", true),

                const Spacer(),

                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOption(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 10)),
          Switch(value: value, onChanged: (_) {}),
        ],
      ),
    );
  }
}
