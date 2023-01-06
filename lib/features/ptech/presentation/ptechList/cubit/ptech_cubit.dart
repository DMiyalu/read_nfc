// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/features/ptech/data/ptech_local_data_provider.dart';
import 'package:sigi_android/features/ptech/data/ptech_model.dart';
import 'package:sigi_android/features/ptech/data/ptech_remote_data_provider.dart';
import 'package:sigi_android/features/ptech/logic/ptech_repository.dart';
import 'ptech_state.dart';

class PtechCubit extends Cubit<PtechState> {
  PtechCubit() : super(PtechState(field: initialState()));

  PtechRepository ptechRepository = PtechRepository(
    PtechLocalDataProvider(),
    PtechRemoteDataProvider(),
  );

  Future<void> onFetchPtechs() async {
    print('on fetch ptechlist');
    emit(PtechState(field: {
      ...state.field!,
      'loading': true,
      'status': 0,
    }));

    await Future.delayed(const Duration(seconds: 5));
    try {
      final List<PtechModel>? result = await ptechRepository.fecthPtechs();
      if (result == null) {
        emit(PtechState(field: {
          ...state.field!,
          'loading': false,
          'status': 500,
        }));
        return;
      }

      emit(PtechState(field: {
        ...state.field!,
        'ptechList': result,
        'loading': false,
        'status': 200,
      }));
    } catch (e) {
      print('error ptech cubit: ${e.toString()}');
      emit(PtechState(field: {
        ...state.field!,
        'loading': false,
        'status': 500,
      }));
    }
  }

  void onRefreshPtechs(PtechModel ptech) {
    final List<PtechModel?> ptechs = [
      ptech,
      ...state.field!['ptechList'],
    ];

    print("1----------result ptech ${ptech.intrants}");
    print("2----------result ptech ${ptech.name}");
    // return;

    emit(PtechState(field: {
      ...state.field!,
      'ptechList': ptechs,
    }));
  }
}
