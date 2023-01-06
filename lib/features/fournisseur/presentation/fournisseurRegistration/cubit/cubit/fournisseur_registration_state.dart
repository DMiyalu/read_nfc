part of 'fournisseur_registration_cubit.dart';

class FournisseurRegistrationState {
  Map? field;
  FournisseurRegistrationState({@required this.field});
}

Map? initialState() {
  return {
    'step': 0,
    'title': "",
    'providerIdentity': _providerIdentity,
    'providerAdress': _providerAdress,
    'providerManagement': _providerManagement,
    'providerPayment': _providerPayment,
    'providerCapacity': _providerCapacity,
    'providerPhotoStatus': 0,
    'providerManagementPhotoStatus': 0,
    'sending': false,
    'error': false,

    // Ptech Form Data
    'businessNetwork': <String>['Organisation d\'affiliation'],
    'legalStatus': <String>[],
    'turnOver': <String>[],
    'productDisplayMode': <String>[],
    'supplierSpecialties': <String>[],

    // Location
    'province': <String>['Province'],
    'cities': <String>['Ville'],
    'territories': <String>['Territoire'],
    'sectors': <String>['Secteur'],
    'towns': <String>['Commune'],

    // Static Form Data
    'ptechFormData': {},
    'locationFormData': {},
  };
}

Map _providerCapacity = {
  'area': {
    'length': 0.0,
    'lenght': 0.0,
    'totalArea': 0.0,
  },
  'storageMode': '',
  'supplierSpecialty': {
    'fertilisant': false,
    'produitPhytoSanitaire': false,
    'produiVeterinaire': false,
    'semences': false,
    'services': false,
    'autre': false,
  },
  'supplierSpecialtyList': [],
  'businessNetwork': {
    "affiliatedAtOP": false,
    "which": "",
  },
};

Map _providerPayment = {
  'typeOfBank': '',
  'useMobileBank': false,
  'useCommercialBank': false,
  'useMicrofinance': false,
  'accountNumber': '',
  'accountName': '',
};

Map _providerIdentity = {
  'fullName': '',
  'shortName': '',
  'createdAt': '',
  'phone': '',
  'email': '',
  'nui': '',
  'managerName': '',
  'photo': '',
};

Map _providerAdress = {
  'province': '',
  'city': '',
  'town': '',
  'district': '',
  'street': '',
  'addressLine': '',
  'altitude': '',
  'longitude': '',
  'latitude': '',
};

Map _providerManagement = {
  'legalType': '',
  'legalStatus': '',
  'organeDeGestion': {
    'acteConstitutif': false,
    'reglementInterieur': false,
    'manuelDeProcedure': false,
    'comptabilité': false,
    'photoRCCM': '',
    'financeProceduresManual': false,
    'documentType': 'RCCM',
    'documentId': '*id',
  },
  'personnel': {
    'nombreVolontaires': 0,
    'nombreStaff': 0,
  },
  'turnover': {
    'interval': '',
    'net': '',
  },
  'fisc': {
    'taxe': false,
    'yearOld': '0',
    'taxeName': '',
    'amountPaidMonth': '0',
    'amountPaidQuarter': '0',
    'amountPaidAnnually': '0',
  },
  'certification': {
    'certifie': false,
    'organisation': '',
    'norme': '',
  },
};
