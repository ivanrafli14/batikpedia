import 'dart:ui';

import 'package:batikpedia/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class DetectBatikController extends GetxController {
  //TODO: Implement DetectBatikController
  final ImagePicker _picker = ImagePicker();
  final croppedImagePath = RxnString();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> captureImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      await _cropImage(photo.path);
    }
  }

  Future<void> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await _cropImage(image.path);

    }
  }

  Future<void> _cropImage(String imagePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressQuality: 90,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1), // 🔥 Kunci 1:1
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: const Color(0xFF0B506C),
          toolbarWidgetColor: Colors.white,
          hideBottomControls: true,
          lockAspectRatio: true,
          activeControlsWidgetColor: const Color(0xFF0B506C),
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: true,
        ),
      ],
    );

    if (croppedFile != null) {
      croppedImagePath.value = croppedFile.path;

      // Get.snackbar(
      //   'Image Ready',
      //   'Cropped successfully!',
      //   snackPosition: SnackPosition.BOTTOM,
      // );

      Get.toNamed(Routes.PREDICTED_BATIK, arguments: {
        'imagePath': croppedFile.path,
      });
      
    } else {
      Get.snackbar(
        'Cancelled',
        'Cropping cancelled',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

