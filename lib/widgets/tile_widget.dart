import 'package:flutter/material.dart';
import 'package:sproutly/models/tile_data.dart';

class TileWidget extends StatelessWidget {
  final TileData tile;
  final int index;

  const TileWidget({super.key, required this.tile, required this.index});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand();
  }
}
