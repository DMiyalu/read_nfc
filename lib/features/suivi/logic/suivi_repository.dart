// ignore_for_file: avoid_print

import 'package:sigi_android/common/platform/connectivity_manager.dart';
import 'package:sigi_android/features/suivi/data/suivi_local_data_provider.dart';
import 'package:sigi_android/features/suivi/data/suivi_model.dart';
import 'package:sigi_android/features/suivi/data/suivi_remote_data_provider.dart';

class SuiviRepository {
  SuiviRepository(
    this.suiviLocalDataProvider,
    this.suiviRemoteDataProvider,
  );
  final SuiviLocalDataProvider suiviLocalDataProvider;
  final SuiviRemoteDataProvider suiviRemoteDataProvider;

  Future<List<SuiviModel>?>? fecthSuivis() async {
    if (await ConnectivityManager.isConnected) {
      try {
        final List<SuiviModel>? suivis =
            await suiviRemoteDataProvider.fetchSuiviData();
        suiviLocalDataProvider.cacheSuivis(suivis!);
        return null;
      } catch (e) {
        print(e);
        return null;
        // return ServerException()();
      }
    } else {
      return suiviLocalDataProvider.fetchSuiviData();
    }
  }

  Future<SuiviModel?> addSuivi(SuiviModel data) async {
    if (await ConnectivityManager.isConnected) {
      try {
        final SuiviModel? suivi =
            await suiviRemoteDataProvider.sendSuiviData(data);
        suiviLocalDataProvider.cacheSuivi(suivi);
        return suivi;
      } catch (e) {
        print(e);
        return null;
        // return ServerException()();
      }
    } else {
      print('****not connected. Save on local');
      return await suiviLocalDataProvider.saveSuiviData(data);
    }
  }
}
