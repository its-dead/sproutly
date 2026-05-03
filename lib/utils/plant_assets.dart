import '../models/tile_data.dart';

String getPlantAsset(TileData tile) {
  return "assets/images/plants/${tile.type.name}_stage_${tile.stage}.png";
}
