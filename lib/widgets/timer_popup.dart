import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

    return AlertDialog(
      title: const Text("Focus Timer"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            formatTime(timer.remainingSeconds),
            style: const TextStyle(fontSize: 32),
          ),

          const SizedBox(height: 8),

          Text(timer.statusText),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  timer.isRunning ? timer.pause() : timer.start();
                },
                child: Text(timer.isRunning ? "Pause" : "Start"),
              ),
              ElevatedButton(
                onPressed: () => timer.reset(),
                child: const Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
