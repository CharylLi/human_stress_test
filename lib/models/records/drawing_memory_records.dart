import 'package:hive/hive.dart';
import 'package:human_stress_test/models/records/drawing_memory_record_entry.dart';

class DrawingMemoryRecords {
  final Box<DrawingMemoryRecordEntry> _storage;
  final List<DrawingMemoryRecordEntry> _records;

  DrawingMemoryRecords({
    required List<DrawingMemoryRecordEntry> records,
    required Box<DrawingMemoryRecordEntry> storage,
  })  : _records = List<DrawingMemoryRecordEntry>.from(storage.values),
        _storage = storage;

  //create and return a copy of the entries list
  List<DrawingMemoryRecordEntry> get getEntries =>
      List<DrawingMemoryRecordEntry>.from(_records);

  //check using uuid if an entry is already inserted
  upsertEntry(DrawingMemoryRecordEntry entry) {
    //find if the entry is already in the list using indexWhere method
    //it returns the index
    final existingEntryIndex =
        _records.indexWhere((ele) => ele.uuid == entry.uuid);

    //if found, replace with the new one
    //otherwise add to the list
    if (existingEntryIndex != -1) {
      _records[existingEntryIndex] = entry;
    } else {
      _records.add(entry);
    }
    //put in storage for later access
    _storage.put(entry.uuid, entry);
  }

  // helper method to find the highest score
  double findHighestScorePercentage() {
    if (_records.isEmpty) {
      return 0;
    }

    double bestScore = _records[0].getScoreInPercentage();

    for (var record in _records) {
      if (record.getScoreInPercentage() > bestScore) {
        bestScore = record.getScoreInPercentage();
      }
    }

    return bestScore;
  }
}
