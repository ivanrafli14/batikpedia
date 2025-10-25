import 'package:batikpedia/app/data/batik_model.dart';
import 'package:batikpedia/widgets/batik_card.dart';
import 'package:batikpedia/widgets/batik_skeleton.dart';
import 'package:batikpedia/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/gallery_controller.dart';

class GalleryView extends GetView<GalleryController> {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          const CustomAppBar(
            title: 'Gallery',
            showBackButton: false,

          ),


          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF1E1E1E), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      const Icon(Icons.search, color: Colors.black54),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          onChanged: controller.onSearchChanged,
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 50,
                        color: Color(0xFF1E1E1E)
                      ),
                      IconButton(
                        icon: const Icon(Icons.filter_list,
                            color: Colors.black54),
                        onPressed: () {
                          controller.showFilters.toggle();
                        },
                      ),
                    ],
                  ),
                ),


                Obx(() =>  AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, anim) =>
                      SizeTransition(sizeFactor: anim, child: child),
                  child: controller.showFilters.value
                      ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Obx(() {
                      final allFilters = [
                        'All',
                        ...controller.cityFilters
                      ];

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: allFilters.map((filter) {
                            final isSelected = controller
                                .selectedFilters
                                .contains(filter);

                            return GestureDetector(
                              onTap: () {
                                if (filter == 'All') {
                                  controller.selectedFilters.clear();
                                  controller.selectedFilters.add('All');
                                } else {
                                  if (isSelected) {
                                    controller.selectedFilters
                                        .remove(filter);
                                  } else {
                                    controller.selectedFilters
                                        .remove('All');
                                    controller.selectedFilters
                                        .add(filter);
                                  }
                                }

                                controller.refreshData();
                              },
                              child: AnimatedContainer(
                                duration:
                                const Duration(milliseconds: 200),
                                margin:
                                const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF0B506C)
                                      : Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(30),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF0B506C)
                                        : Colors.grey.shade400,
                                  ),
                                ),
                                child: Text(
                                  filter,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey.shade800,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }),
                  )
                      : const SizedBox.shrink(),
                ),)

              ],
            ),
          ),


          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.batikItems.isEmpty) {

                return _buildSkeletonGrid();
              }

              return Stack(
                children: [

                  GridView.builder(
                    controller: controller.scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: controller.batikItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.batikItems[index];

                      if(item.images.isNotEmpty){
                        var optimizedUrl = controller.optimizeCloudinaryUrl(item.images.first.imagePath, width: 600, quality: 70);
                        item.images.first.imagePath = optimizedUrl;
                      }

                      return GestureDetector(
                        onTap: () {
                          controller.goToDetailPage(item.id);
                        },
                        child: BatikCard(
                          key: ValueKey(item.id),
                          item: item,
                        ),
                      );
                    },
                  ),


                  Obx(() => AnimatedAlign(
                    alignment: Alignment.bottomCenter,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutBack,
                    child: AnimatedOpacity(
                      opacity: controller.isLoading.value ? 1 : 0,
                      duration: const Duration(milliseconds: 400),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 80),
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.8, end: 1.0),
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeOutBack,
                            builder: (context, scale, child) => Transform.scale(
                              scale: scale,
                              child: child,
                            ),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Color(0xFF0B506C),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))

                ],
              );
            }),
          )
        ],
      ),
    );
  }
}


Widget _buildSkeletonGrid() {
  return GridView.builder(
    padding: const EdgeInsets.all(12),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.72,
    ),
    itemCount: 6,
    itemBuilder: (context, index) => const BatikSkeleton(),
  );
}
