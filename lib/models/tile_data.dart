import 'plant_type.dart';

class TileData {
  PlantType type;
  int stage;

  TileData({required this.type, required this.stage});

  Map<String, dynamic> toJson() => {"type": type.name, "stage": stage};

  factory TileData.fromJson(Map<String, dynamic> json) {
    return TileData(
      type: PlantType.values.firstWhere(
        (e) => e.name == json["type"],
        orElse: () => PlantType.pumpkin,
      ),
      stage: json["stage"],
    );
  }
}
