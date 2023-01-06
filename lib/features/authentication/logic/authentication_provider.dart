// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/io_client.dart';

class AuthenticationProvider {
  static Future<Map?> getUserToken({required Map user}) async {
    print('get token uhiol ${user['email']} ${user['password']}');
    Map status = {};
    try {
      final ioc = HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = IOClient(ioc);

      var response = await http.post(
          Uri.parse(
              "https://keycloak.surintrants.com/auth/realms/rna/protocol/openid-connect/token"),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: {
            "username": user['email'],
            "password": user['password'],
            "client_secret": "dcnBoVZazM8NzVol1QaSKAe5m6XRHrC2",
            "grant_type": "password",
            "client_id": "micro-service"
          }).timeout(const Duration(seconds: 40));
      print('get token body ${response.body}}');
      log(response.body);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        print("***return token: ${jsonDecode(response.body)}");
        status['code'] = 200;
        status['data'] = jsonDecode(response.body);
        return status;
      }

      if (response.statusCode == 400 || response.statusCode == 404) {
        status['code'] = 404;
        status['message'] = "email ou mot de passe incorrecte";
        return status;
      }

      if (response.statusCode == 401) {
        status['code'] = 401;
        status['message'] = "email ou mot de passe incorrecte";
        return status;
      }

      if (response.statusCode == 403) {
        status['code'] = 403;
        status['message'] = "Authorisation refusée!";
        return status;
      }

      if (response.statusCode == 500) {
        status['code'] = 500;
        status['message'] = json.decode(response.body).toString();
        return status;
      }
      return {
        'code': 400,
        'message': "Echec connexion",
      };
    } catch (error) {
      status['code'] = 500;
      status['message'] =
          "Une erreur est suervenue lors de l'authentification: ${error.toString()}";
      return status;
    }
  }

  static Future<Map>? getUserProfil({required Map? credentials}) async {
    print('get user profil');
    try {
      final ioc = HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = IOClient(ioc);

      var response = await http.get(
          Uri.parse("https://rna.surintrants.com/api/v1/ot/profile"),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer ${credentials!['access_token']}",
          });
      print('user profil___________: ${response.body}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        print('user profil: ${jsonDecode(response.body)}');
        Map status = {
          'code': 200,
          'data': jsonDecode(response.body),
        };
        return status;
      }
      Map status = {
        'code': 404,
        'message': 'Profile utilisateur non trouvé',
      };
      return status;
    } catch (e) {
      return {
        'code': 500,
        'message': 'Error on getUserInfos: ${e.toString()}',
      };
    }
  }
}
