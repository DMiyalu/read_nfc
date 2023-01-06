import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CameraUtils {
  Future<XFile?>? takePicture(ImageSource source) async {
    print('****on take picture');
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? photo = await _picker.pickImage(
          source: source, maxHeight: 900, maxWidth: 900);
      print('*** take photo  build successfull');
      return photo;
    } catch (error) {
      print('error: ${error.toString()}');
      return null;
    }
  }

  Future<CroppedFile?>? croppeImageFile(
      {required XFile imageFile, required bool fixedRatio}) async {
    print('****cropp image file');
    CroppedFile? _croppedFile;
    try {
      ImageCropper _imageCropper = ImageCropper();

      if (fixedRatio) {
        _croppedFile = await _imageCropper.cropImage(
          sourcePath: imageFile.path,
          cropStyle: CropStyle.rectangle,
          aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
        );
        return _croppedFile;
      } else {
        // Crop(
        //     image: await imageFile.readAsBytes(),
        //     controller: _controller,
        //     onCropped: (image) async {
        //       // do something with image data
        //       _croppedFile = await ImageCropper();
        //     });

        _croppedFile =
            await ImageCropper().cropImage(sourcePath: imageFile.path);
        // _croppedFile = await _imageCropper.cropImage(
        //   sourcePath: imageFile.path,
        //   cropStyle: CropStyle.rectangle,
        //   // aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 4),
        // );

        return _croppedFile;
      }
    } catch (error) {
      return null;
    }
  }
}
