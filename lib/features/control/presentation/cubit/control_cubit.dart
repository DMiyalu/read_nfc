import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sigi_android/common/utils/camera.dart';
import 'control_state.dart';

class ControlCubit extends Cubit<ControlState> {
  ControlCubit() : super(ControlState(field: initialState()));

  void initForm() async {
    List _controlList = state.field!['controlList'];
    emit(ControlState(field: {
      ...initialState()!,
      'controlList': _controlList,
    }));
  }

  Future<void> onSendControlData() async {
    emit(ControlState(field: {
      ...state.field!,
      'sending': true,
    }));

    print("data: ${state.field!['data'].toString()}");
    await Future.delayed(const Duration(seconds: 2));
    List _controlList = [
      state.field!['data'],
      ...state.field!['controlList'],
    ];
    emit(ControlState(field: {
      ...state.field!,
      'controlList': _controlList,
      'sending': false,
      'status': 200,
    }));
    Get.offAllNamed('/control');
  }

  void onValideImages() async {
    emit(ControlState(field: {
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

      emit(ControlState(field: {
        ...state.field!,
        'data': data,
      }));
    } catch (e) {
      return;
    }
  }

  Future<void> onTakePicture() async {
    XFile? _imageFile = await CameraUtils().takePicture(ImageSource.camera);
    // take picture failed
    if (_imageFile == null) {
      emit(ControlState(field: {
        ...state.field!,
        'status': 500,
      }));
      return;
    }

    Uint8List imagebytes = await _imageFile.readAsBytes(); // Convert to bytes
    String base64string =
        base64.encode(imagebytes); //convert bytes to base64 string
    Map data = state.field!['data'];
    data['photos'] = [base64string, ...state.field!['data']['photos']];
    emit(ControlState(field: {
      ...state.field!,
      'data': data,
      'status': 200,
      'showImageRequired': false,
    }));
  }

  Future<void> onValueChange({required Map data}) async {
    emit(ControlState(field: {
      ...state.field!,
      'data': data,
    }));
  }
}
