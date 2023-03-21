import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final File _storedImage = File('');

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final awaitImage = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage.path.isEmpty
              ? const Text(
                  'No image taken',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            onPressed: () => _takePicture(),
            icon: const Icon(
              Icons.camera,
            ),
            label: const Text('Take Picture'),
          ),
        ),
      ],
    );
  }
}
