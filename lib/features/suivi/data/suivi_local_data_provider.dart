// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:sigi_android/features/suivi/data/suivi_model.dart';

class SuiviLocalDataProvider {
  static Future<bool> checkData() async {
    return await Hive.boxExists("suivi");
  }

  Future<List<SuiviModel>?>? fetchSuiviData() async {
    try {
      bool data = await checkData();
      if (data) {
        final db = await Hive.openBox("suivi");
        String data = db.get("suiviDataList");
        List suiviDataList = jsonDecode(data);
        List<SuiviModel> suivis = <SuiviModel>[];

        if (suiviDataList.isNotEmpty) {
          for (int i = 0; i < suiviDataList.length - 1; i++) {
            suivis.add(SuiviModel.fromJson(suiviDataList[i]));
          }
          await Hive.close();
          return suivis;
        }
        await Hive.close();
        return suivis;
      }

      await Hive.close();
      return <SuiviModel>[];
    } catch (e) {
      print(e.toString());
      Hive.close();
      return null;
    }
  }

  Future<SuiviModel?>? saveSuiviData(SuiviModel? suivi) async {
    try {
      bool data = await checkData();

      if (data) {
        final db = await Hive.openBox("suivi");
        String data = db.get("suiviDataList");

        if (data.isNotEmpty) {
          List suiviDataList = [suivi.toString(), ...jsonDecode(data)];
          db.put("suiviDataList", jsonEncode(suiviDataList));
          Hive.close();
          return suivi;
        }
        db.put("suiviDataList", [suivi!.toJson()]);
        Hive.close();
        return suivi;
      }

      final db = await Hive.openBox("suivi");
      db.put("suiviDataList", [suivi!.toJson()]);
      Hive.close();
      return suivi;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool>? cacheSuivis(List<SuiviModel?> suivi) {
    //todo: cache model
    return null;
  }

  Future<bool>? cacheSuivi(SuiviModel? suivi) {
    //todo: cache model
    return null;
  }
}
