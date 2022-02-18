import 'dart:convert' show jsonDecode;

import 'package:ch5_practical/core/utilities.dart';
import 'package:flutter/services.dart';

class LocalJsonFetchService {
  Future<JsonData> getLocalCategories(String src) async {
    late JsonData _jsonResult;
    String _jsonText = await rootBundle.loadString(src);
    _jsonResult = jsonDecode(_jsonText) as JsonData;
    return _jsonResult;
  }
}
