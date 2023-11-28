import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/Hive/hive_type_adapters.dart';
import 'package:hesabdar/components/theme/themes.dart';
import 'package:hesabdar/controller/financial_controllers/report_controller.dart';
import 'package:hesabdar/home.dart';

bool? firstInstall;

void main() async {
  await HiveManager.initializeHive();
  runApp(const Hesabdart());
}

class Hesabdart extends StatelessWidget {
  const Hesabdart({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale("fa", "IR"),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Get.put(ReportController()).isdarkLight.value == true
          ? ThemeMode.dark
          : ThemeMode.light,
      home: HomePage(),
    );
  }
}
