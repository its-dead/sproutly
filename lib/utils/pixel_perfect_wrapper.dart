import 'package:flutter/material.dart';
import 'constants.dart';

class PixelPerfectWrapper extends StatelessWidget {
  final Widget child;

  const PixelPerfectWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double scaleX = constraints.maxWidth / AppConstants.baseWidth;
        double scaleY = constraints.maxHeight / AppConstants.baseHeight;

        double scale = (scaleX < scaleY ? scaleX : scaleY).clamp(1.0, 3.0);

        return Container(
          color: Colors.lightGreen[100],
          child: Center(
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.center,
              child: SizedBox(
                width: AppConstants.baseWidth,
                height: AppConstants.baseHeight,
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
