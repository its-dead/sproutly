import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String sessionsKey = "completed_sessions";
  static const String tilesKey = "tile_data";

  // SAVE
  static Future<void> saveData(
    int sessions,
    List<Map<String, dynamic>> tiles,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(sessionsKey, sessions);

    // Convert list of maps → JSON string
    String encodedTiles = jsonEncode(tiles);
    await prefs.setString(tilesKey, encodedTiles);
  }

  // LOAD
  static Future<Map<String, dynamic>> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    int sessions = prefs.getInt(sessionsKey) ?? 0;

    String? tileJson = prefs.getString(tilesKey);

    List<dynamic> tilesDecoded;

    if (tileJson != null) {
      tilesDecoded = jsonDecode(tileJson);
    } else {
      tilesDecoded = List.generate(54, (_) => null);
    }

    return {"sessions": sessions, "tiles": tilesDecoded};
  }
}
