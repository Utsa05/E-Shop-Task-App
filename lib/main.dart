import 'package:eshop_task/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eShop Task App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}
