import 'package:sigi_android/common/platform/connectivity_manager.dart';
import 'package:sigi_android/features/fournisseur/data/fournisseur_model.dart';
// import 'package:sigi_android/features/fournisseur/presentation/fournisseurList/fournisseur_list.dart';
import '../data/fournisseur_local_data_provider.dart';
import '../data/fournisseur_remote_data_provider.dart';

class FournisseurRepository {
  FournisseurRepository(
    this.fournisseurLocalDataProvider,
    this.fournisseurRemoteDataProvider,
  );

  final FournisseurLocalDataProvider fournisseurLocalDataProvider;
  final FournisseurRemoteDataProvider fournisseurRemoteDataProvider;

  static Future<String> getIri({required List data, required String value}) async {
    final List result =
        data.where((element) => element["name"] == value).toList();

    if (result.isNotEmpty) {
      print("iri pour $value trouvé: ${result[0]['iri'].toString()}");
      return result[0]['iri'];
    }

    print("iri pour $value non trouvé");
    return "";
  }

  Future<List<Fournisseur>?>? fetchFournisseurs() async {
    print('** fetch fournisseur data');
    if (await ConnectivityManager.isConnected) {
      try {
        final List? fournisseurs =
            await fournisseurRemoteDataProvider.fetchFournisseur();
        List<Fournisseur>? fournisseursList = <Fournisseur>[];
        if (fournisseurs!.isNotEmpty) {
          for (int i = 0; i < fournisseurs.length; i++) {
            // print('** get fournisseur. value $i');
            final Map adress = {
              'town': fournisseurs[i]['town'],
              'addressLine': fournisseurs[i]['addressLine'],
            };
            final List? taxeNames = fournisseurs[i]['taxeNames'];
            final Map managementAndOperation = {
              'legalType': fournisseurs[i]['isRegistered'],
              'legalStatus': fournisseurs[i]['legalStatus']['name'],
              'haveConstitutiveAct': fournisseurs[i]['haveConstitutiveAct'],
              'haveInternalRegulations': fournisseurs[i]
                  ['haveInternalRegulations'],
              'haveAdministrationProceduresManual': fournisseurs[i]
                  ['haveAdministrationProceduresManual'],
              'haveAccounting': fournisseurs[i]['haveAccounting'],
              'documentType': fournisseurs[i]['documentType'],
              'documentId': fournisseurs[i]['documentId'],
              'documentPhoto': fournisseurs[i]['documentPhoto'],
              'countVolunteerStaff': fournisseurs[i]['countVolunteerStaff'],
              'countStaffPaid': fournisseurs[i]['countStaffPaid'],
              'yearFirstTaxPayment': fournisseurs[i]['yearFirstTaxPayment'],
              'taxeNames': fournisseurs[i]['taxeNames'],
              'amountPaidMonth': fournisseurs[i]['amountPaidMonth'],
              'amountPaidQuarter': fournisseurs[i]['amountPaidQuarter'],
              'amountPaidAnnually': fournisseurs[i]['amountPaidAnnually'],
              'organizationCert': fournisseurs[i]['organizationCert'],
              'organizationCertScope': fournisseurs[i]['organizationCertScope'],
              'standard': fournisseurs[i]['standard'],
              'useMobileBank': fournisseurs[i]['useMobileBank'],
              'useCommercialBank': fournisseurs[i]['useCommercialBank'],
              'useMicrofinance': fournisseurs[i]['useMicrofinance'],
              'haveFinanceProceduresManual': fournisseurs[i]
                  ['haveFinanceProceduresManual'],
              'yearOfCertification': fournisseurs[i]['yearOfCertification'],
              'haveManagementConsultancy': fournisseurs[i]
                  ['haveManagementConsultancy'],
              'personnel': {
                'nombreVolontaires': fournisseurs[i]['countVolunteerStaff'],
                'nombreStaff': fournisseurs[i]['countStaffPaid'],
              },
              'turnover': {
                'interval': fournisseurs[i]['turnover']['wording'],
                'net': '',
              },
              'fisc': {
                'taxe': false,
                'yearOld': fournisseurs[i]['yearFirstTaxPayment'],
                'taxeName': (taxeNames!.isNotEmpty) ? taxeNames[0] : '',
                'amountPaidMonth': fournisseurs[i]['amountPaidMonth'],
                'amountPaidQuarter': fournisseurs[i]['amountPaidQuarter'],
                'amountPaidAnnually': fournisseurs[i]['amountPaidAnnually'],
              },
              'certification': {
                'certifie': fournisseurs[i]['organizationCert'],
                'organisation': '',
                'norme': '',
              },
            };

            Fournisseur fournisseur = Fournisseur(
              email: fournisseurs[i]['email'] ?? '',
              name: fournisseurs[i]['name'] ?? '',
              shortName: fournisseurs[i]['shortName'] ?? '',
              managerName: fournisseurs[i]['managerName'] ?? '',
              phone: fournisseurs[i]['phone'],
              photo: fournisseurs[i]['photo'],
              nui: fournisseurs[i]['nui'],
              createdAt: fournisseurs[i]['creationYear'].toString(),
              adress: adress,
              managementAndOperation: managementAndOperation,
              // payment: payment,
              // supplierCapacity: capacity,
            );
            fournisseursList.add(fournisseur);
          }
        }

        print('** fetch succes. ${fournisseursList.length} items.');
        fournisseurLocalDataProvider.cacheFournisseurs(fournisseursList);
        return fournisseursList;
      } catch (e) {
        print("fetch fournisseur error: ${e.toString()}");
        return null;
        // return ServerException()();
      }
    } else {
      return fournisseurLocalDataProvider.fetchFournisseur();
    }
  }

  Future<Fournisseur?> addFournisseur(Fournisseur data) async {
    if (await ConnectivityManager.isConnected) {
      print('****connected. Send fournisseur');
      try {
        final Fournisseur? fournisseur =
            await fournisseurRemoteDataProvider.addFournisseur(data);
        if (fournisseur != null) {
          fournisseurLocalDataProvider.cacheFournisseur(fournisseur);
          return fournisseur;
        }
        return fournisseurLocalDataProvider.addFournisseur(data);
      } catch (e) {
        print(e);
        return null;
        // return ServerException()();
      }
    } else {
      print('****not connected. Save on local');
      return fournisseurLocalDataProvider.addFournisseur(data);
    }
  }

  Future<Fournisseur?> getFournisseur(String id) async {
    if (await ConnectivityManager.isConnected) {
      try {
        final Fournisseur? fournisseur =
            await fournisseurRemoteDataProvider.getFournisseur(id);
        // cache product
        fournisseurLocalDataProvider.cacheFournisseur(fournisseur);
        return fournisseur;
      } catch (e) {
        print(e);
        return null;
        // return ServerException()();
      }
    } else {
      return fournisseurLocalDataProvider.getFournisseur(id);
    }
  }
}
