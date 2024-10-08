import 'package:hive/hive.dart';
import 'package:human_stress_test/models/records/position_record_entry.dart';

class PositionRecords {
  final Box<PositionRecordEntry> _storage;
  final List<PositionRecordEntry> _records;

  PositionRecords({
    required List<PositionRecordEntry> records,
    required Box<PositionRecordEntry> storage,
  })  : _records = List<PositionRecordEntry>.from(storage.values),
        _storage = storage;

  //create and return a copy of the entries list
  List<PositionRecordEntry> get getEntries =>
      List<PositionRecordEntry>.from(_records);

  //check using uuid if an entry is already inserted
  upsertEntry(PositionRecordEntry entry) {
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

  // helper method to find the fastest speed
  double findFastestSpeed() {
    if (_records.isEmpty) {
      return 0;
    }
    double bestScore = _records[0].speed;
    for (var record in _records) {
      if (record.speed > bestScore) {
        bestScore = record.speed;
      }
    }
    return bestScore;
  }
}
