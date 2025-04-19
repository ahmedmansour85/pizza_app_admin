import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pizza_repository/pizza_repository.dart';

class WebImagePickerContainer extends StatefulWidget {
  final Pizza pizza;
  const WebImagePickerContainer({super.key, required this.pizza});

  @override
  State<WebImagePickerContainer> createState() =>
      _WebImagePickerContainerState();
}

class _WebImagePickerContainerState extends State<WebImagePickerContainer> {
  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true, // هذا مهم على الويب لتحصل على Uint8List
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _imageBytes = result.files.single.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () async {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 1000,
          maxWidth: 1000,
        );
        // if (image != null && context.mounted) {
        //   context.read<UploadPictureBloc>().add(
        //   //    UploadPicture(await image.readAsBytes(), basename(image.path)));
        // }
      },
      child: widget.pizza.picture.startsWith(('http'))
          ? Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(widget.pizza.picture),
                      fit: BoxFit.cover)))
          : Ink(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.photo,
                    size: 100,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Add a Picture here...",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
    );
  }
}
