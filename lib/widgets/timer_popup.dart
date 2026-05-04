import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sproutly/widgets/pixel_image.dart';
import '../models/garden_state.dart';
import '../services/timer_service.dart';

class TimerPopup extends StatefulWidget {
  const TimerPopup({super.key});

  @override
  State<TimerPopup> createState() => _TimerPopupState();
}

class _TimerPopupState extends State<TimerPopup> {
  @override
  void initState() {
    super.initState();

    final timer = context.read<TimerService>();

    timer.onFocusComplete = () {
      context.read<GardenState>().completeSession();
    };
  }

  String formatTime(int seconds) {
    int min = seconds ~/ 60;
    int sec = seconds % 60;
    return "$min:${sec.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final timer = context.watch<TimerService>();

    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(color: Colors.black.withOpacity(0.6)),
        ),

        // panel
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              PixelImage("assets/images/ui/panels/timer_panel.png"),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formatTime(timer.remainingSeconds),
                    style: const TextStyle(fontSize: 20),
                  ),

                  const SizedBox(height: 6),

                  Text(timer.statusText),

                  const SizedBox(height: 12),

                  // text controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          timer.isRunning ? timer.pause() : timer.start();
                        },
                        child: Text(
                          timer.isRunning ? "❚❚ Pause" : "▶ Start",
                          style: const TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      GestureDetector(
                        onTap: timer.reset,
                        child: const Text(
                          "↺ Reset",
                          style: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
