import 'dart:convert';
import 'dart:typed_data';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:sigi_android/common/utils/camera.dart';
import 'package:sigi_android/features/fournisseur/data/fournisseur_local_data_provider.dart';
import 'package:sigi_android/features/fournisseur/data/fournisseur_model.dart';
import 'package:sigi_android/features/fournisseur/data/fournisseur_remote_data_provider.dart';
import 'package:sigi_android/features/fournisseur/logic/fournisseur_repository.dart';
import 'package:sigi_android/features/synchronization/download/logic/location_repository.dart';
import 'dart:math' as Math;
import 'package:sigi_android/features/synchronization/download/logic/ptech_repository.dart';
import 'package:bloc/bloc.dart';
part 'fournisseur_registration_state.dart';

class FournisseurRegistrationCubit extends Cubit<FournisseurRegistrationState> {
  FournisseurRegistrationCubit()
      : super(FournisseurRegistrationState(field: initialState()));

  FournisseurRepository fournisseurRepository = FournisseurRepository(
      FournisseurLocalDataProvider(), FournisseurRemoteDataProvider());

  Future<void> generateSupplierSpecialty() async {
    final List<String> supplierSpecialties =
        state.field!['supplierSpecialities'];
    Map supplierSpecialty = {};

    if (supplierSpecialties.isNotEmpty) {
      supplierSpecialties.map((speciality) {
        supplierSpecialty[speciality] = false;
      });
    }

    final Map providerCapacity = {
      ...state.field!['providerCapacity'],
      'supplierSpecialty': supplierSpecialty,
    };

    emit(FournisseurRegistrationState(field: {
      ...state.field!,
      'providerCapacity': providerCapacity,
    }));
  }

  // Future<void>

  void initForm() async {
    String nui = await getNui();
    Map providerIdentity = {
      ...initialState()!['providerIdentity'],
      'nui': nui,
    };

    final Map? formData = await PtechRepository.getStaticFormData();
    final Map? locationData = await LocationDataRepository.getLocationData();

    List<String>? businessNetwork =
        await getLabel(formData!['businessNetwork'], "businessNetwork");
    List<String>? legalStatus =
        await getLabel(formData['legalStatus'], 'legalStatus');
    List<String>? turnover = await getLabel(formData['turnOver'], 'turnOver');
    List<String>? productDisplayMode =
        await getLabel(formData['productDisplayMode'], 'productDisplayMode');
    List<String>? supplierSpecialties = await getLabel(
        formData['supplierSpecialities'], 'supplierSpecialities');
    List<String>? provinces =
        await getLabel(locationData!['province'], 'province');
    // List<String>? cities = await getLabel(locationData['cities'], 'cities');
    // List<String>? territories =
    //     await getLabel(locationData['territories'], 'territories');
    // List<String>? sectors = await getLabel(locationData['sectors'], 'sectors');
    // List<String>? towns = await getLabel(locationData['towns'], 'towns');

    Map _field = {
      ...initialState()!,
      'step': 1,
      'providerIdentity': providerIdentity,
      'formTitle': 'Identité fournisseur',
      'businessNetwork': businessNetwork,
      'legalStatus': legalStatus,
      'turnOver': turnover ?? ["Chiffre d'affaire"],
      'productDisplayMode': productDisplayMode,
      'supplierSpecialities': supplierSpecialties,
      'province': provinces,
      // 'cities': cities,
      // 'territories': territories,
      // 'sectors': sectors,
      // 'towns': towns,
      'ptechFormData': formData,
      'locationFormData': locationData,
    };
    emit(FournisseurRegistrationState(field: _field));
  }

  Future<List<String>?> getLabel(List? dataList, String? field) async {
    List<String> data = [];

    try {
      if (dataList == null) return data;

      if (dataList.isNotEmpty) {
        dataList.forEach((element) {
          final Map item = {...element};
          if (item.containsKey("name")) {
            data.add(element['name']);
          }

          if (item.containsKey("wording")) {
            data.add(element['wording']);
          }
        });
      }
      return data;
    } catch (error) {
      print("Name not found: $field");
      return null;
    }
  }

  int number() => Math.Random().nextInt(9);
  Future<String> getNui() async {
    String nui = "ag";
    for (int i = 0; i < 7; i++) {
      nui += number().toString();
    }
    return nui;
  }

  void updateGpsData({required Position position}) {
    Map _gps = {
      "longitude": position.longitude.toString(),
      "latitude": position.latitude.toString(),
      "altitude": position.altitude.toString(),
    };
    Map _adress = {
      ...state.field!['providerAdress'],
      'addressLine': 'No. Avenue. Reference.',
      'altitude': _gps['altitude'],
      'longitude': _gps['longitude'],
      'latitude': _gps['latitude'],
    };

    emit(FournisseurRegistrationState(field: {
      ...state.field!,
      'providerAdress': _adress,
    }));
  }

  Future<bool> checkDocumentPhoto() async {
    if (state.field!['providerManagement']['organeDeGestion']['photoRCCM'] ==
        '') {
      emit(FournisseurRegistrationState(field: {
        ...state.field!,
        'providerManagementPhotoStatus': 404,
      }));
      return false;
    }
    return true;
  }

  void getToNextFormStep() async {
    int currentStep = state.field!['step'];

    if (currentStep == 5) {
      print('save data: ${state.field!.toString()}');
      return Get.back();
    }

    currentStep += 1;
    emit(FournisseurRegistrationState(field: {
      ...state.field!,
      'step': currentStep,
      'formTitle': getFormTitle(currentStep),
    }));
  }

  void getToPreviousFormStep() async {
    int currentStep = state.field!['step'];
    if (currentStep == 1) {
      Get.back();
      return;
    }

    currentStep -= 1;
    emit(FournisseurRegistrationState(field: {
      ...state.field!,
      'step': currentStep,
      'formTitle': getFormTitle(currentStep),
    }));
  }

  String getFormTitle(int step) {
    if (step == 1) return 'Identité fournisseur';
    if (step == 2) return 'Adresse du fournisseur';
    if (step == 3) return 'Gestion et fonctionnement';
    if (step == 4) return 'Mode de paiement';
    if (step == 5) return 'Capacité du fournisseur';
    return "";
  }

  Future<void> onDeletePicture({
    required String mainfield,
    String? field,
    String? subfield,
    required String status,
  }) async {
    if (mainfield == 'providerManagement') {
      try {
        Map _providerField = state.field!['providerManagement'];
        _providerField['organeDeGestion']['photoRCCM'] = '';
        emit(FournisseurRegistrationState(field: {
          ...state.field!,
          mainfield: _providerField,
          status: 0,
        }));
        return;
      } catch (e) {
        emit(FournisseurRegistrationState(field: {
          ...state.field!,
          status: 500,
        }));
        return;
      }
    }

    Map _providerField = state.field![mainfield];
    _providerIdentity['photo'] = '';
    emit(FournisseurRegistrationState(field: {
      ...state.field!,
      mainfield: _providerField,
      status: 0,
    }));
  }

  Future<void> takePicture(
      {required String mainfield,
      String? field,
      String? subfield,
      required ImageSource source,
      required String status}) async {
    XFile? _imageFile = await CameraUtils().takePicture(source);

    // take picture failed
    if (_imageFile == null) {
      emit(FournisseurRegistrationState(field: {
        ...state.field!,
        status: 500,
      }));
      return;
    }

    // Take Picture Success
    // Croppe Image
    // CroppedFile? _imageCropped = await CameraUtils()
    //     .croppeImageFile(imageFile: _imageFile, fixedRatio: true);

    // if (_imageCropped == null) {
    //   emit(FournisseurRegistrationState(field: {
    //     ...state.field!,
    //     'providerPhotoStatus': 500,
    //   }));
    //   return;
    // }

    // Croppe Image Successful
    // print('***cropp image build success');

    // Uint8List imagebytes =
    //     await _imageCropped.readAsBytes(); // Convert to bytes

    Uint8List imagebytes = await _imageFile.readAsBytes(); // Convert to bytes

    String base64string =
        base64.encode(imagebytes); //convert bytes to base64 string
    // return;

    // Update State
    if (mainfield == 'providerManagement') {
      try {
        Map _providerField = state.field!['providerManagement'];
        _providerField['organeDeGestion']['photoRCCM'] = base64string;
        emit(FournisseurRegistrationState(field: {
          ...state.field!,
          mainfield: _providerField,
          status: 200,
        }));
        return;
      } catch (e) {
        emit(FournisseurRegistrationState(field: {
          ...state.field!,
          status: 500,
        }));
      }
    }

    Map _providerField = state.field![mainfield];
    _providerField['photo'] = base64string;
    emit(FournisseurRegistrationState(field: {
      ...state.field!,
      mainfield: _providerField,
      status: 200,
    }));
  }

  void updateField(context,
      {required String field, Map? data, String? fieldName}) {
    emit(FournisseurRegistrationState(field: {
      ...state.field!,
      field: data,
    }));

    if (field == 'providerAdress') {
      _updateAdressField(field: field, fieldName: fieldName ?? '');
    }

    if (fieldName == 'largeur' || fieldName == 'longueur') {
      updateArea(context);
    }
  }

  void updateArea(context) {
    try {
      if (state.field!['providerCapacity']['area']['length'] != 0.0 &&
          state.field!['providerCapacity']['area']['lenght'] != 0.0) {
        print(
            'area value: ${state.field!['providerCapacity']['area']['length'].runtimeType}');
        print(
            'area value: ${state.field!['providerCapacity']['area']['lenght'].runtimeType}');
        double length =
            double.parse(state.field!['providerCapacity']['area']['length']);
        double lenght =
            double.parse(state.field!['providerCapacity']['area']['lenght']);
        double surface = length * lenght;
        print('area value: ${surface.runtimeType}');

        Map providerCapacity = state.field!['providerCapacity'];
        providerCapacity['area']['totalArea'] = surface;
        emit(FournisseurRegistrationState(field: {
          ...state.field!,
          'providerCapacity': providerCapacity,
        }));
      }
    } catch (e) {
      print('error on area calculation: ${e.toString()}');
      return;
    }
  }

  Future<void> getSupplierSpecialtyList() async {
    try {
      final Map supplierSpecialty =
          state.field!['providerCapacity']['supplierSpecialty'];
      List supplierSpecialtiesList = [];
      supplierSpecialty.keys.map((item) {
        if (supplierSpecialty[item]) {
          supplierSpecialtiesList.add(item.toString());
        }
      });

      emit(FournisseurRegistrationState(field: {
        ...state.field!,
        'supplierSpecialtyList': supplierSpecialtiesList,
      }));
    } catch (e) {
      print('Error on create supplierSpecialtiesList: ${e.toString()}');
      return;
    }
  }

  Future<Fournisseur?>? onSubmit(context) async {
    emit(FournisseurRegistrationState(field: {
      ...state.field!,
      'sending': true,
    }));
    // await Future.delayed(const Duration(seconds: 2));

    try {
      final Fournisseur _fournisseur = Fournisseur(
        name: state.field!['providerIdentity']['fullName'],
        shortName: state.field!['providerIdentity']['shortName'],
        createdAt: state.field!['providerIdentity']['createdAt'],
        phone: state.field!['providerIdentity']['phone'],
        email: state.field!['providerIdentity']['email'],
        nui: state.field!['providerIdentity']['nui'],
        photo: state.field!['providerIdentity']['photo'],
        managerName: state.field!['providerIdentity']['managerName'],
        adress: state.field!['providerAdress'],
        managementAndOperation: state.field!['providerManagement'],
        payment: state.field!['providerPayment'],
        supplierCapacity: state.field!['providerCapacity'],
      );

      // print('Fournisseur: ${_fournisseur.toJson().toString()}');

      Fournisseur? _result =
          await fournisseurRepository.addFournisseur(_fournisseur);

      if (_result == null) {
        emit(FournisseurRegistrationState(field: {
          ...state.field!,
          'sending': false,
          'error': true,
        }));
        return null;
      }

      emit(FournisseurRegistrationState(field: {
        ...state.field!,
        'sending': false,
        'error': false,
      }));
      return _fournisseur;
    } catch (e) {
      print('Error On Cubit: ${e.toString()}');
      emit(FournisseurRegistrationState(field: {
        ...state.field!,
        'sending': false,
        'error': true,
      }));
      return null;
    }
  }

  void _updateAdressField({required String field, String? fieldName}) {
    if (fieldName == "province") {
      _updateVilleList();
      return;
    }

    if (fieldName == "city") {
      _updateCommuneList();
    }
  }

  void _updateVilleList() {
    Map adress = state.field!['providerAdress'];
    String province = adress['province'];

    // ignore: unnecessary_null_comparison
    if (province.toLowerCase() == 'province' || province == null) {
      emit(FournisseurRegistrationState(field: {
        ...state.field!,
        'cities': <String>['ville'],
      }));
      _updateCommuneList();
      return;
    }

    // Get Ville List Given By The API
    Map? locationFormData = state.field!["locationFormData"];
    List data = locationFormData!['cities'];
    List<String> duplicatesRemoved = <String>["Ville"];
    List<String> villeList = <String>["Ville"];
    List villeListItem = [];
    adress['city'] = 'Ville';

    if (data.isNotEmpty) {
      villeListItem = data
          .where((ville) =>
              ville['province']['name'].toString().toLowerCase() ==
              province.toString().toLowerCase())
          .toList();
    }

    if (villeListItem.isNotEmpty) {
      // Parse <Map>List to <String>List
      villeListItem.forEach((element) {
        villeList.add(element['name']);
      });

      // Removes Duplicates Item
      duplicatesRemoved = <String>[
        ...{...villeList}
      ];
    }

    emit(FournisseurRegistrationState(field: {
      ...state.field!,
      'providerAdress': adress,
      'cities': duplicatesRemoved,
    }));
    _updateCommuneList();
  }

  void _updateCommuneList() {
    Map _adress = state.field!['providerAdress'];
    String ville = _adress['city'];

    if (ville == 'Ville') {
      _adress['town'] = 'Commune';

      emit(FournisseurRegistrationState(field: {
        ...state.field!,
        'providerAdress': _adress,
        'towns': <String>['Commune']
      }));
      return;
    }

    // Get Commune List Given By The API
    Map locationFormData = state.field!["locationFormData"];
    List data = locationFormData['towns'];
    List<String> duplicatesRemoved = <String>["Commune"];
    List<String> communeList = <String>["Commune"];
    _adress['town'] = 'Commune';
    List communeListItem = [];

    if (data.isNotEmpty) {
      communeListItem = data
          .where((commune) =>
              commune['city']['name'].toString().toLowerCase() ==
              ville.toString().toLowerCase())
          .toList();
    }

    if (communeListItem.isNotEmpty) {
      // Parse <Map>List to <String>List
      communeListItem.forEach((element) {
        communeList.add(element['name']);
      });

      // Removes Duplicates Item
      duplicatesRemoved = <String>[
        ...{...communeList}
      ];
    }

    emit(FournisseurRegistrationState(field: {
      ...state.field!,
      'providerAdress': _adress,
      'towns': duplicatesRemoved,
    }));
  }
}
