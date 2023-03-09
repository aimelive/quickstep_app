import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickstep_app/controllers/auth.dart';
import 'package:quickstep_app/screens/components/top_snackbar.dart';
import 'package:quickstep_app/services/auth_service.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/helpers.dart';
import '../widgets/radio_buttons.dart';
import '../widgets/text_input_field.dart';
import 'create_account.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  String? username;
  File? profilePic;
  final authService = AuthService();

  IsLoading _isLoading = IsLoading.idle;

  final authState = Get.find<AuthState>();

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
        profilePic = File(cropped.path);
      });
    } catch (e) {
      onUnkownError(e);
    }
  }

  void _createProfile() async {
    if (profilePic != null && username != null) {
      setState(() {
        _isLoading = IsLoading.loading;
      });
      final res = await authService.createProfile(
        authState.email.value,
        username!,
        profilePic!,
        authState.token.value,
      );
      if (!mounted) return;
      setState(() {
        _isLoading = IsLoading.success;
      });
      if (res != null) {
        showMessage(
          message:
              "Account created successfully, please go to sign in page and login to your account",
          title: "Profile Created",
          type: MessageType.success,
        );
        popPage(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = _isLoading == IsLoading.loading;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
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
                        TextInputField(
                          hintText: "a username",
                          onChanged: (value) {
                            setState(() {
                              username = value;
                            });
                          },
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
                                      border:
                                          Border.all(width: 2, color: primary),
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
                                      border:
                                          Border.all(width: 2, color: primary),
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
                            textDirection:
                                loading ? TextDirection.ltr : TextDirection.rtl,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                disabledBackgroundColor: lightPrimary,
                                disabledForegroundColor: white,
                              ),
                              onPressed: loading ? null : _createProfile,
                              icon: loading
                                  ? LoadingAnimationWidget.inkDrop(
                                      color: white,
                                      size: 18.sp,
                                    )
                                  : Icon(
                                      Icons.arrow_back,
                                      size: 24.sp,
                                    ),
                              label: Text(
                                loading ? " LOADING..." : "FINISH SIGNUP",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
