// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sigi_android/common/utils/camera.dart';
import 'package:sigi_android/features/suivi/data/suivi_local_data_provider.dart';
import 'package:sigi_android/features/suivi/data/suivi_model.dart';
import 'package:sigi_android/features/suivi/data/suivi_remote_data_provider.dart';
import 'package:sigi_android/features/suivi/logic/suivi_repository.dart';
import 'monitoring_state.dart';

class MonitoringCubit extends Cubit<MonitoringState> {
  MonitoringCubit() : super(MonitoringState(field: initialState()));
  SuiviRepository suiviRepository =
      SuiviRepository(SuiviLocalDataProvider(), SuiviRemoteDataProvider());

  void initForm() async {
    List suiviList = state.field!['suiviList'];
    emit(MonitoringState(field: {
      ...initialState()!,
      'suiviList': suiviList,
    }));
  }

  Future<void> onSendMonitoringData() async {
    emit(MonitoringState(field: {
      ...state.field!,
      'sending': true,
    }));

    print("data: ${state.field!['data'].toString()}");
    await Future.delayed(const Duration(seconds: 2));
    try {
      SuiviModel data = SuiviModel(
          state.field!['data']['text'], state.field!['data']['photos']);
      final result = await suiviRepository.addSuivi(data);

      if (result == null) {
        emit(MonitoringState(field: {
          ...state.field!,
          'sending': false,
          'status': 500,
        }));
        return;
      }

      List suiviList = [
        state.field!['data'],
        ...state.field!['suiviList'],
      ];
      emit(MonitoringState(field: {
        ...state.field!,
        'suiviList': suiviList,
        'sending': false,
        'status': 200,
      }));
      Get.offAllNamed('/suivi');
      return;
    } catch (e) {
      print('error.cubit.senddata: ${e.toString()}');
      emit(MonitoringState(field: {
        ...state.field!,
        'sending': false,
        'status': 500,
      }));
      return;
    }
  }

  void onValideImages() async {
    emit(MonitoringState(field: {
      ...state.field!,
      'showImageRequired': true,
    }));
  }

  void onDeleteImage(String? base64string) {
    try {
      List? photos = state.field!['data']['photos'];
      photos!.remove(base64string);

      Map data = state.field!['data'];
      data['photos'] = photos;

      emit(MonitoringState(field: {
        ...state.field!,
        'data': data,
      }));
    } catch (e) {
      return;
    }
  }

  Future<void> onTakePicture() async {
    XFile? imageFile = await CameraUtils().takePicture(ImageSource.camera);
    // take picture failed
    if (imageFile == null) {
      emit(MonitoringState(field: {
        ...state.field!,
        'status': 500,
      }));
      return;
    }

    Uint8List imagebytes = await imageFile.readAsBytes(); // Convert to bytes
    String base64string =
        base64.encode(imagebytes); //convert bytes to base64 string
    Map data = state.field!['data'];
    data['photos'] = [base64string, ...state.field!['data']['photos']];
    emit(MonitoringState(field: {
      ...state.field!,
      'data': data,
      'status': 200,
      'showImageRequired': false,
    }));
  }

  Future<void> onValueChange({required Map data}) async {
    emit(MonitoringState(field: {
      ...state.field!,
      'data': data,
    }));
  }
}
