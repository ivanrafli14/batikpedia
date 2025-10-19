import 'package:batikpedia/app/modules/about/views/about_view.dart';
import 'package:batikpedia/app/modules/ai/views/ai_view.dart';
import 'package:batikpedia/app/modules/gallery/views/gallery_view.dart';
import 'package:batikpedia/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/navbar_controller.dart';

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

    return Obx(() => Scaffold(
      body: pages[controller.currentTab.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentTab.value,
        onTap: controller.changeTab,
        showUnselectedLabels: true,
        selectedItemColor: Color(0xFF0B506C),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,

        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,

        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'Gallery',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Batik AI',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',

          ),
        ],
      ),
    ));
  }
}
