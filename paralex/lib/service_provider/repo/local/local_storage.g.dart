// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalStorageAdapter extends TypeAdapter<LocalStorage> {
  @override
  final int typeId = 1;

  @override
  LocalStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalStorage(
      idToken: fields[0] as String?,
      phoneNumber: fields[1] as String?,
      stateOfResidence: fields[2] as String?,
      username: fields[3] as String?,
      email: fields[4] as String?,
      photoUrl: fields[5] as String?,
      time: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalStorage obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.idToken)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.stateOfResidence)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.photoUrl)
      ..writeByte(6)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
