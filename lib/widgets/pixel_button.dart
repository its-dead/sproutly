import 'package:flutter/material.dart';

class PixelButton extends StatefulWidget {
  final String upImage;
  final String downImage;
  final VoidCallback onTap;
  final double? width;
  final double? height;

  const PixelButton({
    super.key,
    required this.upImage,
    required this.downImage,
    required this.onTap,
    this.width,
    this.height,
  });

  @override
  State<PixelButton> createState() => _PixelButtonState();
}

class _PixelButtonState extends State<PixelButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => isPressed = false),

      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Image.asset(
          isPressed ? widget.downImage : widget.upImage,
          fit: BoxFit.none,
          filterQuality: FilterQuality.none,
        ),
      ),
    );
  }
}
