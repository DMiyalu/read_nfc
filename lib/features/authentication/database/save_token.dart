import 'dart:convert';
import 'package:hive/hive.dart';

class SaveToken {
  static Future<bool> checkData() async {
    final savetoken = await Hive.openBox("savetoken");
    var result = await savetoken.get("data");
    if (result == null) return false;
    return true;
  }

  static void saveUserProfile({required Map? data}) async {
    // print('** save user profile: $data');
    try {
      final userProfile = await Hive.openBox("savetoken");
      userProfile.put("userProfile", jsonEncode(data!['data']));
      print('** userprofile saved');
      return;
    } catch (error) {
      return;
    }
  }

  static void saveToken({required Map? token}) async {
    try {
      final savetoken = await Hive.openBox("savetoken");
      savetoken.put("data", jsonEncode(token));
      return;
    } catch (error) {
      return;
    }
  }

  static Future<Map?> getUserProfile() async {
    try {
      bool data = await checkData();
      final box = await Hive.openBox("savetoken");
      if (data) {
        final String? userProfile = box.get("userProfile");
        if (userProfile!.isEmpty) {
          return null;
        }
        return jsonDecode(userProfile) as Map;
      }
      return null;
    } catch (e) {
      print('error on get userProfile: ${e.toString()}');
      return null;
    }
  }

  static Future<Map?> getCredentials() async {
    try {
      final savetoken = await Hive.openBox("savetoken");
      bool data = await checkData();
      if (data) {
        final String token = savetoken.get("data");
        final String? userProfile = savetoken.get("userProfile");

        Map data = {
          ...jsonDecode(token) as Map,
          'profile': jsonDecode(userProfile!) as Map,
        };

        if (data.isEmpty) {
          return {'code': 404, 'message': 'utilisateur non trouvé'};
        }

        return {
          'code': 200,
          'data': data['data'],
        };
      } else {
        return {
          'code': 404,
          'message': 'utilisateur non trouvé',
        };
      }
    } catch (error) {
      return {
        'code': 500,
        'message': "Error on get user data: ${error.toString()}",
      };
    }
  }

  static userDisconnect() async {
    final savetoken = await Hive.openBox("savetoken");
    bool data = await checkData();

    if (data) {
      try {
        savetoken.delete("data");
        return 200;
      } catch (e) {
        return 500;
      }
    }
    return 200;
  }
}
