import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void>  main() async {
  await dotenv.load(fileName: ".env");

  String supabaseUrl =  dotenv.env['SUPABASE_URL'] ?? '';
  String supabasePublishableKey = dotenv.env['SUPABASE_PUBLISHABLE_KEY'] ?? '';

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabasePublishableKey,
  );


  runApp(
    GetMaterialApp(
      title: "Application",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        primaryColor: const Color(0xFF033049),
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF033049),
          background: const Color(0xFFFFFFFF),
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF033049)),
        ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
