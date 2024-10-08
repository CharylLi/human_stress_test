// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_record_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PositionRecordEntryAdapter extends TypeAdapter<PositionRecordEntry> {
  @override
  final int typeId = 3;

  @override
  PositionRecordEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionRecordEntry(
      speed: fields[0] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PositionRecordEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.speed)
      ..writeByte(1)
      ..write(obj.uuid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionRecordEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
