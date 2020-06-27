import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DarkImagePicker extends StatefulWidget{
  File image;
  double size;
  DarkImagePicker({@required this.size});

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
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff43b581),

        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: widget.size/2,
              ),
            ),
            widget.image != null ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(widget.image),
                ),
              ),
            ) :  Container(),
          ],
        ),
      ),
    );
  }


}

