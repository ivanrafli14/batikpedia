import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/generate_batik_controller.dart';

class GenerateBatikView extends GetView<GenerateBatikController> {
  const GenerateBatikView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GenerateBatikView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GenerateBatikView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
