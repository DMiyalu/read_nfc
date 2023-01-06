// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:hive/hive.dart';
import 'funding_request_model.dart';

class FundingRequestLocalDataProvider {
  static Future<bool> checkData() async {
    return await Hive.boxExists("fundingRequest");
  }

  Future<List<FundingRequest?>?> fetchFundingRequests() async {
    try {
      bool data = await checkData();
      if (data) {
        final db = await Hive.openBox("fundingRequest");
        String _data = db.get("fundingRequestList");
        List fundingRequestList = jsonDecode(_data);

        List<FundingRequest> _fundingRequests = <FundingRequest>[];
        if (fundingRequestList.isEmpty) {
          print('****fundingRequest db exist, return empty list');
          return _fundingRequests;
        }

        for (int i = 0; i < fundingRequestList.length; i++) {
          _fundingRequests.add(FundingRequest.fromJson(fundingRequestList[i]));
        }
        await Hive.close();
        print('****fundingRequest data exist: $_fundingRequests');
        return _fundingRequests;
      } else {
        return <FundingRequest>[];
      }
    } catch (e) {
      print("error on local provider - fetch fundingRequests: ${e.toString()}");
      await Hive.close();
      return null;
    }
  }

  Future<FundingRequest?>? getFundingRequest(String id) async {
    return null;
  }

  Future<FundingRequest?>? saveFundingRequest(FundingRequest? data) async {
    try {
      bool dbExist = await checkData();
      if (dbExist) {
        final db = await Hive.openBox("fundingRequest");
        String _data = db.get("fundingRequestList");
        List fundingRequestList = jsonDecode(_data);
        fundingRequestList = [data!.toJson(), ...fundingRequestList];
        db.put("fundingRequestList", jsonEncode(fundingRequestList));
        await Hive.close();
        print('Data save successful: ${data.toString()}');
        return data;
      } else {
        final db = await Hive.openBox("fundingRequest");
        db.put("fundingRequestList", jsonEncode([data!.toJson()]));
        await Hive.close();
        print('Create db and save data: ${data.toString()}');
        return data;
      }
    } catch (e) {
      print(e.toString());
      Hive.close();
      return null;
    }
  }

  Future<bool>? cacheFundingRequest(FundingRequest? fundingRequest) {
    //todo: cache model
    return null;
  }

  Future<bool>? cacheFundingRequests(List<FundingRequest>? fundingRequests) {
    //todo: cache model
    return null;
  }
}
