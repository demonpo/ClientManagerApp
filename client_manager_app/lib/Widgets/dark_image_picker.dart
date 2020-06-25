import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DarkImagePicker extends StatefulWidget{
  File image;
  double height;
  double width;
  DarkImagePicker({@required this.height,@required this.width});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DarkImagePickerState();
  }


}


class _DarkImagePickerState extends State<DarkImagePicker>{

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      widget.image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: getImage,
      child: Container(
        margin: EdgeInsets.only(
          top:10,
          bottom: 10,
        ),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff36393f),

          image: DecorationImage(
            fit: BoxFit.cover,
              image: widget.image == null ? AssetImage("assets/icons/user.png") : FileImage(widget.image),
          ),
        ),
      ),
    );
  }


}