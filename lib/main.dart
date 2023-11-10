import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/Hive/hive_type_adapters.dart';
import 'package:hesabdar/components/theme/themes.dart';
import 'package:hesabdar/data/category_items.dart';
import 'package:hesabdar/home.dart';
import 'package:hesabdar/model/financial_models/category_items_model.dart';
import 'package:hive/hive.dart';

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
      themeMode: ThemeMode.dark,
      home: HomePage(),
    );
  }
}
