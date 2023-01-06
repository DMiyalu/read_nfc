import 'package:sigi_android/features/ptech/data/ptech_model.dart';

class PtechState {
  Map? field;
  PtechState({this.field});
}

Map? initialState() {
  return {
    'ptechList': <PtechModel>[],
    'status': 0,
    'loading': false,
  };
}
