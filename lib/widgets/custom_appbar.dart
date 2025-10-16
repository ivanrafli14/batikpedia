import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final EdgeInsetsGeometry padding;
  final TextStyle? titleStyle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.padding = const EdgeInsets.only(top: 40, bottom: 20),
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          if (showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () {
                if (Get.isOverlaysOpen ?? false) {
                  Get.back();
                } else {
                  Navigator.pop(context);
                }
              },
            )
          else
            const SizedBox(width: 40),

          Expanded(
            child: Center(
              child: Text(
                title,
                style: titleStyle ??
                    const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.black,
                    ),
              ),
            ),
          ),


          const SizedBox(width: 40),
        ],
      ),
    );
  }
}
