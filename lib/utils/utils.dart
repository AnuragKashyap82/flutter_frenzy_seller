import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  showSnackBar(BuildContext context, String content){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content),),);
  }

  Future<Uint8List?> pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    return file!.readAsBytes();
  }


}

const webScreenSize = 600;
