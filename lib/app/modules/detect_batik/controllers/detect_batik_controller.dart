import 'dart:ui';

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
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: const Color(0xFF0B506C),
          toolbarWidgetColor: Colors.white,
          hideBottomControls: false,
          lockAspectRatio: false,
          activeControlsWidgetColor: const Color(0xFF0B506C),
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: false,
        ),
      ],
    );

    if (croppedFile != null) {
      croppedImagePath.value = croppedFile.path;

      Get.snackbar(
        'Image Ready',
        'Cropped successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );

      // TODO: Kirim ke model AI deteksi batik kamu
      // misalnya:
      // await detectBatik(File(croppedFile.path));
    } else {
      Get.snackbar(
        'Cancelled',
        'Cropping cancelled',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

