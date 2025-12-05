// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'final_document_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FinalDocumentAdapterAdapter extends TypeAdapter<FinalDocumentAdapter> {
  @override
  final typeId = 4;

  @override
  FinalDocumentAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FinalDocumentAdapter(
      id: fields[0] as String,
      projectId: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String,
      fileUrl: fields[4] as String?,
      statusString: fields[5] as String,
      submittedAt: fields[6] as DateTime?,
      signedAt: fields[7] as DateTime?,
      signatureUrl: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FinalDocumentAdapter obj) {
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
      ..write(obj.signedAt)
      ..writeByte(8)
      ..write(obj.signatureUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinalDocumentAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
