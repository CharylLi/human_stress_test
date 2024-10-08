// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_time_record_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReactionTimeRecordAdapter extends TypeAdapter<ReactionTimeRecordEntry> {
  @override
  final int typeId = 1;

  @override
  ReactionTimeRecordEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReactionTimeRecordEntry(
      reactionTime: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ReactionTimeRecordEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.reactionTime)
      ..writeByte(1)
      ..write(obj.uuid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReactionTimeRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
