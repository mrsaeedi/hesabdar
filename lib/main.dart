import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/view/home.dart';

void main() {
  runApp(const Hesabdart());
}

class Hesabdart extends StatelessWidget {
  const Hesabdart({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
