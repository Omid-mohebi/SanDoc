import 'package:expance/theme/AppTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/lang/LocalizationServices.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalizationService().mylang();
  await FirebaseDatabase.instance.setPersistenceEnabled(true);
  await FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);
  runApp(
    GetMaterialApp(
      theme: AppTheme.light(),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      debugShowCheckedModeBanner: false,
      title: "SanDoc",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
