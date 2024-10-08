// this is a provider class that will be used to manage the state of the game
// it will keep track of the sequence of shapes and colors that the user has to remember

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:human_stress_test/models/records/drawing_memory_record_entry.dart';
import 'package:human_stress_test/models/records/drawing_memory_records.dart';

import '../models/memory_game.dart';
import '../models/draw_actions/draw_actions.dart';

// This class is a ChangeNotifier that provides a MemoryGame object to the rest of the app.
// It has methods to start a new game, check the user's input, and reset the game.
class MemoryGameProvider extends ChangeNotifier {
  MemoryGame? _memoryGame;
  int _currentIndex = 0;
  int _currScore = 0;

  // ignore: non_constant_identifier_names
  final int TOTAL_POSSIBLE_QUESTIONS = 5;

  final DrawingMemoryRecords _records;

  // Constructor for the MemoryGameProvider
  MemoryGameProvider(Box<DrawingMemoryRecordEntry> storage)
      : _records = DrawingMemoryRecords(records: [], storage: storage);

  // Getter for the memoryGame
  MemoryGame get memoryGame {
    if (_memoryGame == null) {
      _startNewGame();
    }
    return _memoryGame!;
  }

  // get a copy of the records
  DrawingMemoryRecords get records => _records;

  // Setter for the memoryGame
  set memoryGame(MemoryGame game) {
    _memoryGame = game;
    notifyListeners();
  }

  // Getter for the current index
  int get currentIndex => _currentIndex;

  // Setter for the current index
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // Getter for the current score
  int get currScore => _currScore;

  // Setter for the current score
  set currScore(int score) {
    _currScore = score;
    notifyListeners();
  }

  // This method will start a new game
  void _startNewGame() {
    _memoryGame = MemoryGame();
    _currentIndex = 0;
    notifyListeners();
  }

  // This method will check the user's input. If the input is correct, the game proceeds to the next shape in the sequence.
  // parameters:
  //  action: the action to check against the current shape and color in the sequence
  void checkUserInput(DrawAction action) {
    if (_memoryGame!.checkAction(_currentIndex, action)) {
      _currentIndex++;
      if (_currentIndex == _memoryGame!.sequence.length) {
        _startNewGame();
      }
      notifyListeners();
    } else {
      // Game over logic
      _startNewGame();
    }
  }

  // This method will reset the game
  void resetGame() {
    _startNewGame();
  }

  // This method will update the user's data
  void updateRecords() {
    _records.upsertEntry(DrawingMemoryRecordEntry(
        correctGuesses: currScore,
        totalPossibleScore: TOTAL_POSSIBLE_QUESTIONS));
  }
}
