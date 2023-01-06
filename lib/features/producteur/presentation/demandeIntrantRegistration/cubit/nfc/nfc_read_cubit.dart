import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'nfc_read_state.dart';

class NfcReadCubit extends Cubit<NfcReadState> {
  NfcReadCubit() : super(NfcReadState(field: initialState()));

  Future<void> clearNfcData() async {
    // await _nfcManagement.clearTag();
    emit(NfcReadState(field: initialState()));
  }

  Future<void> onStartNfcReading() async {
    print("get read 2");

    Map _status = {
      'code': 0,
      'during': true,
    };
    emit(NfcReadState(field: {
      ...initialState(),
      'onReadStatus': _status,
    }));
    await Future.delayed(const Duration(seconds: 3));
  }

  Future<void> onStopNfcReading(String result) async {
    print("get read 3");

    if (result == "500") {
      Map _status = {
        'code': 500,
        'during': false,
        'message': "Une erreur est survenue",
        "data": null,
      };
      emit(NfcReadState(field: {
        ...initialState(),
        'onReadStatus': _status,
      }));
      return;
    }

    if (result == "404") {
      Map _status = {
        'code': 404,
        'during': false,
        'message': "Pas de contenu sur la carte",
        "data": null,
      };
      emit(NfcReadState(field: {
        ...initialState(),
        'onReadStatus': _status,
      }));
      return;
    }

    // Read NFC Success
    Map _status = {
      'code': 200,
      'during': false,
      'data': jsonDecode(result),
    };
    emit(NfcReadState(field: {
      ...initialState(),
      'onReadStatus': _status,
    }));
    return;
  }
}
