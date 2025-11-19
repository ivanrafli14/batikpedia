import 'package:batikpedia/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/about_controller.dart';

import 'package:url_launcher/url_launcher.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(
                title: 'About',
                showBackButton: false,
                padding: EdgeInsets.only(top: 6, bottom: 20),
              ),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', width: 225),
                    Container(
                      margin: EdgeInsets.only(top: 14, bottom: 28),
                      child: Text('BatikPedia',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 32,
                            color: Color(0xFF033049)
                          )),
                    )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(bottom: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/ub.png', height: 26),
                    Container(
                      width: 2,
                      height: 20,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Image.asset('assets/images/ritsu.png',height: 23),
                    Container(
                      width: 2,
                      height: 20,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Image.asset('assets/images/gub.png',height: 21),
                  ],
                ),
              ),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'BatikPedia ',
                      style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                    TextSpan(
                      text:
                      'is a digital platform that serves as a comprehensive database of batik from East Java. The website is designed to document, collect, and present various batik patterns from districts and cities across East Java in a systematic manner. Each batik entry includes detailed information about its origin, philosophy, symbolic meaning, production and dyeing techniques, year of creation, as well as variations in visual elements. This information can be accessed as an academic reference, research source, or inspiration for creative development.',
                      style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),

              Container(
                margin: EdgeInsets.only(top: 18, bottom: 16),
                child: Text('More',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16) ),
              ),

              _buildLinkButton(
                context,
                label: 'Instagram',
                imagePath: 'assets/images/batik_bg.png',
                onTap: () {
                  launchUrl(Uri.parse('https://instagram.com/batikpedia_ub'));
                },
              ),
              SizedBox(height: 16),
              _buildLinkButton(
                context,
                label: 'Website',
                imagePath: 'assets/images/batik_bg.png',
                onTap: () {
                  launchUrl(Uri.parse('https://batikpedia.cloud/'));
                },
              ),

              SizedBox(height: 40),

            ],
          )
        ),
      )
    );
  }

  Widget _buildLinkButton(BuildContext context,
      {required String label,
        required String imagePath,
        required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color(0xFF0B506C),
              BlendMode.overlay,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.north_east,
              color: Colors.white,
              size: 20,
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
