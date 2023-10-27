import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/Hive/hive_type_adapters.dart';
import 'package:hesabdar/components/theme/themes.dart';
import 'package:hesabdar/home.dart';

void main() async {
  await HiveManager.initializeHive();
  runApp(const Hesabdart());
}

class Hesabdart extends StatelessWidget {
  const Hesabdart({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // getPages: Routes.page,
      // initialRoute: '/homeScreen',
      locale: const Locale("fa", "IR"),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: HomePage(),
    );
  }
}
