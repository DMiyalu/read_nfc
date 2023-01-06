part of 'demande_intrant_list_cubit.dart';

class DemandeIntrantListState {
  Map? field;
  DemandeIntrantListState({@required this.field});
}

Map? initialState() {
  return {
    'data': <FundingRequest>[],
    'loading': false,
    'status': 0,
  };
}
