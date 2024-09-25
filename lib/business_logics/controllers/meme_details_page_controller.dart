import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/files.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image/image.dart' as img;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';

class MemeDetailsController extends GetxController {
  var editedImage= File('').obs;

  Future<File> _resizeImage(File imageFile) async {
    final originalImage = img.decodeImage(imageFile.readAsBytesSync());
    final resizedImage = img.copyResize(originalImage!, width: 1080); // Resize to 1080px width
    final resizedFilePath = imageFile.path.replaceAll('.jpg', '_resized.jpg');
    final resizedFile = File(resizedFilePath);
    resizedFile.writeAsBytesSync(img.encodeJpg(resizedImage));
    return resizedFile;
  }

  Future<void> cropImage(String url) async {
    try {
      //Download the image from the URL and save it as a local file
      final response = await http.get(Uri.parse(url));
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/temp_meme.jpg';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      // Check if the file exists
      print('File exists at path: $filePath');
      if (!await file.exists()) {
        print('File not found at $filePath');
        return;
      }

      // Resize the image if it is too large
      final resizedFile = await _resizeImage(file);

      //  Use the local file path with ImageCropper
      var croppedFile = await ImageCropper().cropImage(
        sourcePath: resizedFile.path,  // Use the local file path
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.original,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Meme',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Crop Meme',
          ),
        ],
      );

      //  Update the state with the cropped file
      if (croppedFile != null) {
          editedImage.value = File(croppedFile.path);
      }
    } catch (e) {
      print('Error cropping image: $e');
    }
  }


  Future<void> rotateImage() async {
    if (editedImage.value.path != '') {
      var decodedImage = img.decodeImage(editedImage.value!.readAsBytesSync());
      var rotatedImage = img.copyRotate(decodedImage!,  angle: 90);
      var tempDir = await getTemporaryDirectory();
      var filePath = '${tempDir.path}/rotated_meme.png';
      var newImage = File(filePath)..writeAsBytesSync(img.encodePng(rotatedImage));
      editedImage.value = newImage;

    }
  }

  Future<void> saveImage() async {
    if (editedImage.value.path != '') {
      final result = await GallerySaver.saveImage(editedImage.value!.path, albumName: 'Memes');
      if (result!) {
        Get.snackbar(
            'Success',
            'Image saved to gallery',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
        );
      }
    }
  }

}
