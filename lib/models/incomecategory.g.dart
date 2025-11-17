// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incomecategory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IncomecategoryAdapter extends TypeAdapter<Incomecategory> {
  @override
  final int typeId = 1;

  @override
  Incomecategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Incomecategory(
      category: fields[0] as String,
      date: fields[1] as String,
      amount: fields[2] as String,
      id: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Incomecategory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomecategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
