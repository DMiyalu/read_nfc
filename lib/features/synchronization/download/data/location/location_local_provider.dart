import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:sigi_android/features/synchronization/download/logic/ptech_repository.dart';

class LocationLocalProvider {
  static Future<bool> checkData(String box) async {
    return await Hive.boxExists(box);
  }

  static Future<List?>? saveLocation(
      {required List data, required String field}) async {
    try {
      final locationBox = await Hive.openBox("locationBox");
      locationBox.put(field, jsonEncode(data));
      return data;
    } catch (error) {
      print("Error on download $field: ${error.toString()}");
      return null;
    }
  }

  static Future<List?>? getLocationData({required String field}) async {
    try {
      bool box = await checkData("locationBox");
      if (box) {
        final locationBox = await Hive.openBox("locationBox");
        final String? savedData = locationBox.get(field);
        if (savedData != null) {
          print('Get $field from localdb: $savedData');
          return jsonDecode(savedData);
        }
        return null;
      }
      return null;
    } catch (e) {
      print("Error on get $field: ${e.toString()}");
      return null;
    }
  }
}
