import 'dart:io';

import 'package:hive/hive.dart';

class FileAdapter extends TypeAdapter<File> {
  @override
  final typeId = 5;

  @override
  File read(BinaryReader reader) {
    final bytes = reader.readByteList(reader.availableBytes);
    return File.fromRawPath(bytes);
  }

  @override
  void write(BinaryWriter writer, File obj) {
    writer.writeByte(obj.path.length);
    writer.write(obj.path.codeUnits);
  }
}
