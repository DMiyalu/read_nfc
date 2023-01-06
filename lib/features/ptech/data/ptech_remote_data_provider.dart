// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import '../../authentication/database/save_token.dart';
import 'ptech_model.dart';
import 'package:http/http.dart' as http;

class PtechRemoteDataProvider {
  final String baseURL = "https://api";

  Future<List<PtechModel>?>? fetchPtechData() async {
    try {
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<PtechModel?>? sendPtechData(PtechModel ptech) async {
    // get token from database
    var tk = await SaveToken.getCredentials();
    var value = tk!["data"];
    var token = value["access_token"];
    http.Response? response;
    Map data = {"name": ptech.name, "inputNeedPtech": ptech.intrants};
    try {
      response = await http.post(
          Uri.parse("http://incentive.baadhiteam.com/api/pteches"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(data));
      print("**** Ptech_response:${response.body.toString()}");
      log('**** Ptech statusCode server: ${response.statusCode.toString()}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        print("send Ptech success ${response.body.toString()}");
        return ptech;
      } else {
        print("send Ptch failed: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
