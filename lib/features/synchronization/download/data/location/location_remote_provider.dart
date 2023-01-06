import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sigi_android/features/authentication/database/save_token.dart';

class LocationRemoteProvider {
  static Future<List?>? fetchLocationData({required String location}) async {
    // get token from database
    var tk = await SaveToken.getCredentials();
    var value = tk!["data"];
    var token = value["access_token"];
    print('formatMultipart. token: $token');

    try {
      final response = await http.get(
        Uri.parse("http://producer.surintrants.com/api/location/$location"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 201 ||
          response.statusCode == 200 ||
          response.statusCode == 204) {
        return jsonDecode(response.body) as List;
      }
      return null;
    } catch (error) {
      return null;
    }
  }
}
