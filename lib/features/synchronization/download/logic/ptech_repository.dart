import '../data/ptech/ptech_local_provider.dart';
import '../data/ptech/ptech_remote_provider.dart';

class PtechRepository {
  static Future<Map?>? getStaticFormData() async {
    Map data = {};
    List? result = [];

    // businessNetwork
    result = await PtechLocalProvider.getFormData(field: "businessNetwork");
    data["businessNetwork"] = result ?? [];

    // legalStatus
    result = await PtechLocalProvider.getFormData(field: "legalStatus");
    data["legalStatus"] = result ?? [];

    // turnover
    result = await PtechLocalProvider.getFormData(field: "turnOver");
    data["turnOver"] = result ?? [];

    // productDisplayMode
    result = await PtechLocalProvider.getFormData(field: "productDisplayMode");
    data["productDisplayMode"] = result ?? [];

    // supplierSpecialties
    result = await PtechLocalProvider.getFormData(field: "supplierSpecialities");
    data["supplierSpecialities"] = result ?? [];

    return data;
  }

  static Future<List?>? fetchBusinessNetwork() async {
    try {
      final List? result = await PtechRemoteProvider.fetchBusinessNetwork();
      if (result!.isNotEmpty) {
        return PtechLocalProvider.saveFormData(
            field: "businessNetwork", data: result);
      } else {
        // Get.back();
        return null;
      }
    } catch (error) {
      // Get.back();
      return null;
    }
  }

  static Future<List?>? fetchLegalStatus() async {
    try {
      List? result = await PtechRemoteProvider.fetchLegalStatus();
      if (result != null) {
        return PtechLocalProvider.saveFormData(
            field: "legalStatus", data: result);
      } else {
        // Get.back();
        return null;
      }
    } catch (error) {
      // Get.back();
      return null;
    }
  }

  static Future<List?>? fetchTurnOver() async {
    try {
      List? result = await PtechRemoteProvider.fetchTurnOver();
      if (result != null) {
        return PtechLocalProvider.saveFormData(field: "turnOver", data: result);
      } else {
        // Get.back();
        return null;
      }
    } catch (error) {
      // Get.back();
      return null;
    }
  }

  static Future<List?>? fetchProductDisplayMode() async {
    try {
      List? result = await PtechRemoteProvider.fetchProductDisplayMode();
      if (result != null) {
        return PtechLocalProvider.saveFormData(
            field: "productDisplayMode", data: result);
      } else {
        // Get.back();
        return null;
      }
    } catch (error) {
      // Get.back();
      return null;
    }
  }

  static Future<List?>? fetchSupplierSpecialities() async {
    try {
      List? result = await PtechRemoteProvider.fetchSupplierSpecialities();
      if (result != null) {
        return PtechLocalProvider.saveFormData(
            field: "supplierSpecialities", data: result);
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
