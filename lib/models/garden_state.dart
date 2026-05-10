import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sproutly/models/feedback_message.dart';
import 'package:sproutly/models/plant_type.dart';
import 'package:sproutly/models/tile_data.dart';
import '../services/storage_service.dart';

class GardenState extends ChangeNotifier {
  int completedSessions = 0;
  Timer? _saveTimer;

  List<TileData> tiles = List.generate(
    54,
    (_) => TileData(type: PlantType.values.first, stage: 0),
  );

  List<FeedbackMessage> feedbackQueue = [];

  // milestones
  bool hasHouse = false;
  bool hasLandscape = false;
  bool hasFlowers = false;
  bool hasPond = false;

  bool isLoaded = false;

  bool _feedbackActive = false;

  void _initTilesIfNeeded() {
    tiles = List.generate(54, (index) {
      return TileData(
        type: PlantType.values[index % PlantType.values.length],
        stage: 0,
      );
    });
  }

  Future<void> loadGarden() async {
    final data = await StorageService.loadData();

    completedSessions = data["sessions"] ?? 0;

    List<dynamic>? savedTiles = data["tiles"];

    if (savedTiles != null &&
        savedTiles.length == 54 &&
        savedTiles.every((e) => e != null)) {
      tiles = savedTiles.map((e) => TileData.fromJson(e)).toList();
    } else {
      _initTilesIfNeeded();
    }

    _checkMilestones();
    isLoaded = true;
    notifyListeners();
  }

  Future<void> saveGarden() async {
    await StorageService.saveData(
      completedSessions,
      tiles.map((t) => t.toJson()).toList(),
    );
  }

  void autoSave() {
    // cancel previous pending save
    _saveTimer?.cancel();

    // debounce save (waits 500ms after last change)
    _saveTimer = Timer(const Duration(milliseconds: 500), () async {
      await saveGarden();
    });
  }

  void completeSession() {
    completedSessions++;

    _growNextTile();

    addFeedback("Session complete! ✧˖°.");

    _checkMilestones();

    autoSave();
    notifyListeners();
  }

  void _growNextTile() {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i].stage < 3) {
        tiles[i].stage++;

        if (tiles[i].stage == 3) {
          addFeedback("Plant fully grown! ⸙ ˚࿔");
        }

        break;
      }
    }
  }

  void _checkMilestones() {
    if (completedSessions >= 3 && !hasHouse) {
      hasHouse = true;
      addFeedback("˚˖𓍢ִ໋⾕⋆ House unlocked!");
    }

    if (completedSessions >= 6 && !hasLandscape) {
      hasLandscape = true;
      addFeedback("ᨒ↟ᯓ.°_ Landscape unlocked!");
    }

    if (completedSessions >= 12 && !hasFlowers) {
      hasFlowers = true;
      addFeedback("‧₊˚❀༉‧₊˚. Flowers unlocked!");
    }

    if (completedSessions >= 15 && !hasPond) {
      hasPond = true;
      addFeedback("°‧ 𓆝 .·｡ Pond unlocked!");
    }
  }

  void addFeedback(String text) {
    feedbackQueue.add(FeedbackMessage(text: text));
    notifyListeners();

    if (_feedbackActive) return;

    _feedbackActive = true;

    Future.delayed(const Duration(seconds: 2), () {
      if (feedbackQueue.isNotEmpty) {
        feedbackQueue.removeAt(0);
      }

      _feedbackActive = false;
      notifyListeners();
    });
  }

  // getters
  int get fullyGrownPlants {
    return tiles.where((t) => t.stage == 3).length;
  }

  double get gardenCompletion {
    return (fullyGrownPlants / tiles.length) * 100;
  }
}
