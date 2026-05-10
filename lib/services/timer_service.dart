import 'dart:async';
import 'package:flutter/material.dart';

class TimerService extends ChangeNotifier {
  bool isFocus = true;
  bool isRunning = false;

  final Duration focusDuration = const Duration(seconds: 10); // 25 mins
  final Duration shortBreak = const Duration(seconds: 5); // 5 mins
  final Duration longBreak = const Duration(seconds: 8); // 15 mins

  Timer? _timer;
  int _remainingSeconds = 0;

  int get remainingSeconds => _remainingSeconds;

  // optional callback to notify when focus ends
  VoidCallback? onFocusComplete;

  void start() {
    isRunning = true;
    _setInitialTime();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        _handleComplete();
      }
    });

    notifyListeners();
  }

  void pause() {
    isRunning = false;
    _timer?.cancel();
    notifyListeners();
  }

  void reset() {
    isRunning = false;
    _timer?.cancel();
    _setInitialTime();
    notifyListeners();
  }

  void _setInitialTime() {
    _remainingSeconds = currentDuration.inSeconds;
  }

  Duration get currentDuration {
    if (isFocus) return focusDuration;
    return shortBreak; // long break handled by garden state if needed
  }

  void _handleComplete() {
    if (isFocus) {
      onFocusComplete?.call(); // tell garden "session done"
      isFocus = false;
    } else {
      isFocus = true;
    }

    _setInitialTime();
    notifyListeners();
  }

  String get statusText {
    if (isFocus) return "𓂃✍︎ Focus Time 𓂃✍︎";
    return "ᶻ𝗓𐰁 Break Time ᶻ𝗓𐰁";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
