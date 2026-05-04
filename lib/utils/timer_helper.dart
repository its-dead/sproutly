import 'package:flutter/material.dart';
import 'package:sproutly/widgets/timer_popup.dart';

void openTimer(BuildContext context) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      barrierDismissible: true,
      pageBuilder: (_, __, ___) => const TimerPopup(),
    ),
  );
}
