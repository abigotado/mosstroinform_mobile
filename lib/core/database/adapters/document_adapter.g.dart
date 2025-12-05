// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DocumentAdapterAdapter extends TypeAdapter<DocumentAdapter> {
  @override
  final typeId = 1;

  @override
  DocumentAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DocumentAdapter(
      id: fields[0] as String,
      projectId: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String,
      fileUrl: fields[4] as String?,
      statusString: fields[5] as String,
      submittedAt: fields[6] as DateTime?,
      approvedAt: fields[7] as DateTime?,
      rejectionReason: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DocumentAdapter obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.projectId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.fileUrl)
      ..writeByte(5)
      ..write(obj.statusString)
      ..writeByte(6)
      ..write(obj.submittedAt)
      ..writeByte(7)
      ..write(obj.approvedAt)
      ..writeByte(8)
      ..write(obj.rejectionReason);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
