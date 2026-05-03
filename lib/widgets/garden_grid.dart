import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/garden_state.dart';
import 'tile_widget.dart';

class GardenGrid extends StatelessWidget {
  const GardenGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GardenState>(
      builder: (context, garden, child) {
        return SizedBox(
          width: 6 * 16,
          height: 9 * 16,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 54,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return TileWidget(index: index, tile: garden.tiles[index]);
            },
          ),
        );
      },
    );
  }
}
