import 'dart:io';

extension FileWrite on File {
  Future<void> writeAsStringAndCreateDirectory(String content) async {
    await create(recursive: true);
    await writeAsString(content);
  }

  Future<void> writeAsBytesAndCreateDirectory(List<int> bytes) async {
    await create(recursive: true);
    await writeAsBytes(bytes);
  }
}
