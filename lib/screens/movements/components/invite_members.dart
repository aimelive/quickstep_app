import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/helpers.dart';

class InviteMembers extends StatelessWidget {
  const InviteMembers({
    Key? key,
    required this.onContinue,
  }) : super(key: key);
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Invite",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade900,
              ),
            ),
            addHorizontalSpace(5),
            Icon(
              Icons.share,
              color: Colors.grey.shade600,
            ),
          ],
        ),
        ElevatedButton(
          onPressed: onContinue,
          child: Text("Invite"),
        )
      ],
    );
  }
}
