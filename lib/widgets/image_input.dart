import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final void Function(File) imageHandler;

  ImageInput(this.imageHandler);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final picker = ImagePicker();
  File _storedImage;

  Future<void> _openCamera() async {
    final pickedImage =
        await picker.getImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage != null) {
      _storedImage = File(pickedImage.path);
      final appDir = await syspath.getApplicationDocumentsDirectory();
      final filename = path.basename(pickedImage.path);
      _storedImage = await _storedImage.copy(path.join(appDir.path, filename));
      setState(() {});
      widget.imageHandler(_storedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No image taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            onPressed: _openCamera,
            icon: Icon(Icons.camera),
            label: Text('Take picture'),
          ),
        )
      ],
    );
  }
}
