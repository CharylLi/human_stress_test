// class to represent single drawing memory game played
import 'package:human_stress_test/models/records/drawing_memory_record_entry.dart';
import 'package:human_stress_test/models/records/position_record_entry.dart';
import 'package:human_stress_test/models/records/reaction_time_record_entry.dart';

// mock data for reaction time game
final List<ReactionTimeRecordEntry> reactionTimeMockData = [
  ReactionTimeRecordEntry(
    reactionTime: const Duration(milliseconds: 22).inMilliseconds,
  ),
  ReactionTimeRecordEntry(
    reactionTime: const Duration(milliseconds: 123333).inMilliseconds,
  ),
  ReactionTimeRecordEntry(
    reactionTime: const Duration(milliseconds: 3334).inMilliseconds,
  ),
  ReactionTimeRecordEntry(
    reactionTime: const Duration(milliseconds: 324111).inMilliseconds,
  ),
];

// mock data for drawing memory game
final List<DrawingMemoryRecordEntry> drawingMemoryMockData = [
  DrawingMemoryRecordEntry(correctGuesses: 1, totalPossibleScore: 5),
  DrawingMemoryRecordEntry(correctGuesses: 4, totalPossibleScore: 6),
  DrawingMemoryRecordEntry(correctGuesses: 4, totalPossibleScore: 10),
  DrawingMemoryRecordEntry(correctGuesses: 2, totalPossibleScore: 12),
  DrawingMemoryRecordEntry(correctGuesses: 12, totalPossibleScore: 12)
];

// mock data for running game
final List<PositionRecordEntry> positionMockData = [
  PositionRecordEntry(speed: 20),
  PositionRecordEntry(speed: 30),
  PositionRecordEntry(speed: 10),
  PositionRecordEntry(speed: 100),
  PositionRecordEntry(speed: 1000)
];
