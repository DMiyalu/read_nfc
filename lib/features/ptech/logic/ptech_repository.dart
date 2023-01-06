// ignore_for_file: avoid_print

import 'package:sigi_android/common/platform/connectivity_manager.dart';
import 'package:sigi_android/features/ptech/data/ptech_local_data_provider.dart';
import 'package:sigi_android/features/ptech/data/ptech_remote_data_provider.dart';
import '../data/ptech_model.dart';

class PtechRepository {
  PtechRepository(
    this.ptechLocalDataProvider,
    this.ptechRemoteDataProvider,
  );
  final PtechLocalDataProvider ptechLocalDataProvider;
  final PtechRemoteDataProvider ptechRemoteDataProvider;

  Future<List<PtechModel>?>? fecthPtechs() async {
    if (await ConnectivityManager.isConnected) {
      try {
        final List<PtechModel>? ptechs =
            await ptechRemoteDataProvider.fetchPtechData();
        ptechLocalDataProvider.cachePtechs(ptechs!);
        return null;
      } catch (e) {
        print(e);
        return null;
        // return ServerException()();
      }
    } else {
      return ptechLocalDataProvider.fetchPtechData();
    }
  }

  Future<PtechModel?> addPtech(PtechModel data) async {
    if (await ConnectivityManager.isConnected) {
      try {
        final PtechModel? ptech =
            await ptechRemoteDataProvider.sendPtechData(data);
        ptechLocalDataProvider.cachePtech(ptech);
        return ptech;
      } catch (e) {
        print(e);
        return null;
        // return ServerException()();
      }
    } else {
      print('****not connected. Save on local');
      return await ptechLocalDataProvider.savePtechData(data);
    }
  }
}
