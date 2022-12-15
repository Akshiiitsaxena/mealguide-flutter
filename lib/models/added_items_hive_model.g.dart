// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'added_items_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddedItemAdapter extends TypeAdapter<AddedItem> {
  @override
  final int typeId = 0;

  @override
  AddedItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddedItem(
      recipeId: fields[0] as String,
      ingredientIds: (fields[1]).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, AddedItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.recipeId)
      ..writeByte(1)
      ..write(obj.ingredientIds.toList());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddedItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
