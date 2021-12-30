import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path; //helps creatin and combining path
import 'package:path_provider/path_provider.dart'
    as syspath; //helps accessing path

class ImageInput extends StatefulWidget {
  final Function onselect;
  ImageInput(this.onselect);
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  Future<void> _takepicture() async {
    final image = ImagePicker();
    final imageFile =
        await image.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage =
          File(imageFile.path); //because pickImage returns XFIle type
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(File(imageFile.path)
        .path); // baseName return the value after the last seperator
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.onselect(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: _storedImage == null
              ? Center(
                  child: Text(
                  'No Image',
                  textAlign: TextAlign.center,
                ))
              : Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
              icon: Icon(Icons.camera),
              label: Text('Take Photo'),
              onPressed: _takepicture),
        )
      ],
    );
  }
}
