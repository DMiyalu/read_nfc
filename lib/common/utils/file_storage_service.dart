import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';

class FileStorageService {
  static Future<String> getFilePath(
      {required String filePath,
      String? imageBase64,
      String? fileName,
      String? directory}) async {
    final File file = File.fromUri(Uri.parse(filePath));
    if (file.existsSync()) {
      print('file exist: $file');
      return filePath;
    }

    print('file not found, create new file');

    Map saveStatus = await saveImageOnStorage(
      imageBase64: imageBase64!,
      fileName: fileName!,
      directory: directory!,
    );

    if (saveStatus['code'] == 200) {
      print('file has been created');
      return saveStatus['path'];
    }

    print('create new file failed');
    return "";
  }

  static Future<Map> saveImageOnStorage(
      {required String imageBase64,
      required String fileName,
      required String directory}) async {
    Uint8List bytes = base64Decode(imageBase64);
    try {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      var dir = await Directory('${appDocDirectory.path}/$directory')
          .create(recursive: true);
      File file = await File('${dir.path}/$fileName').create(recursive: true);

      Im.Image? image = Im.decodeImage(bytes);
      // await file.writeAsBytes(_bytes);
      await file.writeAsBytes(Im.encodePng(image!));

      Map status = {
        'code': 200,
        'path': file.path,
      };
      return status;
    } catch (error) {
      Map status = {
        'code': 400,
        'message': 'Error on save file on local storage: ${error.toString()}',
      };
      return status;
    }
  }
}