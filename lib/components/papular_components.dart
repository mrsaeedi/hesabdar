import 'package:flutter/material.dart';

// custom and short width and heig
SizedBox heightOf(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox widthOf(double width) {
  return SizedBox(
    width: width,
  );
}

String truncateText(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...';
  }
}
