// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawing_memory_record_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DrawingMemoryRecordEntryAdapter
    extends TypeAdapter<DrawingMemoryRecordEntry> {
  @override
  final int typeId = 2;

  @override
  DrawingMemoryRecordEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DrawingMemoryRecordEntry(
      correctGuesses: fields[0] as int,
      totalPossibleScore: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DrawingMemoryRecordEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.correctGuesses)
      ..writeByte(1)
      ..write(obj.totalPossibleScore)
      ..writeByte(2)
      ..write(obj.uuid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrawingMemoryRecordEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
