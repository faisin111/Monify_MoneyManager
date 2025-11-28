// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpensescategoryAdapter extends TypeAdapter<Expensescategory> {
  @override
  final int typeId = 0;

  @override
  Expensescategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expensescategory(
      catogary: fields[0] as String,
      date: fields[1] as String,
      amount: fields[2] as String,
      id: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Expensescategory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.catogary)
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
      other is ExpensescategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
