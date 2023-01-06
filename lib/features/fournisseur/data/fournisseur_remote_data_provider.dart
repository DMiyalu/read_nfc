// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:sigi_android/features/authentication/database/save_token.dart';
import 'package:sigi_android/features/authentication/logic/authentication_provider.dart';
import 'package:sigi_android/features/fournisseur/logic/fournisseur_repository.dart';
import 'package:sigi_android/features/synchronization/download/logic/ptech_repository.dart';
import '../../../common/utils/file_storage_service.dart';
import 'fournisseur_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;

class FournisseurRemoteDataProvider {
  final String baseURL = "http://supplier.baadhiteam.com/api/suppliers";

  Future<List?>? fetchFournisseur() async {
    var tk = await SaveToken.getCredentials();
    var value = tk!["data"];
    var token = value["access_token"];
    try {
      final response = await http.get(
        Uri.parse(baseURL),
        headers: {
          "Authorization": "Bearer $toke                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 201 ||
          response.statusCode == 200 ||
          response.statusCode == 204) {
        return jsonDecode(response.body) as List;
      }

      if (response.statusCode == 401) {
        final Map? userInfos = await SaveToken.getUserProfile();
        print("*** refresh token: userInfos: ${userInfos.toString()}");
        final Map? newToken = await AuthenticationProvider.getUserToken(user: {
          'email': userInfos!['email'],
          'password': userInfos['password']
        });
        SaveToken.saveToken(token: newToken);
        fetchFournisseur();
      }

      print(
          "Fetch fournisseur failled: ${jsonDecode(response.body).toString()}");
      return null;
    } catch (e) {
      print("Error on fetch fournisseur: ${e.toString()}");
    }
    return null;
  }

  Future<Fournisseur?> addFournisseur(Fournisseur providerData) async {
    // ignore: avoidprint
    print(
        '***Send fournisseur on remote db: ${providerData.toJson().toString()}');
    try {
      var postUri = Uri.parse(baseURL);
      var request = await _getMultipartFormRequest(
          postUri: postUri, providerData: providerData.toJson());

      // print('request: $request');
      // return null;

      var streamResponse = await request.send();
      var response = await http.Response.fromStream(streamResponse);
      print('**** response: ${response.body.toString()}');
      print('**** statusCode server: ${response.statusCode.toString()}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        print("send multipart success ${response.body.toString()}");
        return providerData;
      } else {
        print("send multipart failed: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error on send fournisseur. Remote data provider: ${e.toString()}");
      return null;
    }
  }

  Future<Fournisseur>? getFournisseur(String id) {
    return null;
  }

  Future<Map> saveImageOnStorage(
      {required String imageBase64,
      required String fileName,
      required String directory}) async {
    Uint8List bytes = base64Decode(imageBase64);
    try {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      var dir = await Directory('${appDocDirectory.path}/$directory')
          .create(recursive: true);
      File file = await File('${dir.path}/$fileName').create(recursive: true);

      Im.Image? image = Im.decodeImage(bytes);
      // await file.writeAsBytes(_bytes);
      await file.writeAsBytes(Im.encodePng(image!));

      Map status = {
        'code': 200,
        'path': file.path,
      };
      return status;
    } catch (error) {
      Map status = {
        'code': 400,
        'message': 'Error on save file on local storage: ${error.toString()}',
      };
      return status;
    }
  }

  Future<String> getFilePath(
      {required String filePath,
      String? imageBase64,
      String? fileName,
      String? directory}) async {
    File file = File.fromUri(Uri.parse(filePath));
    if (file.existsSync()) {
      print('file exist: $file');
      return filePath;
    }

    print('file not found, create new file');

    Map saveStatus = await saveImageOnStorage(
      imageBase64: imageBase64!,
      fileName: fileName!,
      directory: directory!,
    );

    if (saveStatus['code'] == 200) {
      print('file has been created');
      return saveStatus['path'];
    }

    print('create new file failed');
    return "";
  }

  static Future<http.MultipartRequest> _getMultipartFormRequest(
      {required Uri postUri, required Map providerData}) async {
    // get token from database
    var tk = await SaveToken.getCredentials();
    var value = tk!["data"];
    var token = value["access_token"];
    print('formatMultipart. token: $token');
    final Map? formData = await PtechRepository.getStaticFormData();

    // A. Personnal Identity
    // Provider Photo
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    var logoPath = await Directory('${appDocDirectory.path}/images/logo')
        .create(recursive: true);
    String providerLogoPath = '${logoPath.path}/${providerData['nui']}.png';
    String providerPhoto = await FileStorageService.getFilePath(
      filePath: providerLogoPath,
      directory: 'images/logo',
      fileName: '${providerData['nui']}.png',
      imageBase64: providerData['photo'],
    );

    // Document Photo
    // Directory appDocDirectory = await getApplicationDocumentsDirectory();
    var documentPhoto =
        await Directory('${appDocDirectory.path}/images/documents')
            .create(recursive: true);
    String documentPath = '${documentPhoto.path}/${providerData['nui']}.png';
    String documentPhotoPath = await FileStorageService.getFilePath(
      filePath: documentPath,
      directory: 'images/documents',
      fileName: '${providerData['nui']}.png',
      imageBase64: providerData['managementAndOperation']['organeDeGestion']
          ['photoRCCM'],
    );

    // Create Mutltipart Request (With Json Object)
    http.MultipartRequest request = http.MultipartRequest("POST", postUri);
    request.headers.addAll({
      "Authorization": "Bearer $token",
      "Content-Type": "multipart/form-data",
      "Accept": "application/json"
    });
    // A. Personnal Identity
    request.fields['name'] = providerData['name'];
    request.fields['email'] = providerData['email'];
    request.fields['shortName'] = providerData['shortName'];
    request.fields['phone'] = providerData['phone'];
    request.fields['nui'] = providerData['nui'];
    request.fields['managerName'] = providerData['managerName'];

    request.fields['businessNetwork'] = await FournisseurRepository.getIri(
        data: formData!['businessNetwork'],
        value: providerData['supplierCapacity']['businessNetwork']['which']);
    // "/api/peasant_organization_p_n_d_as/1 \\";
    // providerData['supplierCapacity']['businessNetwork']['which']
    request.fields['isRegistered'] = providerData['managementAndOperation']
                    ['legalType']
                .toString()
                .toLowerCase() ==
            'enregistré'
        ? '1'
        : '0';
    request.fields['legalStatus'] = await FournisseurRepository.getIri(
        data: formData['legalStatus'],
        value: providerData['managementAndOperation']['legalStatus']);
    // "/api/type_organisation_suppliers/1 \\";
    // providerData['managementAndOperation']['legalStatus']
    request.fields['turnover'] = await FournisseurRepository.getIri(
        data: formData['turnover'],
        value: providerData['managementAndOperation']['turnover']['net']);
    // "/api/turnover_ranges/1 \\";
    // providerData['managementAndOperation']['turnover']['net']
    request.fields['haveConstitutiveAct'] =
        providerData['managementAndOperation']['organeDeGestion']
                ['acteConstitutif']
            ? '1'
            : '0';
    request.fields['haveInternalRegulations'] =
        providerData['managementAndOperation']['organeDeGestion']
                ['reglementInterieur']
            ? '1'
            : '0';
    request.fields['haveAdministrationProceduresManual'] =
        providerData['managementAndOperation']['organeDeGestion']
                ['manuelDeProcedure']
            ? '1'
            : '0';
    request.fields['haveAccounting'] = providerData['managementAndOperation']
            ['organeDeGestion']['comptabilité']
        ? '1'
        : '0';
    request.fields['haveFinanceProceduresManual'] =
        providerData['managementAndOperation']['organeDeGestion']
                ['financeProceduresManual']
            ? '1'
            : '0';
    request.fields['documentType'] = providerData['managementAndOperation']
        ['organeDeGestion']['documentType'];
    request.fields['documentId'] =
        providerData['managementAndOperation']['organeDeGestion']['documentId'];

    // Document Photo
    if (documentPhotoPath != "") {
      request.files.add(await http.MultipartFile.fromPath(
        'documentPhoto',
        documentPhotoPath,
        contentType: MediaType('image', 'png'),
      ));
    }

    request.fields['countVolunteerStaff'] =
        providerData['managementAndOperation']['personnel']['nombreVolontaires']
            .toString();
    request.fields['countStaffPaid'] = providerData['managementAndOperation']
            ['personnel']['nombreStaff']
        .toString();
    request.fields['taxeNames[0]'] =
        providerData['managementAndOperation']['fisc']['taxeName'];
    request.fields['useMobileBank'] =
        providerData['payment']['useMobileBank'] ? '1' : '0';
    request.fields['useCommercialBank'] =
        providerData['payment']['useCommercialBank'] ? '1' : '0';
    request.fields['useMicrofinance'] =
        providerData['payment']['useMicrofinance'] ? '1' : '0';
    request.fields['productDisplayMode'] = await FournisseurRepository.getIri(
        data: formData['productDisplayMode'],
        value: providerData['supplierCapacity']['storageMode']);
    // "/api/product_show_deposits/1 \\";
    // providerData['supplierCapacity']['storageMode']
    request.fields['depositLength'] =
        providerData['supplierCapacity']['area']['length'].toString();
    request.fields['depositWidth'] =
        providerData['supplierCapacity']['area']['lenght'].toString();
    request.fields['town'] = "/api/towns/1 \\";
    // providerData['adress']['town']
    request.fields['addressLine'] =
        providerData['adress']['addressLine'] ?? "Adresse non renseignée";
    request.fields['yearFirstTaxPayment'] =
        providerData['managementAndOperation']['fisc']['yearOld'];
    request.fields['standard'] =
        providerData['managementAndOperation']['certification']['norme'];
    request.fields['organisationScope'] = '';

    // List SupplierSpecialities
    List supplierSpecialities =
        providerData['supplierCapacity']['supplierSpecialtyList'];
    if (supplierSpecialities.isNotEmpty) {
      for (int i = 0; i < supplierSpecialities.length - 1; i++) {
        request.fields['supplierSpecialties[$i]'] =
            await FournisseurRepository.getIri(
                data: formData['supplierSpecialties'],
                value: supplierSpecialities[i]);
        // "/api/supplier_specialities/1' \\";
      }
    }

    request.fields['haveManagementConsultancy'] = ''; // TODO: Complete This
    request.fields['addressLine'] = providerData['adress']['addressLine'];
    request.fields['creationYear'] = providerData['createdAt'];

    // Provider Photo
    if (providerPhoto != "") {
      request.files.add(await http.MultipartFile.fromPath(
        'photo',
        providerPhoto,
        contentType: MediaType('image', 'png'),
      ));
    }
    return request;
  }
}
