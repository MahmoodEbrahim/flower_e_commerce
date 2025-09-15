import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

abstract class JsonLoader {
  Future<Map<String, dynamic>> loadJson(String path);
}
@Injectable(as: JsonLoader)
class AssetJsonLoader implements JsonLoader {
  @override
  Future<Map<String, dynamic>> loadJson(String path) async {
    final jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString);
  }
}
