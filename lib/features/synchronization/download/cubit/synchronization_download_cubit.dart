import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:sigi_android/features/synchronization/download/logic/location_repository.dart';
import 'package:sigi_android/features/synchronization/download/logic/ptech_repository.dart';
part 'synchronization_download_state.dart';

class SynchronizationDownloadCubit extends Cubit<SynchronizationDownloadState> {
  SynchronizationDownloadCubit()
      : super(SynchronizationDownloadState(field: initialState()));

  Future<void> onDownloadLocation(context) async {
    // Download
  }

  Future<void> onDownloadPtechFormData(context) async {
    emit(SynchronizationDownloadState(field: {
      ...initialState(),
      'loading': true,
      'step': 'Organisation parrains'
    }));
    List? businessNetwork = await PtechRepository.fetchBusinessNetwork();
    print('* Download businessNetwork: $businessNetwork');

    emit(SynchronizationDownloadState(
        field: {...initialState(), 'loading': true, 'step': 'Status Legal'}));
    List? legalStatus = await PtechRepository.fetchLegalStatus();
    print('*Download legalStatus: $legalStatus');

    emit(SynchronizationDownloadState(field: {
      ...initialState(),
      'loading': true,
      'step': "Chiffre d'affaires"
    }));
    List? turnover = await PtechRepository.fetchTurnOver();
    print('Download turnover: $turnover');

    emit(SynchronizationDownloadState(field: {
      ...initialState(),
      'loading': true,
      'step': 'Mode de stockage'
    }));
    List? productDisplayMode = await PtechRepository.fetchProductDisplayMode();
    print('Download productDisplayMode: $productDisplayMode');

    emit(SynchronizationDownloadState(
        field: {...initialState(), 'loading': true, 'step': 'Spécialités'}));
    List? supplierSpecialties =
        await PtechRepository.fetchSupplierSpecialities();
    print('Download supplierSpecialties: $supplierSpecialties');

    // Location Data
        emit(SynchronizationDownloadState(
        field: {...initialState(), 'loading': true, 'step': 'Provinces'}));
    List? provinces = await LocationDataRepository.downloadProvince();
    print('Download provinces: $provinces');

    emit(SynchronizationDownloadState(
        field: {...initialState(), 'loading': true, 'step': 'Villes'}));
    List? cities = await LocationDataRepository.downloadVille();
    print('Download villes: $cities');

    emit(SynchronizationDownloadState(
        field: {...initialState(), 'loading': true, 'step': 'Communes'}));
    List? towns = await LocationDataRepository.downloadCommune();
    print('Download communes: $towns');

    emit(SynchronizationDownloadState(field: {
      ...initialState(),
      'loading': false,
    }));
    Get.back();
  }
}
