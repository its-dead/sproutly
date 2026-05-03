import 'package:flutter/material.dart';
import '../widgets/settings_popup.dart';

void showSettings(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => const SettingsOverlay(),
  );
}
