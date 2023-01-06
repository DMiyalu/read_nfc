// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sigi_android/common/utils/camera.dart';
import 'supervisor_state.dart';

class SupervisorCubit extends Cubit<SupervisorState> {
  SupervisorCubit() : super(SupervisorState(field: initialState()));

  void initForm() async {
    List supervisions = state.field!['supervisionList'];
    emit(SupervisorState(field: {
      ...initialState()!,
      'supervisionList': supervisions,
    }));
  }

  Future<void> onSendSupervisionData() async {
    emit(SupervisorState(field: {
      ...state.field!,
      'sending': true,
    }));

    print("data: ${state.field!['data'].toString()}");
    await Future.delayed(const Duration(seconds: 1));
    List supervisionList = [
      state.field!['data'],
      ...state.field!['supervisionList'],
    ];
    emit(SupervisorState(field: {
      ...state.field!,
      'supervisionList': supervisionList,
      'sending': false,
      'status': 200,
    }));
    Get.offAllNamed('/supervision');
    return;
  }

  void onValideImages() async {
    emit(SupervisorState(field: {
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

      emit(SupervisorState(field: {
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
      emit(SupervisorState(field: {
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
    emit(SupervisorState(field: {
      ...state.field!,
      'data': data,
      'status': 200,
      'showImageRequired': false,
    }));
  }

  Future<void> onValueChange({required Map data}) async {
    emit(SupervisorState(field: {
      ...state.field!,
      'data': data,
    }));
  }
}
