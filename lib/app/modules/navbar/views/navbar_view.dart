import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navbar_controller.dart';
import 'package:batikpedia/app/modules/home/views/home_view.dart';
import 'package:batikpedia/app/modules/gallery/views/gallery_view.dart';
import 'package:batikpedia/app/modules/ai/views/ai_view.dart';
import 'package:batikpedia/app/modules/about/views/about_view.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = const [
      HomeView(),
      GalleryView(),
      AiView(),
      AboutView(),
    ];

    final List<Map<String, String>> navItems = [
      {"icon": "assets/images/home.png", "active": "assets/images/home-filled.png", "label": "Home"},
      {"icon": "assets/images/gallery.png", "active": "assets/images/gallery.png", "label": "Gallery"},
      {"icon": "assets/images/ai.png", "active": "assets/images/ai.png", "label": "Batik AI"},
      {"icon": "assets/images/info.png", "active": "assets/images/info-filled.png", "label": "About"},
    ];

    const Color activeColor = Color(0xFF0B506C); // orange highlight
    const Color inactiveColor = Colors.black;

    return Obx(() {
      final currentIndex = controller.currentTab.value;

      return Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000), // subtle top shadow
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(navItems.length, (index) {
                final item = navItems[index];
                final isSelected = currentIndex == index;

                return GestureDetector(
                  onTap: () => controller.changeTab(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? activeColor.withOpacity(0.15) : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          isSelected ? item["active"]! : item["icon"]!,
                          width: 26,
                          height: 26,
                          color: isSelected ? activeColor : inactiveColor,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item["label"]!,
                          style: TextStyle(
                            color: isSelected ? activeColor : inactiveColor,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      );
    });
  }
}
