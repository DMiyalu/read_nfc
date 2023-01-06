import 'dart:convert';
import 'package:hive/hive.dart';
import 'control_model.dart';

class ControlLocalDataProvider {
  Future<List<ControlModel>?>? fetchControlData() async {
    try {
      final db = await Hive.openBox("control");
      String _data = db.get("controlList");
      List<ControlModel>? controlDataList = jsonDecode(_data);
      await Hive.close();
      return controlDataList;
    } catch (e) {
      print(e.toString());
      Hive.close();
      return null;
    }
  }

  Future<bool>? saveControlData(ControlModel control) async {
    try {
      final db = await Hive.openBox("control");
      String _data = db.get("controlDataList");
      List<ControlModel>? controlDataList = [control, ...jsonDecode(_data)];
      db.put("controlDataList", jsonEncode(controlDataList));
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
