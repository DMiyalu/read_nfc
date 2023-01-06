class PtechFormState {
  Map? field;
  PtechFormState({this.field});
}

Map? initialState() {
  return {
    'data': {
      'name': '',
      'intrants': [],
      'intrantName': '',
      'pricePerArea': '',
      'stockageMode': '',
      'specialities': [],
      'supplierSpecialty': {
        'fertilisant': false,
        'produitPhytoSanitaire': false,
        'produiVeterinaire': false,
        'semences': false,
        'services': false,
        'autre': false,
      },
    },
    // 'specialitiesListData': [],
    'status': 0,
    'sending': false,
    'showValidation': false,
  };
}
