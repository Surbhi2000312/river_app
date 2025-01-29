
import 'package:flutter/material.dart';

Text getBlackColor({required String text, double? fontSize,FontWeight? fontWeight,
  double? height,
  TextAlign? textAlign
})
{

  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      color: Colors.black,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
    ),
  );
}