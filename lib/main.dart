import 'package:flutter/material.dart';
import 'package:sproutly/screens/title_screen.dart';
import 'package:provider/provider.dart';
import 'package:sproutly/services/timer_service.dart';
import 'models/garden_state.dart';
import 'utils/pixel_perfect_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // prevents blurry pixels
  PaintingBinding.instance.imageCache.maximumSize = 1000;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GardenState()),
        ChangeNotifierProvider(create: (_) => TimerService()),
      ],
      child: const SproutlyApp(),
    ),
  );
}

class SproutlyApp extends StatelessWidget {
  const SproutlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PixelPerfectWrapper(child: TitleScreen()),
    );
  }
}
