import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/garden_state.dart';

class FeedbackOverlay extends StatefulWidget {
  const FeedbackOverlay({super.key});

  @override
  State<FeedbackOverlay> createState() => _FeedbackOverlayState();
}

class _FeedbackOverlayState extends State<FeedbackOverlay> {
  @override
  Widget build(BuildContext context) {
    final garden = context.watch<GardenState>();

    if (garden.feedbackQueue.isEmpty) return const SizedBox();

    final feedback = garden.feedbackQueue.first;

    return Positioned(
      top: 4 * 16,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.black.withOpacity(0.6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(feedback.text, style: const TextStyle(fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
