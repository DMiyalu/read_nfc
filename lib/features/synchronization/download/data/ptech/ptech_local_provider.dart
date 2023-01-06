import 'dart:convert';
import 'package:hive/hive.dart';

class PtechLocalProvider {
  static Future<bool> checkData(String box) async {
    return await Hive.boxExists(box);
  }

  static Future<List?>? saveFormData(
      {required List data, required String field}) async {
    try {
      final formBox = await Hive.openBox("ptechBox");
      formBox.put(field, jsonEncode(data));
      print('***Synchronization. Local Save $field');
      return data;
    } catch (error) {
      print("Error on save $field: ${error.toString()}");
      return null;
    }
  }

  static Future<List?>? getFormData({required String field}) async {
    print('*** Get form data: $field');
    try {
      bool box = await checkData("ptechBox");
      if (box) {
        final formBox = await Hive.openBox("ptechBox");
        final String? savedData = formBox.get(field);
        if (savedData != null) {
          print('success');
          return jsonDecode(savedData);
        }
        print('failled');
        return null;
      }
      print('failled');
      return null;
    } catch (e) {
      print("Error on get $field: ${e.toString()}");
      return null;
    }
  }

  // static Future<List?>? saveLocationData(
  //     {required List data, required String field}) async {
  //   try {
  //     final formBox = await Hive.openBox("locationBox");
  //     formBox.put(field, jsonEncode(data));
  //     print('***Synchronization. Local Save $field ');
  //     return data;
  //   } catch (error) {
  //     print("Error on save $field: ${error.toString()}");
  //     return null;
  //   }
  // }

  // static Future<List?>? getLocationData({required String field}) async {
  //   try {
  //     bool box = await checkData("locationBox");
  //     if (box) {
  //       final formBox = await Hive.openBox("locationBox");
  //       final String? savedData = formBox.get(field);
  //       if (savedData != null) {
  //         return jsonDecode(savedData);
  //       }
  //       return null;
  //     }
  //     return null;
  //   } catch (e) {
  //     print("Error on get $field: ${e.toString()}");
  //     return null;
  //   }
  // }
}
