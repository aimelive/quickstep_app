import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/screens/components/top_snackbar.dart';

import '../../../utils/colors.dart';
import '../../../utils/helpers.dart';
import '../widgets/category.dart';

class CreateMovement extends StatefulWidget {
  const CreateMovement({
    Key? key,
    required this.onContinue,
  }) : super(key: key);
  final void Function(String title, String desc) onContinue;

  @override
  State<CreateMovement> createState() => _CreateMovementState();
}

class _CreateMovementState extends State<CreateMovement> {
  String name = "";
  String? cat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Create",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade900,
              ),
            ),
            addHorizontalSpace(5),
            Icon(
              Icons.add_circle_outline,
              color: Colors.grey.shade600,
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          "Movement name*".toUpperCase(),
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: primary.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        addVerticalSpace(8),
                        TextFormField(
                          style: const TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w600,
                          ),
                          cursorColor: lightPrimary,
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Enter a name",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 12.h,
                            ),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: BorderSide(
                                width: 2,
                                color: grey400,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: const BorderSide(
                                width: 2,
                                color: lightPrimary,
                              ),
                            ),
                          ),
                        ),
                        addVerticalSpace(18),
                        Text(
                          "category*".toUpperCase(),
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: primary.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        addVerticalSpace(8),
                        CategoryChoose(onSelected: (category) {
                          setState(() {
                            cat = category;
                          });
                        }),
                        // addVerticalSpace(18),
                        // Text(
                        //   "choose source(optional)".toUpperCase(),
                        //   style: TextStyle(
                        //     fontSize: 15.sp,
                        //     color: primary.withOpacity(0.7),
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                        // addVerticalSpace(8),
                        // const ChooseLocationWidget(),
                        // addVerticalSpace(18),
                        // Text(
                        //   "choose destination(optional)".toUpperCase(),
                        //   style: TextStyle(
                        //     fontSize: 15.sp,
                        //     color: primary.withOpacity(0.7),
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                        // addVerticalSpace(8),
                        // const ChooseLocationWidget(),
                        addVerticalSpace(18),
                        Text(
                          "continue to invite members".toUpperCase(),
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: primary.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        addVerticalSpace(18),
                        Center(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (name.isEmpty || cat == null) {
                                  showMessage(
                                    message:
                                        "Name and category fields are required",
                                    title: "Fields required*",
                                    type: MessageType.error,
                                  );
                                  return;
                                }
                                widget.onContinue(name, cat!);
                              },
                              icon: const Icon(Icons.arrow_back),
                              label: const Text("CONTINUE"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
