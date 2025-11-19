import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/generate_batik_controller.dart';

class GenerateBatikView extends GetView<GenerateBatikController> {
  const GenerateBatikView({super.key});

  @override
  Widget build(BuildContext context) {
    final webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://genbatik.ub.ac.id/"));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Batik'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: WebViewWidget(controller: webController),
    );
  }
}
