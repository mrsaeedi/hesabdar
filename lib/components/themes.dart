import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_tools/persian_tools.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return const Placeholder();
  }
}

//! ========= all textTheme propertys is in this class ==========
class MyTextTheme {
  static const String fontFamily = 'Vazir';

  static const TextTheme myTextThemeLight = TextTheme(
    titleLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(255, 26, 26, 26)),
//
    bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(255, 255, 255, 255)),
//
    bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(157, 77, 77, 77)),
  );
//! dark mode text theme
  static const TextTheme myTextThemeDark = TextTheme(
    titleLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(255, 253, 253, 253)),

//
    bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(255, 255, 242, 231)),
//
    bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(255, 255, 242, 231)),
  );
}

// ! =========== buttons styel are in this class==============
class MyButtonStyle {
  //elevetedButton Style
  static ElevatedButtonThemeData myElevetedButton =
      const ElevatedButtonThemeData(
          style: ButtonStyle(
              elevation: MaterialStatePropertyAll(0),
              backgroundColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 252, 143, 42))));
}

//!============== theme data classes and propertys ==============
class AppTheme {
  //!lighti theme propertys
  static final lightTheme = ThemeData(
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.green,
      ),
      primaryColor: Color.fromARGB(255, 62, 104, 167),
// elevetedButtom style
      elevatedButtonTheme: MyButtonStyle.myElevetedButton,
// primery colors
      colorScheme: ColorScheme.fromSwatch(
        backgroundColor: Colors.white,
      ),
      fontFamily: MyTextTheme.fontFamily,
      brightness: Brightness.light,
      // useMaterial3: true,
// text styles
      textTheme: MyTextTheme.myTextThemeLight);

  //!dark theme propertys
  static final darkTheme = ThemeData(
    //elevetedButton Style
    elevatedButtonTheme: MyButtonStyle.myElevetedButton,
    fontFamily: MyTextTheme.fontFamily,
    colorScheme: ColorScheme.dark(),
    textTheme: MyTextTheme.myTextThemeDark,
  );
}
