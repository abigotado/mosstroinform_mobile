// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectAdapterAdapter extends TypeAdapter<ProjectAdapter> {
  @override
  final typeId = 0;

  @override
  ProjectAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectAdapter(
      id: fields[0] as String,
      name: fields[1] as String,
      address: fields[2] as String,
      description: fields[3] as String,
      area: (fields[4] as num).toDouble(),
      floors: (fields[5] as num).toInt(),
      bedrooms: (fields[6] as num).toInt(),
      bathrooms: (fields[7] as num).toInt(),
      price: (fields[8] as num).toInt(),
      imageUrl: fields[9] as String?,
      statusString: fields[10] as String?,
      constructionAddress: fields[11] as String?,
      objectId: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectAdapter obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.area)
      ..writeByte(5)
      ..write(obj.floors)
      ..writeByte(6)
      ..write(obj.bedrooms)
      ..writeByte(7)
      ..write(obj.bathrooms)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.imageUrl)
      ..writeByte(10)
      ..write(obj.statusString)
      ..writeByte(11)
      ..write(obj.constructionAddress)
      ..writeByte(12)
      ..write(obj.objectId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
