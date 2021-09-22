import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;

class ImageInputWidget extends StatefulWidget {
  final Function(File) selectImageFunc;

  const ImageInputWidget({Key? key, required this.selectImageFunc})
      : super(key: key);

  @override
  _ImageInputWidgetState createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  File? _image;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedFile == null) return;

    final fileDir = await pathProvider.getApplicationDocumentsDirectory();
    final fileName = path.basename(pickedFile.path);
    final pickedImage = File(pickedFile.path);
    final storedImage = await pickedImage.copy('${fileDir.path}/$fileName');
    await pickedImage.delete();

    setState(() {
      _image = storedImage;
    });

    widget.selectImageFunc(storedImage);
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: _imagePreview,
          ),
          SizedBox(width: 16),
          Expanded(
            child: TextButton.icon(
              onPressed: _takePicture,
              icon: Icon(Icons.camera_rounded),
              label: Text('Take Picture'),
            ),
          )
        ],
      );

  Widget get _imagePreview {
    final image = _image;
    return image == null
        ? Text(
            'No image',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(14.75),
            child: Image.file(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
  }
}
