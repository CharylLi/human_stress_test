import 'package:flutter/material.dart';
import 'package:human_stress_test/models/records/reaction_time_record_entry.dart';
import 'package:human_stress_test/models/records/reaction_time_records.dart';
import '../models/reaction_time_game_model.dart';
import 'package:hive/hive.dart';

/// A provider class that manages the state and interactions for the reaction time game.
class ReactionTimeGameProvider extends ChangeNotifier {
  final ReactionTimeRecords _records;

  /// Constructor for ReactionTimeGameProvider.
  /// Initializes the provider with a storage box for reaction time records.
  /// Parameters:
  ///   - storage: The Hive storage box for storing reaction time record entries.
  ReactionTimeGameProvider(Box<ReactionTimeRecordEntry> storage)
      : _records = ReactionTimeRecords(records: [], storage: storage);

  final ReactionTimeGameModel _gameModel = ReactionTimeGameModel();
  bool _isPlaying = false;
  bool _isReady = false;
  Duration _reactionTime = Duration.zero;
  int _bestScore = 0;
  int _numberOfPlays = 0;

  bool get isPlaying => _isPlaying;
  bool get isReady => _isReady;
  Duration get reactionTime => _reactionTime;
  int get bestScore => _bestScore;
  int get numberOfPlays => _numberOfPlays;

  ReactionTimeRecords get records => _records;

  /// Starts the reaction time game.
  /// Sets the game state to playing and schedules the game to be ready after a random delay.
  void startGame() {
    _isPlaying = true;
    _isReady = false;
    notifyListeners();

    Future.delayed(Duration(milliseconds: _gameModel.randomDelay), () {
      _isReady = true;
      _gameModel.start();
      notifyListeners();
    });
  }

  /// Stops the reaction time game.
  /// If the game is ready, stops the game, records the reaction time, and updates the best score.
  void stopGame() {
    if (_isReady) {
      _gameModel.stop();
      _reactionTime = _gameModel.reactionTime;
      _isPlaying = false;
      _isReady = false;
      _numberOfPlays += 1;

      if (_bestScore == 0 || _reactionTime.inMilliseconds < _bestScore) {
        _bestScore = _reactionTime.inMilliseconds;
      }

      _records.upsertEntry(
          ReactionTimeRecordEntry(reactionTime: _reactionTime.inMilliseconds));

      notifyListeners();
    }
  }

  /// Resets the game state.
  /// Sets the game state to not playing, not ready, and resets the reaction time.
  void resetGame() {
    _isPlaying = false;
    _isReady = false;
    _reactionTime = Duration.zero;
    notifyListeners();
  }
}
