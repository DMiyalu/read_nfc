part of 'nfc_read_cubit.dart';

class NfcReadState {
  Map? field;
  NfcReadState({@required this.field});
}

Map initialState() {
  return {
    'onReadStatus': {
      'during': false,
      'code': 0,
      'data': {},
    },
  };
}
