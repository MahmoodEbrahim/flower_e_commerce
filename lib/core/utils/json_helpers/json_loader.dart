import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadJson(String jsonFile) async {
  try {
    final String jsonString = await rootBundle.loadString(jsonFile);
    final jsonMap = json.decode(jsonString);
    return jsonMap;
  } catch (e) {
    return {};
  }
}
