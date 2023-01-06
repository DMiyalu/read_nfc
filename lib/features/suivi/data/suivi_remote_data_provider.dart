// ignore_for_file: avoid_print

import 'suivi_model.dart';

class SuiviRemoteDataProvider {
  final String baseURL = "https://api";

  Future<List<SuiviModel>?>? fetchSuiviData() async {
    try {
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<SuiviModel?>? sendSuiviData(SuiviModel suivi) async {
    try {
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
