import 'control_model.dart';

class ControlRemoteDataProvider {
  final String baseURL = "https://api";

  Future<List?>? fetchControlData() async {
    try {
      return [];
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool>? sendControlData(ControlModel control) async {
    try {
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
