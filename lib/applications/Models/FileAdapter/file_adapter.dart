import 'dart:io';
import 'package:hive/hive.dart';

class FileAdapter extends TypeAdapter<File> {
  @override
  final typeId = 5;

  @override
  File read(BinaryReader reader) {
    final length = reader.readByte();
    final bytes = reader.readByteList(length.toInt());
    return File.fromRawPath(bytes);
  }

  @override
  void write(BinaryWriter writer, File obj) {
    final bytes = obj.readAsBytesSync();
    writer.writeByte(bytes.length);
    writer.writeByteList(bytes);
  }
}
