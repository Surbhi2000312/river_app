import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget getCacheImage(
    {String? url = '',
      double height = 103,
      double width = 149,
      int placeHolder = 0,
      bool isCircle = false,
      bool isShowBorderRadius = false,
      BoxFit fit = BoxFit.cover,
      String? assetPath,
      Uint8List? bytes,
      File? filePath})
{
  Container imgWidget;
  var border = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(height / 2)),
    border: Border.all(
      color: Colors.black,
      width: 0.5,
    ),
  );
  if (bytes !=null) {
    imgWidget = Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: isShowBorderRadius ? border : const BoxDecoration(),
      child: Image.memory(bytes, fit: fit),
    );
  }else if (assetPath?.isNotEmpty == true) {
    imgWidget = Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: isShowBorderRadius ? border : const BoxDecoration(),
      child: Image.asset(assetPath!, fit: fit),
    );
  } else if (filePath?.path.isNotEmpty == true) {
    imgWidget = Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: isShowBorderRadius ? border : const BoxDecoration(),
      child: Image.file(filePath!, fit: fit),
    );
  } else {
    Widget cachImg = CachedNetworkImage(
      fit: fit,
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      imageUrl: url??"",
      placeholder: (context, url) => getPlaceHolder(placeHolder, height, width),
      errorWidget: (context, url, error) =>
          getPlaceHolder(placeHolder, height, width),
    );
    imgWidget = Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: isShowBorderRadius ? border : const BoxDecoration(),
      child: isShowBorderRadius ? ClipOval(child: cachImg) : cachImg,
    );
  }
  if (isCircle) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: imgWidget,
    );
  } else {
    return imgWidget;
  }
}



Widget getPlaceHolder(int placeHolderPos, double height, double width) {
  switch (placeHolderPos) {
    case 0:
    // LOGO
      return SizedBox(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        // child: Image.asset(AssetsConst.LOGO_IMG),

      );

    default:
      return SizedBox(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        // child: Image.asset(AssetsConst.LOGO_IMG),
      );
  }
}
