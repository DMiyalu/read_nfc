import 'dart:convert';
import 'package:hive/hive.dart';
import 'fournisseur_model.dart';

class FournisseurLocalDataProvider {
  static Future<bool> checkData() async {
    return await Hive.boxExists("fournisseur");
  }

  Future<List<Fournisseur>?>? fetchFournisseur() async {
    print('***fetch fournisseur from local db');
    try {
      bool data = await checkData();

      if (data) {
        final db = await Hive.openBox("fournisseur");
        String _data = db.get("fournisseurList");
        List? fournisseurList = jsonDecode(_data);
        List<Fournisseur> _fournisseurs = <Fournisseur>[];
        if (fournisseurList!.isEmpty) {
          print('****fournisseur db exist, return empty list');
          return _fournisseurs;
        }

        for (int i = 0; i < fournisseurList.length; i++) {
          _fournisseurs.add(Fournisseur.fromJson(fournisseurList[i]));
        }
        await Hive.close();
        print('****fournisseurs data exist: $_fournisseurs');
        return _fournisseurs;
      } else {
        await Hive.close();
        print('***no fournisseur found');
        return <Fournisseur>[];
      }
    } catch (e) {
      print("error on local provider - fetch fournisseur: ${e.toString()}");
      await Hive.close();
      return null;
    }
  }

  Future<Fournisseur?>? addFournisseur(Fournisseur fournisseur) async {
    try {
      bool data = await checkData();
      if (data) {
        final db = await Hive.openBox("fournisseur");
        String? _data = db.get("fournisseurList");

        if (_data != null) {
          List fournisseurList = jsonDecode(_data);
          print(
              '***fournisseur box exist. List: ${fournisseurList.toString()}');
          // final Map fournisseurData = {...fournisseur.toJson(), 'sync': 0};

          fournisseurList = [fournisseur.toJson(), ...fournisseurList];
          db.put("fournisseurList", jsonEncode(fournisseurList));
          await Hive.close();
          print('Data local save successful: ${fournisseur.toString()}');
          return fournisseur;
        }
        List fournisseurList = [fournisseur.toJson()];
        db.put("fournisseurList", jsonEncode(fournisseurList));
        await Hive.close();
        print('Data local save successful: ${fournisseurList.toString()}');
        return fournisseur;
      } else {
        final db = await Hive.openBox("fournisseur");
        List fournisseurList = [fournisseur.toJson()];
        db.put("fournisseurList", jsonEncode(fournisseurList));
        print('***create fournisseur box. List: ${fournisseurList.toString()}');
        await Hive.close();
        return fournisseur;
      }
    } catch (e) {
      print("Error on local provider: ${e.toString()}");
      await Hive.close();
      return null;
    }
  }

  Future<Fournisseur>? getFournisseur(String id) {
    return null;
  }

  Future<bool>? cacheFournisseur(Fournisseur? fournisseur) {
    //todo: cache model
    return null;
  }

  Future<bool?>? cacheFournisseurs(List<Fournisseur>? fournisseurs) async {
    //todo: cache model
    final db = await Hive.openBox("fournisseur");
    try {
      List fournisseurList = [];

      for (int i = 0; i < fournisseurs!.length; i++) {
        fournisseurList.add(fournisseurs[i].toJson());
      }
      db.put("fournisseurList", jsonEncode(fournisseurList));
      await Hive.close();
      print('Cache fournisseurs.');
      return true;
    } catch (e) {
      print("Error on cache fournisseurs: ${e.toString()}");
      await Hive.close();
      return false;
    }
  }
}
