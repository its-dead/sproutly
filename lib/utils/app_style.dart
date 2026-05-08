import 'package:flutter/material.dart';

class AppColors {
  // base colours
  static const Color background = Color(0xFFDCB98A);
  static const Color text = Color(0xFFF3F4E7);

  // stats screen
  static const Color statCard = Color(0xFFB68962);
  static const Color progressFilled = Color(0xFF78A158);
  static const Color progressEmpty = Color(0xFFC1C8B9);
  static const Color gardenLight = Color(0xFFC0D470);
  static const Color gardenBrown = Color(0xFF90625D);
}

class AppTextStyles {
  // Titles (SproutLands)
  static const TextStyle title = TextStyle(
    fontFamily: 'SproutLands',
    fontSize: 16,
    color: AppColors.text,
    decoration: TextDecoration.none,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: 'SproutLands',
    fontSize: 11,
    color: AppColors.text,
    decoration: TextDecoration.none,
  );

  // Body (RainyHearts)
  static const TextStyle body = TextStyle(
    fontFamily: 'RainyHearts',
    fontSize: 11,
    color: AppColors.text,
    decoration: TextDecoration.none,
  );

  // Text button (RainyHearts)
  static const TextStyle textBtn = TextStyle(
    fontFamily: 'RainyHearts',
    fontSize: 10,
    color: AppColors.gardenBrown,
    decoration: TextDecoration.none,
  );
}
