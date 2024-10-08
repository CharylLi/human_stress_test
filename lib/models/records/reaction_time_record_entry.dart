import 'package:hive/hive.dart';
import 'package:human_stress_test/utils/uuid_maker.dart';

part 'reaction_time_record_entry.g.dart';

@HiveType(typeId: 1)
class ReactionTimeRecordEntry {
  @HiveField(0)
  final int reactionTime;
  @HiveField(1)
  final UUIDString uuid;

  ReactionTimeRecordEntry({required this.reactionTime})
      : uuid = UUIDMaker.generateUUID();
}
