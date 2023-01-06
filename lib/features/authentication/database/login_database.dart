// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:hive/hive.dart';

class LoginHiveRepository {
  static Future<bool> checkData() async {
    final loginBox = await Hive.openBox("loginBox");
    var result = await loginBox.get("userProfil");
    if (result == null) return false;
    return true;
  }

  static Future<bool> saveUserProfil({required Map user}) async {
    print('save profil on local');
    Map result = {};
    try {
      final loginBox = await Hive.openBox("loginBox");
      loginBox.put("userProfil", jsonEncode(user));
      result["status"] = 200;
      print('userAuth saved');
      return true;
    } catch (error) {
      result["status"] = 500;
      result["message"] = "Error on save user: ${error.toString()}";
      return false;
    }
  }

  static Future<Map> getLocalUserProfil() async {
    print('get user profil');
    try {
      final registrationBox = await Hive.openBox("loginBox");
      bool data = await checkData();
      if (data) {
        String _result = registrationBox.get("userProfil");
        Map? _data = jsonDecode(_result);

        if (_data!.isEmpty) {
          print('user not found');
          return {'code': 404};
        }

        print('user exist : $_data');
        return {'code': 200, 'data': _data};
      } else {
        print('user not found');
        return {'code': 404};
      }
    } catch (error) {
      print('user not found');
      return {
        'code': 500,
        'message': "Error on get user data: ${error.toString()}"
      };
    }
  }

  static Future<int> userDisconnect() async {
    final loginBox = await Hive.openBox("loginBox");
    bool data = await checkData();

    if (data) {
      try {
        loginBox.delete("userProfil");
        print('user profile deleted');
        return 200;
      } catch (e) {
        return 500;
      }
    }
    return 200;
  }
}
