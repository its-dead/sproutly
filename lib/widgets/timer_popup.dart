import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sproutly/utils/app_style.dart';
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

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),

          // panel
          Center(
            child: Transform.scale(
              scale: 2.0,
              child: SizedBox(
                width: 8 * 16.0,
                height: 11 * 16.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: PixelImage(
                        "assets/images/ui/panels/timer_panel.png",
                        width: 8 * 16.0,
                        height: 11 * 16.0,
                      ),
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // TITLE
                        Text("FOCUS TIMER", style: AppTextStyles.title),

                        const SizedBox(height: 8),

                        // TIMER
                        Text(
                          formatTime(timer.remainingSeconds),
                          style: AppTextStyles.title.copyWith(fontSize: 30),
                        ),

                        const SizedBox(height: 1),

                        // STATUS
                        Text(timer.statusText, style: AppTextStyles.body),

                        const SizedBox(height: 12),

                        // CONTROLS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                timer.isRunning ? timer.pause() : timer.start();
                              },
                              child: Text(
                                timer.isRunning ? "❚❚ PAUSE" : "▶ START",
                                style: AppTextStyles.textBtn,
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: timer.reset,
                              child: Text(
                                "↺ RESET",
                                style: AppTextStyles.textBtn,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),
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
}
