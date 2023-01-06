import 'package:sigi_android/common/platform/connectivity_manager.dart';
import 'package:sigi_android/features/producteur/data/fundingRequest/funding_request_local_data_provider.dart';
import 'package:sigi_android/features/producteur/data/fundingRequest/funding_request_model.dart';
import 'package:sigi_android/features/producteur/data/fundingRequest/funding_request_remote_data_provider.dart';

class FundingRequestRepository {
  FundingRequestRepository(
    this.fundingRequestLocalDataProvider,
    this.fundingRequestRemoteDataProvider,
  );

  final FundingRequestLocalDataProvider fundingRequestLocalDataProvider;
  final FundingRequestRemoteDataProvider fundingRequestRemoteDataProvider;

  Future<FundingRequest?> sendFundingRequest(
      FundingRequest fundingRequest) async {
    print('****** send fundingRequest: begin');
    if (await ConnectivityManager.isConnected) {
      try {
        print('****** send fundingRequest: user connected');
        final FundingRequest? result = await fundingRequestRemoteDataProvider
            .sendFundingRequest(fundingRequest);
        if (result == null) {
          return await fundingRequestLocalDataProvider
              .saveFundingRequest(fundingRequest);
        }
        fundingRequestLocalDataProvider.cacheFundingRequest(fundingRequest);
        return fundingRequest;
      } catch (e) {
        print(e);
        return null;
        // return ServerException()();
      }
    } else {
      print('****** send fundingRequest: user not connected');
      return await fundingRequestLocalDataProvider
          .saveFundingRequest(fundingRequest);
    }
  }

  Future<List<FundingRequest?>?>? fetchFundingRequest() async {
    if (await ConnectivityManager.isConnected) {
      try {
        final List<FundingRequest>? fundingRequests =
            await fundingRequestRemoteDataProvider.fetchFundingRequest();
        fundingRequestLocalDataProvider.cacheFundingRequests(fundingRequests);
        return fundingRequests;
      } catch (e) {
        print(e);
        return null;
        // return ServerException()();
      }
    } else {
      return await fundingRequestLocalDataProvider.fetchFundingRequests();
    }
  }

  Future<FundingRequest?> getFundingRequest(String id) async {
    if (await ConnectivityManager.isConnected) {
      try {
        final FundingRequest? fundingRequest =
            await fundingRequestRemoteDataProvider.getFundingRequest(id);
        // cache product
        fundingRequestLocalDataProvider.cacheFundingRequest(fundingRequest);
        return fundingRequest;
      } catch (e) {
        print(e);
        return null;
        // return ServerException()();
      }
    } else {
      return await fundingRequestLocalDataProvider.getFundingRequest(id);
    }
  }
}
