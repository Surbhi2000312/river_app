import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:river_app/widget_helper/getImages.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  String base64Image = ''; // Will be assigned in JSON profile.image = base64Image.toString
  String customerImage = '';
  File? imageFile;
  Uint8List? bytes;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: (){
                imagePickerDialog();
              },
              child: Container(
                width: 200,
                height: 200,
                color: Colors.grey,
                child: imageFile != null
                    ? getCacheImage(
                  filePath: imageFile!,
                  height: 130,
                  width: 130,
                  placeHolder: 1,
                  isCircle: true,
                  isShowBorderRadius: true,
                )
                    : getCacheImage(
                  url: customerImage,
                  height: 130,
                  width: 130,
                  placeHolder: 1,
                  isCircle: true,
                  isShowBorderRadius: true,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

        ],
      ),
    );
  }

  void imagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(
            "Select Option",
            style: const TextStyle(fontSize: 14),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child:Text("Take Photo"),
                ),
              ),
              const Divider(color: Colors.grey, height: 1),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child:Text("Choose From Gallery"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Future<void> getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      File filePath = File(pickedFile.path);
      bytes = await pickedFile.readAsBytes();
      base64Image = 'data:image/jpeg;base64,${base64Encode(bytes!)}';

      setState(() {
        imageFile = filePath;
      });

      print('\nBase64 Image: $base64Image\n');
    }
  }

}
