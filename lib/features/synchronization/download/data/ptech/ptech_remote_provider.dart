// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sigi_android/features/authentication/database/save_token.dart';

class PtechRemoteProvider {
  static const String baseURL = "http://supplier.baadhiteam.com";

  static Future<String> getToken() async {
    // get token from database
    var tk = await SaveToken.getCredentials();
    var value = tk!["data"];
    var token = value["access_token"];
    return token;
  }

  static Future<List?>? fetchBusinessNetwork() async {
    try {
      final response = await http.get(
        Uri.parse("$baseURL/api/peasant_organization_p_n_d_as"),
        headers: {
          "Authorization": "Bearer ${await getToken()}",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 201 ||
          response.statusCode == 200 ||
          response.statusCode == 204) {
        return jsonDecode(response.body) as List;
      }

      print(
          "Fetch business_network failled: ${jsonDecode(response.body).toString()} code: ${response.statusCode.toString()}");

      if (response.statusCode == 401) {
        Get.dialog(
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                const Text(
                  "Connexion expirée",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () => Get.offAllNamed('/login'),
                  child: const Text(
                    "Se reconnecter",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
        );
        // return null;
      }
      return null;
    } catch (e) {
      print("Error on fetch business_network: ${e.toString()}");
    }
    return null;
  }

  static Future<List?>? fetchLegalStatus() async {
    try {
      final response = await http.get(
        Uri.parse("$baseURL/api/type_organisation_suppliers"),
        headers: {
          "Authorization": "Bearer ${await getToken()}",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 201 ||
          response.statusCode == 200 ||
          response.statusCode == 204) {
        return jsonDecode(response.body) as List;
      }

      print(
          "Fetch type_organisation_suppliers failled: ${jsonDecode(response.body).toString()} code: ${response.statusCode.toString()}");
      return null;
    } catch (e) {
      print("Error on fetch type_organisation_suppliers: ${e.toString()}");
    }
    return null;
  }

  static Future<List?>? fetchTurnOver() async {
    try {
      final response = await http.get(
        Uri.parse("$baseURL/api/turnover_ranges"),
        headers: {
          "Authorization": "Bearer ${await getToken()}",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 201 ||
          response.statusCode == 200 ||
          response.statusCode == 204) {
        return jsonDecode(response.body) as List;
      }

      print(
          "Fetch turnover_ranges failled: ${jsonDecode(response.body).toString()} code: ${response.statusCode.toString()}");
      return null;
    } catch (e) {
      print("Error on fetch turnover_ranges: ${e.toString()}");
    }
    return null;
  }

  static Future<List?>? fetchProductDisplayMode() async {
    try {
      final response = await http.get(
        Uri.parse("$baseURL/api/product_show_deposits"),
        headers: {
          "Authorization": "Bearer ${await getToken()}",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 201 ||
          response.statusCode == 200 ||
          response.statusCode == 204) {
        return jsonDecode(response.body) as List;
      }

      print(
          "Fetch product_show_deposits failled: ${jsonDecode(response.body).toString()} code: ${response.statusCode.toString()}");
      return null;
    } catch (e) {
      print("Error on fetch product_show_deposits: ${e.toString()}");
    }
    return null;
  }

  static Future<List?>? fetchSupplierSpecialities() async {
    try {
      final response = await http.get(
        Uri.parse("$baseURL/api/supplier_specialities"),
        headers: {
          "Authorization": "Bearer ${await getToken()}",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 201 ||
          response.statusCode == 200 ||
          response.statusCode == 204) {
        return jsonDecode(response.body) as List;
      }

      print(
          "Fetch supplier_specialities failled: ${jsonDecode(response.body).toString()} code: ${response.statusCode.toString()}");
      return null;
    } catch (e) {
      print("Error on fetch supplier_specialities: ${e.toString()}");
    }
    return null;
  }

  // ----- Locations ------- //
  static Future<List?>? fetchProvinces() async {
    return null;
  }

  static Future<List?>? fetchVilles() async {
    return null;
  }

  Future<List?>? fetchTerritoires() async {
    return null;
  }

  Future<List?>? fetchSecteurs() async {
    return null;
  }

  Future<List?>? fetchCommunes() async {
    return null;
  }
}
