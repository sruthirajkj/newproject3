

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageFromAssetsa extends StatefulWidget {
  const ImageFromAssetsa({Key? key}) : super(key: key);

  @override
  State<ImageFromAssetsa> createState() => _ImageFromAssetsaState();
}

class _ImageFromAssetsaState extends State<ImageFromAssetsa> {

  File? img;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            child: Image.asset("assets/im2.png"),
          ),
          ElevatedButton(onPressed: () async {
            ImagePicker imagepicker = ImagePicker();
          XFile? pickedImage = await  imagepicker.pickImage(source: ImageSource.camera);
            if(pickedImage != null){
              print(pickedImage.path);
              setState(() {
                img =File(pickedImage.path);
              });
            }


          }, child: Text("upload image")),
        img != null ?  SizedBox(
            height: 100,
            width: 100,
            child: Image.file(img!),
          ):Text("")


        ],
      )),
    );
  }
}
