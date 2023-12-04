import 'package:flutter/material.dart';
import 'package:hesabdar/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key}) : super();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _nvaigateToHome();
  }

  _nvaigateToHome() async {
    await Future.delayed(
        Duration(
          milliseconds: 2000,
        ), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/self.png'),
            Text('مدیریت شخصی'),
          ],
        ),
      ),
    );
  }
}
