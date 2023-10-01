import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/themes.dart';
import 'package:hesabdar/view/add_new-payment.dart';

import 'package:hesabdar/view/payment_cat.dart';
import 'package:hesabdar/view/result_page.dart';

void main() {
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
      // supportedLocales: const [
      //   Locale('en', 'US'),
      // ],
      locale: const Locale("fa", "IR"),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: RsuletPage(),
    );
  }
}
