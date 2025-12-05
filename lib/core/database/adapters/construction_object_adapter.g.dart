// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_object_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConstructionStageAdapterAdapter
    extends TypeAdapter<ConstructionStageAdapter> {
  @override
  final typeId = 2;

  @override
  ConstructionStageAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConstructionStageAdapter(
      id: fields[0] as String,
      name: fields[1] as String,
      statusString: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ConstructionStageAdapter obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.statusString);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConstructionStageAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ConstructionObjectAdapterAdapter
    extends TypeAdapter<ConstructionObjectAdapter> {
  @override
  final typeId = 3;

  @override
  ConstructionObjectAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConstructionObjectAdapter(
      id: fields[0] as String,
      projectId: fields[1] as String,
      name: fields[2] as String,
      address: fields[3] as String,
      description: fields[4] as String,
      area: (fields[5] as num).toDouble(),
      floors: (fields[6] as num).toInt(),
      bedrooms: (fields[7] as num).toInt(),
      bathrooms: (fields[8] as num).toInt(),
      price: (fields[9] as num).toInt(),
      imageUrl: fields[10] as String?,
      stages: (fields[11] as List).cast<ConstructionStageAdapter>(),
      chatId: fields[12] as String?,
      allDocumentsSigned: fields[13] == null ? false : fields[13] as bool,
      isCompleted: fields[14] == null ? false : fields[14] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ConstructionObjectAdapter obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.projectId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.area)
      ..writeByte(6)
      ..write(obj.floors)
      ..writeByte(7)
      ..write(obj.bedrooms)
      ..writeByte(8)
      ..write(obj.bathrooms)
      ..writeByte(9)
      ..write(obj.price)
      ..writeByte(10)
      ..write(obj.imageUrl)
      ..writeByte(11)
      ..write(obj.stages)
      ..writeByte(12)
      ..write(obj.chatId)
      ..writeByte(13)
      ..write(obj.allDocumentsSigned)
      ..writeByte(14)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConstructionObjectAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
