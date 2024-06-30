import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gieco_west/Utils/const.dart';
import 'package:gieco_west/Utils/widgets/custom_text_wgt.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({
    super.key,
    required this.onPickImage,
  });

  final void Function(File pickedImage) onPickImage;

  @override
  State<MyImagePicker> createState() {
    return _MyImagePickerState();
  }
}

class _MyImagePickerState extends State<MyImagePicker> {
  File? _pickedImageFile;
  File imageFile = File("assets/Images/add-image.png");

  void _pickCamImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      // imageQuality: 100,
      // maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  void _pickGalleryImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      // imageQuality: 100,
      // maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width / 1.22,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: _pickCamImage,
                icon: Icon(
                  Icons.camera,
                  color: Theme.of(context).primaryColor,
                ),
                label: const CustomTextWgt(
                  data: 'الكاميرا',
                ),
              ),
              CircleAvatar(
                radius: 75.sp,
                backgroundColor: Colors.grey.withOpacity(.6),
                foregroundImage: _pickedImageFile != null
                    ? FileImage(_pickedImageFile!)
                    : Image.asset(Const.addImage).image,
              ),
              TextButton.icon(
                  onPressed: _pickGalleryImage,
                  icon: Icon(
                    Icons.image,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: const CustomTextWgt(
                    data: 'المعرض',
                  )),
            ],
          ),
        ));
  }
}
