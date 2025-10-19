import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_batik_controller.dart';

class DetailBatikView extends GetView<DetailBatikController> {
  const DetailBatikView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Detail",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value || controller.batikDetail.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final batik = controller.batikDetail.value!;
        print("DEBUG groupedSubThemes => ${batik.groupedSubThemes}");


        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  batik.images.isNotEmpty ? batik.images.first.imagePath : '',
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_not_supported, size: 80),
                ),
              ),
              const SizedBox(height: 18),


              Text(
                batik.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),


              Text(
                batik.histori ?? "Tidak ada deskripsi.",
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),


              _infoRow(batik.artist, batik.address ?? "-"),


              _themeGroupedSection(batik.groupedSubThemes),


              _infoGrid([
                {"Colour": batik.warna},
                {"Technic": batik.teknik},
                {"Jenis Kain": batik.jenisKain},
                {"Pewarna": batik.pewarna},
                {"Shape": batik.bentuk},
                {"Dimension": batik.dimension},
              ]),
            ],
          ),
        );
      }),
    );
  }




  Widget _infoRow(String title, String value) {
    return Table(
      border: TableBorder(
        top: BorderSide(color: Colors.grey.shade300, width: 1),
        bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1),
        verticalInside: BorderSide(color: Colors.grey.shade300, width: 1),
        left: BorderSide.none,
        right: BorderSide.none,
      ),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(4),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            _cellTitle(title),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                value,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _themeGroupedSection(Map<String, List<String>> groupedThemes) {
    return Table(
      border: TableBorder(
        top: BorderSide(color: Colors.grey.shade300, width: 1),
        bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1),
        verticalInside: BorderSide(color: Colors.grey.shade300, width: 1),
        left: BorderSide.none,
        right: BorderSide.none,
      ),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(4),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            _cellTitle("Theme"),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: groupedThemes.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 6,
                      spacing: 6,
                      children: [

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            entry.key.capitalizeFirst ?? entry.key,
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),

                        ...entry.value.map(
                              (sub) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black87),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              sub.capitalizeFirst ?? sub,
                              style: const TextStyle(fontSize: 12, color: Colors.black87),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _infoGrid(List<Map<String, String>> items) {
    return Table(
      border: TableBorder(
        top: BorderSide(color: Colors.grey.shade300, width: 1),
        bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1),
        verticalInside: BorderSide(color: Colors.grey.shade300, width: 1),
        left: BorderSide.none,
        right: BorderSide.none,
      ),
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(3),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        for (int i = 0; i < items.length; i += 2)
          TableRow(
            children: [
              _infoCell(items[i]),
              if (i + 1 < items.length) _infoCell(items[i + 1]) else const SizedBox(),
            ],
          ),
      ],
    );
  }


  Widget _infoCell(Map<String, String> item) {
    final title = item.keys.first;
    final value = item.values.first;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isNotEmpty ? value : "-",
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ],
      ),
    );
  }


  Widget _cellTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
  }