// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HiveLockCardDTO.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLockCardDTOAdapter extends TypeAdapter<HiveLockCardDTO> {
  @override
  final int typeId = 1;

  @override
  HiveLockCardDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLockCardDTO(
      image: fields[3] as String,
      name: fields[2] as String,
      color: fields[1] as int,
      lockId: fields[0] as String,
      subscribed: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HiveLockCardDTO obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.lockId)
      ..writeByte(1)
      ..write(obj.color)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.subscribed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLockCardDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
