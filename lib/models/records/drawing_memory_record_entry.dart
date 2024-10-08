import 'package:hive/hive.dart';
import 'package:human_stress_test/utils/uuid_maker.dart';

part 'drawing_memory_record_entry.g.dart';

@HiveType(typeId: 2)
class DrawingMemoryRecordEntry {
  @HiveField(0)
  final int correctGuesses;
  @HiveField(1)
  final int totalPossibleScore;
  @HiveField(2)
  final UUIDString uuid;

  DrawingMemoryRecordEntry(
      {required this.correctGuesses, required this.totalPossibleScore})
      : uuid = UUIDMaker.generateUUID();

  // get the correctness percentage
  double getScoreInPercentage() {
    return (correctGuesses * 100 / totalPossibleScore);
  }
}
