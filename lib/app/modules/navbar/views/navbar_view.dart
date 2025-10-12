import 'package:batikpedia/app/modules/about/views/about_view.dart';
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
      AboutView(),
    ];

    return Obx(() => Scaffold(
      body: pages[controller.currentTab.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentTab.value,
        onTap: controller.changeTab,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
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
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
      ),
    ));
  }
}
