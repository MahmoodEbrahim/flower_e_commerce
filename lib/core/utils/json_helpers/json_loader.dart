import 'dart:convert';
import 'package:flutter/services.dart';

abstract class JsonLoader {
  Future<Map<String, dynamic>> loadJson(String path);
}

class AssetJsonLoader implements JsonLoader {
  @override
  Future<Map<String, dynamic>> loadJson(String path) async {
    final jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString);
  }
}
