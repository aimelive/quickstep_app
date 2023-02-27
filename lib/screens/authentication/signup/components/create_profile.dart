import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/helpers.dart';
import '../widgets/radio_buttons.dart';
import '../widgets/text_input_field.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({
    Key? key,
    required this.onStart,
  }) : super(key: key);
  final VoidCallback onStart;

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? selectedImage;

  void _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
      );
      if (image == null) return;
      final file = File(image.path);
      final cropped = await ImageCropper().cropImage(sourcePath: file.path);
      if (cropped == null) return;
      final bytes = await File(cropped.path).readAsBytes();
      setState(() {
        selectedImage = bytes;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Create Profile",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade900,
              ),
            ),
            addHorizontalSpace(5),
            Icon(
              Icons.person,
              color: Colors.grey.shade600,
            ),
          ],
        ),
        Form(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 18.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username*".toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(8),
                const TextInputField(
                  hintText: "a username",
                ),
                addVerticalSpace(18),
                Text(
                  "Profile photo*".toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundColor: lightPrimary,
                      foregroundColor: white,
                      foregroundImage: selectedImage == null
                          ? null
                          : MemoryImage(selectedImage!),
                      child: Icon(
                        Icons.add_photo_alternate_rounded,
                        size: 30.sp,
                      ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () => _pickImage(ImageSource.camera),
                          borderRadius: BorderRadius.circular(25.r),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: white,
                              border: Border.all(width: 2, color: primary),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 6.h,
                            ),
                            child: Text(
                              "Choose from Camera",
                              style: TextStyle(
                                color: primary,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                        addVerticalSpace(10.h),
                        InkWell(
                          onTap: () => _pickImage(ImageSource.gallery),
                          borderRadius: BorderRadius.circular(25.r),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: primary,
                              border: Border.all(width: 2, color: primary),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 6.h,
                            ),
                            child: Text(
                              "Choose from Gallery",
                              style: TextStyle(
                                color: white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                addVerticalSpace(20),
                Text(
                  "Account purpose*".toUpperCase(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: primary.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addVerticalSpace(10),
                const RadioButtons(),
                addVerticalSpace(20),
                Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: widget.onStart,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("FINISH SIGNUP"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
