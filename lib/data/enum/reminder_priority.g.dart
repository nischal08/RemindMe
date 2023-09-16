// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_priority.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderPriorityAdapter extends TypeAdapter<ReminderPriority> {
  @override
  final int typeId = 2;

  @override
  ReminderPriority read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ReminderPriority.high;
      case 1:
        return ReminderPriority.normal;
      case 2:
        return ReminderPriority.low;
      default:
        return ReminderPriority.high;
    }
  }

  @override
  void write(BinaryWriter writer, ReminderPriority obj) {
    switch (obj) {
      case ReminderPriority.high:
        writer.writeByte(0);
        break;
      case ReminderPriority.normal:
        writer.writeByte(1);
        break;
      case ReminderPriority.low:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderPriorityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
