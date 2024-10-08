import 'package:hive/hive.dart';
import 'package:human_stress_test/models/records/reaction_time_record_entry.dart';

class ReactionTimeRecords {
  final Box<ReactionTimeRecordEntry> _storage;
  final List<ReactionTimeRecordEntry> _records;

  ReactionTimeRecords({
    required List<ReactionTimeRecordEntry> records,
    required Box<ReactionTimeRecordEntry> storage,
  })  : _records = List<ReactionTimeRecordEntry>.from(storage.values),
        _storage = storage;

  //create and return a copy of the entries list
  List<ReactionTimeRecordEntry> get getEntries =>
      List<ReactionTimeRecordEntry>.from(_records);

  //check using uuid if an entry is already inserted
  upsertEntry(ReactionTimeRecordEntry entry) {
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

  // helper method to find the fastest reaction time
  int findfastestReactionTime() {
    if (_records.isEmpty) {
      return 0;
    }
    int bestScore = _records[0].reactionTime;
    for (var record in _records) {
      if (record.reactionTime < bestScore) {
        bestScore = record.reactionTime;
      }
    }
    return bestScore;
  }
}
