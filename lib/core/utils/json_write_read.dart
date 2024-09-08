import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class JsonWriteRead {
  Future<File> getFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName');
  }

  Future<Map<String, dynamic>> readDataFromFile(File file) async {
    if(await file.exists()){
      final data = await file.readAsString();
      return json.decode(data);
    } else {
      return {};
    }
  }

  Future<void> writeDataToFile(File file, Map<String, dynamic> data) async {
    final jsonContent = json.encode(data);
    await file.writeAsString(jsonContent);
  }
}