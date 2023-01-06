import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:sigi_android/features/producteur/data/fundingRequest/funding_request_local_data_provider.dart';
import 'package:sigi_android/features/producteur/data/fundingRequest/funding_request_model.dart';
import 'package:sigi_android/features/producteur/data/fundingRequest/funding_request_remote_data_provider.dart';
import 'package:sigi_android/features/producteur/logic/funding_request_repository.dart';
import 'package:sigi_android/features/producteur/logic/producteur_repository.dart';
import '../../../../data/producteur/producteur_local_data_provider.dart';
import '../../../../data/producteur/producteur_remote_data_provider.dart';
part 'demande_intrant_registration_state.dart';

class DemandeIntrantRegistrationCubit
    extends Cubit<DemandeIntrantRegistrationState> {
  DemandeIntrantRegistrationCubit()
      : super(DemandeIntrantRegistrationState(field: initialState()));

  final FundingRequestRepository fundingRequestRepository =
      FundingRequestRepository(
    FundingRequestLocalDataProvider(),
    FundingRequestRemoteDataProvider(),
  );

  final ProducteurRepository producteurRepository = ProducteurRepository(
    ProducteurLocalDataProvider(),
    ProducteurRemoteDataProvider(),
  );

  void initForm() async {
    Map _field = {
      ...initialState()!,
      'step': 1,
      'formTitle': 'Verification producteur',
    };
    emit(DemandeIntrantRegistrationState(field: _field));
  }

  void goToNextFormStep() async {
    int currentStep = state.field!['step'];

    if (currentStep == 3) {
      // TODO: Update Demandes Intrants List
      print('save data: ${state.field!['data'].toString()}');
      return Get.back();
    }
    currentStep += 1;

    emit(DemandeIntrantRegistrationState(field: {
      ...state.field!,
      'step': currentStep,
      'formTitle': getFormTitle(currentStep),
    }));
  }

  void goToPreviewFormStep() async {
    int currentStep = state.field!['step'];

    if (currentStep == 1) Get.back();
    currentStep -= 1;

    emit(DemandeIntrantRegistrationState(field: {
      ...state.field!,
      'step': currentStep,
      'formTitle': getFormTitle(currentStep),
    }));
  }

  String getFormTitle(int step) {
    if (step == 1) return 'Verification producteur';
    if (step == 2) return 'Identité producteur';
    if (step == 3) return 'Demande d\'intrant';
    return "";
  }

  void updateField(context,
      {required String field, Map? data, String? fieldName}) {
    emit(DemandeIntrantRegistrationState(field: {
      ...state.field!,
      field: data,
    }));
    if (fieldName == 'largeur' || fieldName == 'longueur') {
      updateArea(context);
    }
  }

  void updateArea(context) {
    try {
      if (state.field!['data']['largeur'] != '' &&
          state.field!['data']['longueur'] != '') {
        double _largeur = double.parse(state.field!['data']['largeur']);
        double _longueur = double.parse(state.field!['data']['longueur']);
        double _surface = _largeur * _longueur;

        Map _data = state.field!['data'];
        _data['surface'] = _surface.toString();
        emit(DemandeIntrantRegistrationState(field: {
          ...state.field!,
          'data': _data,
        }));
      }
    } catch (e) {
      print('error on area calculation: ${e.toString()}');
      return;
    }
  }

  Future<FundingRequest?>? sendFundingRequest(context) async {
    emit(DemandeIntrantRegistrationState(field: {
      ...state.field!,
      'sending': true,
    }));
    await Future.delayed(const Duration(seconds: 2));

    try {
      FundingRequest _fundingRequest = FundingRequest(
        "/api/pteches/1", //state.field!['data']['ptech'],
        state.field!['data']['longueur'],
        state.field!['data']['largeur'],
        state.field!['data']['actionArea'],
        "/api/territorries/1", //state.field!['data']['territoire'],
        state.field!['data']['inputNeedImplementationPtechs'],
        state.field!['data']['jwtNFC'],
      );

      final result = await fundingRequestRepository
          .sendFundingRequest(_fundingRequest);

      if (result == null) {
        emit(DemandeIntrantRegistrationState(field: {
          ...state.field!,
          'sending': false,
        }));
        return null;
      }

      emit(DemandeIntrantRegistrationState(field: {
        ...state.field!,
        'sending': false,
      }));
      return _fundingRequest;
    } catch (e) {
      print('Error On Cubit: ${e.toString()}');
      emit(DemandeIntrantRegistrationState(field: {
        ...state.field!,
        'sending': false,
      }));
      return null;
    }
  }
}
