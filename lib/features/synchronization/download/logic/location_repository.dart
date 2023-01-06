import 'package:sigi_android/features/synchronization/download/data/location/location_remote_provider.dart';
import '../data/location/location_local_provider.dart';

class LocationDataRepository {
  static Future<Map?>? getLocationData() async {
    Map data = {};
    List? result = [];

    result = await LocationLocalProvider.getLocationData(field: "province");
    data["province"] = result ?? <String>['province'];

    result = await LocationLocalProvider.getLocationData(field: "cities");
    data["cities"] = result ?? <String>['Ville'];

        result = await LocationLocalProvider.getLocationData(field: "territories");
    data["territories"] = result ?? <String>['Terrotoire'];

        result = await LocationLocalProvider.getLocationData(field: "sectors");
    data["sectors"] = result ?? <String>['Secteur'];

        result = await LocationLocalProvider.getLocationData(field: "towns");
    data["towns"] = result ?? <String>['Communes'];

    return data;
  }

  static Future<List?> downloadProvince() async {
    try {
      List? result =
          await LocationRemoteProvider.fetchLocationData(location: "provinces");
      if (result != null) {
        return await LocationLocalProvider.saveLocation(
            field: "province", data: result);
      } else {
        // Get.back();
        return null;
      }
    } catch (error) {
      // Get.back();
      return null;
    }
  }

  static Future<List?> downloadVille() async {
    try {
      List? result =
          await LocationRemoteProvider.fetchLocationData(location: "cities");
      if (result != null) {
        return await LocationLocalProvider.saveLocation(
            field: "cities", data: result);
      } else {
        // Get.back();
        return null;
      }
    } catch (error) {
      // Get.back();
      return null;
    }
  }

  static Future<List?> downloadTerritoire() async {
    try {
      List? result = await LocationRemoteProvider.fetchLocationData(
          location: "territories");
      if (result != null) {
        return await LocationLocalProvider.saveLocation(
            field: "territories", data: result);
      } else {
        // Get.back();
        return null;
      }
    } catch (error) {
      // Get.back();)
      return null;
    }
  }

  static Future<List?> downloadSecteur() async {
    try {
      List? result =
          await LocationRemoteProvider.fetchLocationData(location: "sectors");
      if (result != null) {
        return await LocationLocalProvider.saveLocation(
            field: "sectors", data: result);
      } else {
        // Get.back();
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  static Future<List?> downloadCommune() async {
    try {
      List? result =
          await LocationRemoteProvider.fetchLocationData(location: "towns");
      if (result != null) {
        return await LocationLocalProvider.saveLocation(
            field: "towns", data: result);
      } else {
        // Get.back();
        return null;
      }
    } catch (error) {
      // Get.back();
      return null;
    }
  }
}
