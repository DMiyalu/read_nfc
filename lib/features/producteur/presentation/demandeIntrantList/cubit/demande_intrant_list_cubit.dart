import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sigi_android/features/producteur/data/fundingRequest/funding_request_local_data_provider.dart';
import 'package:sigi_android/features/producteur/data/fundingRequest/funding_request_model.dart';
import 'package:sigi_android/features/producteur/data/fundingRequest/funding_request_remote_data_provider.dart';
import 'package:sigi_android/features/producteur/data/producteur/producteur_local_data_provider.dart';
import 'package:sigi_android/features/producteur/data/producteur/producteur_remote_data_provider.dart';
import 'package:sigi_android/features/producteur/logic/funding_request_repository.dart';
import 'package:sigi_android/features/producteur/logic/producteur_repository.dart';
part 'demande_intrant_list_state.dart';

class DemandeIntrantListCubit extends Cubit<DemandeIntrantListState> {
  DemandeIntrantListCubit()
      : super(DemandeIntrantListState(field: initialState()));

  final FundingRequestRepository fundingRequestRepository =
      FundingRequestRepository(
    FundingRequestLocalDataProvider(),
    FundingRequestRemoteDataProvider(),
  );

  final ProducteurRepository producteurRepository = ProducteurRepository(
    ProducteurLocalDataProvider(),
    ProducteurRemoteDataProvider(),
  );

  Future<void> onFecthDemandeIncitations() async {
    emit(DemandeIntrantListState(field: {
      ...state.field!,
      'loading': true,
      'status': 0,
    }));

    final List<FundingRequest?>? _fundingRequest =
        await fundingRequestRepository.fetchFundingRequest();
    // if (result == null) {
    //   emit(DemandeIntrantListState(field: {
    //     ...state.field!,
    //     'loading': false,
    //     'status': 500,
    //   }));
    // }

    emit(DemandeIntrantListState(field: {
      ...state.field!,
      'loading': false,
      'status': 200,
      'data': _fundingRequest ?? <FundingRequest>[],
    }));
  }

  void onRefreshFundingRequest(FundingRequest data) {
    print("********update liste demande incitation");
    List<FundingRequest> _fundingeRequest = [data, ...state.field!['data']];
    emit(DemandeIntrantListState(field: {
      ...state.field!,
      'data': _fundingeRequest,
    }));
  }
}
