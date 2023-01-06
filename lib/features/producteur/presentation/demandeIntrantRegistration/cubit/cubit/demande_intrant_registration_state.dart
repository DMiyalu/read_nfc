part of 'demande_intrant_registration_cubit.dart';

class DemandeIntrantRegistrationState {
  Map? field;
  DemandeIntrantRegistrationState({@required this.field});
}

Map? initialState() {
  return {
    'step': 0,
    'title': "",
    'data': _data,
    'sending': false,
  };
}

Map _data = {
  'productorName': '',
  'productorNUI': '',
  'ptech': '',
  'longueur': '0.0',
  'largeur': '0.0',
  'surface': '0.0',
  'actionArea': [],
  'inputNeedImplementationPtechs': [],
  'fournisseur': '',
  'zoneDaction': '',
  'territoire': '',
  'jwtNFC': '',
};
