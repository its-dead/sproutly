import '../models/tile_data.dart';

String getPlantAsset(TileData tile) {
  return "images/plants/${tile.type.name}_stage_${tile.stage}.png";
}
