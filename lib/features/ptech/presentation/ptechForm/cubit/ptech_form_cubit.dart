// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/features/ptech/data/ptech_local_data_provider.dart';
import 'package:sigi_android/features/ptech/data/ptech_model.dart';
import 'package:sigi_android/features/ptech/data/ptech_remote_data_provider.dart';
import 'package:sigi_android/features/ptech/logic/ptech_repository.dart';
import 'ptech_form_state.dart';

class PtechFormCubit extends Cubit<PtechFormState> {
  PtechFormCubit() : super(PtechFormState(field: initialState()));

  PtechRepository ptechRepository = PtechRepository(
    PtechLocalDataProvider(),
    PtechRemoteDataProvider(),
  );

  Future<void> onInitForm() async {
    emit(PtechFormState(field: {
      ...initialState()!,
    }));
  }

  void onAddIntrant() {
    try {
      final List intrants = [
        ...state.field!['data']['intrants'],
        {
          "description": state.field!['data']['intrantName'],
          'name': state.field!['data']['intrantName'],
          'pricePerArea': state.field!['data']['pricePerArea'],
          'productDisplayMode': "/api/mm",
          'supplierSpecialties': state.field!['data']['specialities'],
        },
      ];

      final Map data = {
        'name': state.field!['data']['name'],
        'intrants': intrants,
        'supplierSpecialty': state.field!['data']['supplierSpecialty'],

        // refresh intrant subfields
        'intrantName': '',
        'pricePerArea': '',
        'stockageMode': '',
        'specialities': [],
      };

      emit(PtechFormState(field: {
        ...state.field!,
        'data': data,
      }));
    } catch (e) {
      print('cubit. error on add intrant: ${e.toString()}');
      rethrow;
    }
  }

  void onRemoveIntrant({required String intrantName}) {
    try {
      final List intrants = state.field!['data']['intrants'];
      // ignore: list_remove_unrelated_type
      intrants.removeWhere((intrant) {
        return intrant['intrantName'].toString().toLowerCase() ==
            intrantName.toLowerCase();
      });

      final Map data = {
        ...state.field!['data'],
        'intrants': intrants,
      };
      emit(PtechFormState(field: {
        ...state.field!,
        'data': data,
      }));
    } catch (e) {
      print('cubit. error on remove intrant: ${e.toString()}');
    }
  }

  Future<PtechModel?>? onSendPtech() async {
    emit(PtechFormState(field: {
      ...state.field!,
      'sending': true,
      'status': 0,
      'showValidation': false,
    }));

    if (state.field!['data']['intrants'].isEmpty) {
      emit(PtechFormState(field: {
        ...state.field!,
        'sending': false,
        'status': 0,
        'showValidation': true,
      }));
      return null;
    }

    try {
      List? intrants = state.field!['data']['intrants'];
      List intrantsWithIri = [];

      if (intrants!.isEmpty) {
        return null;
      } else {
        for (Map element in intrants) {
          Map intrant = {
            ...element,
            'productDisplayMode': "/api/mm",
            'supplierSpecialties': "/api/lll",
            'pricePerArea': int.parse(element["pricePerArea"])
          };
          //'productDisplayMode': getIri(intrants[i]['productDisplayMode']),
          // 'supplierSpecialties': getIri(intrants[i]['supplierSpecialties'][0]),
          intrantsWithIri.add(intrant);
        }
      }
      final PtechModel ptech = PtechModel(
        state.field!['data']['name'],
        intrantsWithIri,
      );
      final result = await ptechRepository.addPtech(ptech);
      if (result == null) {
        emit(PtechFormState(field: {
          ...state.field!,
          'sending': false,
          'status': 500,
        }));
        return null;
      }
      emit(PtechFormState(field: {
        ...state.field!,
        'sending': false,
        'status': 200,
      }));
      return ptech;
    } catch (e) {
      print('error on form cubit: ${e.toString()}');
      emit(PtechFormState(field: {
        ...state.field!,
        'sending': false,
        'status': 500,
      }));
      return null;
    }
  }

  String getIri(String value) {
    return "/api/mm";
  }

  Future<void> onFieldChange(Map data) async {
    emit(PtechFormState(field: {
      ...state.field!,
      'data': data,
      'showValidation': false,
    }));
  }
}
