import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/predicted_batik_controller.dart';

class PredictedBatikView extends GetView<PredictedBatikController> {
  const PredictedBatikView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Recognize Batik',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Obx(() {
        final result = controller.aiResult.value;

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🖼 Gambar Batik (selalu tampil)
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.9),
                      builder: (_) => GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            PhotoView(
                              backgroundDecoration:
                              const BoxDecoration(color: Colors.transparent),
                              imageProvider:
                              FileImage(File(controller.imagePath.value!)),
                              minScale: PhotoViewComputedScale.contained,
                              maxScale: PhotoViewComputedScale.covered * 4,
                              heroAttributes:
                              const PhotoViewHeroAttributes(tag: "batikImage"),
                            ),
                            Positioned(
                              top: 40,
                              right: 20,
                              child: IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.white, size: 28),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: "batikImage",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: _buildShimmerImage(controller.imagePath.value!),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔄 Ganti CircularProgressIndicator dengan shimmer skeleton loader
                if (controller.isLoading.value)
                  Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            Container(
                              height: 20,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 14,
                              width: 240,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Analyzing batik pattern...",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                if (!controller.isLoading.value && result != null) ...[
                  const SizedBox(height: 20),

                  // 🏷 Nama Batik + Confidence
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          result.predictedBatik ?? "Unknown Batik",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      if (result.similarityScore != null)
                        Text(
                          "Confidence: ${(result.similarityScore! * 100).toStringAsFixed(0)}%",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Divider(color: Colors.grey.shade300, thickness: 1),

                  const SizedBox(height: 12),

                  // 📖 Deskripsi hasil (markdown)
                  MarkdownBody(
                    data: result.description ?? "No description available.",
                    styleSheet: MarkdownStyleSheet(
                      p: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                      h1: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      h2: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      h3: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      strong: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      listBullet: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                      blockSpacing: 10,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 🧠 Note AI (responsive dan tidak overflow)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade100,
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        Icon(Icons.auto_awesome,
                            color: Colors.grey.shade600, size: 16),
                        const Text(
                          "Generated by AI — results may not be perfect.",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }

  // 🔄 Gambar dengan shimmer
  Widget _buildShimmerImage(String path) {
    return FutureBuilder(
      future: File(path).exists(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data == true) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(
              File(path),
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          );
        }

        return Container(
          height: 260,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.image_not_supported,
              size: 80, color: Colors.grey),
        );
      },
    );
  }
}
