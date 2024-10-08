import 'package:hive/hive.dart';
import 'package:human_stress_test/utils/uuid_maker.dart';

part 'position_record_entry.g.dart';

@HiveType(typeId: 3)
class PositionRecordEntry {
  @HiveField(0)
  // meter per sec
  final double speed;
  @HiveField(1)
  final UUIDString uuid;

  PositionRecordEntry({required this.speed}) : uuid = UUIDMaker.generateUUID();
}
