// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:hive/hive.dart';
import 'ptech_model.dart';

class PtechLocalDataProvider {
  static Future<bool> checkData() async {
    return await Hive.boxExists("ptech");
  }

  Future<List<PtechModel>?>? fetchPtechData() async {
    print('****fecth local data');
    try {
      bool data = await checkData();
      if (data) {
        final db = await Hive.openBox("ptech");
        String _data = db.get("ptechDataList");
        List ptechDataList = jsonDecode(_data);
        List<PtechModel> ptechs = <PtechModel>[];

        if (ptechDataList.isNotEmpty) {
          for (int i = 0; i < ptechDataList.length - 1; i++) {
            print('$i. ${ptechDataList[i]}');
            ptechs.add(PtechModel.fromJson(ptechDataList[i]));
            print('*** json format. ${PtechModel.fromJson(ptechDataList[i])}');
          }
          await Hive.close();
          return ptechs;
        }
        await Hive.close();
        print('no local data');
        return ptechs;
      }
      print('no local db');
      await Hive.close();
      return <PtechModel>[];
    } catch (e) {
      print("error on local provider. ${e.toString()}");
      Hive.close();
      return null;
    }
  }

  Future<PtechModel?>? savePtechData(PtechModel? ptech) async {
    print('add ptech on local db');
    try {
      bool data = await checkData();

      if (data) {
        final db = await Hive.openBox("ptech");
        String _data = db.get("ptechDataList");

        if (_data.isNotEmpty) {
          List ptechDataList = [ptech!.toJson(), ...jsonDecode(_data)];
          db.put("ptechDataList", jsonEncode(ptechDataList));
          Hive.close();
          print('**** ptechdatalist updated: ${ptechDataList.toString()}');
          return ptech;
        }
        db.put("ptechDataList", jsonEncode([ptech!.toJson()]));
        Hive.close();
        print('****create new list data');
        return ptech;
      }

      final db = await Hive.openBox("ptech");
      db.put("ptechDataList", jsonEncode([ptech!.toJson()]));
      Hive.close();
      return ptech;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool>? cachePtechs(List<PtechModel?> ptech) {
    //todo: cache model
    return null;
  }

  Future<bool>? cachePtech(PtechModel? ptech) {
    //todo: cache model
    return null;
  }
}
