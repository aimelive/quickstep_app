import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/helpers.dart';
import '../../../authentication/signup/widgets/text_input_field.dart';

class SaveWalkDialog extends StatefulWidget {
  const SaveWalkDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<SaveWalkDialog> createState() => _SaveWalkDialogState();
}

class _SaveWalkDialogState extends State<SaveWalkDialog> {
  String? name;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      insetPadding: EdgeInsets.symmetric(horizontal: 25.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            addVerticalSpace(10),
            Text(
              "travel name*".toUpperCase(),
              style: TextStyle(
                fontSize: 14.sp,
                color: primary.withOpacity(0.7),
                fontWeight: FontWeight.w600,
              ),
            ),
            addVerticalSpace(8),
            TextInputField(
              hintText: "a name",
              onChanged: (value) {
                if (!mounted) return;
                setState(() {
                  name = value;
                });
              },
            ),
            addVerticalSpace(5),
            ElevatedButton(
              onPressed: () {
                if (name == null) return;
                popPage(context, data: name);
              },
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
