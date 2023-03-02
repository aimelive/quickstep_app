import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../../../utils/colors.dart';
import '../../components/choose_location_dialog_func.dart';

class ChooseLocationWidget extends StatefulWidget {
  const ChooseLocationWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseLocationWidget> createState() => _ChooseLocationWidgetState();
}

class _ChooseLocationWidgetState extends State<ChooseLocationWidget> {
  String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 11.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                width: 2,
                color: grey400,
              ),
            ),
            child: text != null
                ? Text(
                    text!,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : Text(
                    "Choose location",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
          ),
        ),
        addHorizontalSpace(8),
        InkWell(
          onTap: () async {
            if (text != null) {
              setState(() {
                text = null;
              });
              return;
            }
            final location = await chooseLocationDialog(context);

            if (location != null) {
              setState(() {
                text =
                    "${location["destination"]?.latitude},${location["destination"]?.longitude}";
              });
            }
          },
          highlightColor: primary.withOpacity(0.2),
          splashColor: white,
          borderRadius: BorderRadius.circular(10.r),
          child: Ink(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                width: 2,
                color: primary,
              ),
            ),
            child: Icon(
              text == null ? Icons.map : Icons.delete_outlined,
              color: primary,
              size: 22.sp,
            ),
          ),
        )
      ],
    );
  }
}
