import 'dart:convert';
import 'package:sigi_android/features/authentication/database/save_token.dart';
import 'package:http/http.dart' as http;
import 'funding_request_model.dart';

class FundingRequestRemoteDataProvider {
  final String url =
      "http://incentive.baadhiteam.com/api/implementation_pteches";

  Future<List<FundingRequest>?>? fetchFundingRequest() async {
    return null;
  }

  Future<FundingRequest?>? sendFundingRequest(
      FundingRequest fundingRequest) async {
    var tk = await SaveToken.getCredentials();
    var value = tk!["data"];
    var token = value["access_token"];
    http.Response? response;
    try {
      response = await http.post(Uri.parse(url),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(fundingRequest.toJson()));
      print("**** Demande incitation response:${response.body.toString()}");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        print("send demande incitation success ${response.body.toString()}");
        return fundingRequest;
      }

      if (response.statusCode == 401) {
        print(
            '** Bad credentials. Refresh token. Error: ${response.body.toString()}');
        return null;
      }

      print("send demande incitation failed: ${response.statusCode}");
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> closeFundingRequest() async {
    return true;
  }

  Future<FundingRequest>? getFundingRequest(String id) {
    return null;
  }
}
