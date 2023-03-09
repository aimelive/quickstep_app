import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/utils/helpers.dart';

import '../../../utils/colors.dart';

class CategoryChoose extends StatefulWidget {
  const CategoryChoose({
    Key? key,
    required this.onSelected,
  }) : super(key: key);
  final void Function(String category) onSelected;

  @override
  State<CategoryChoose> createState() => _CategoryChooseState();
}

class _CategoryChooseState extends State<CategoryChoose> {
  late List<Tag> items;
  int? selectedIndex;

  _init() {
    items = [
      Tag(
        index: 0,
        text: "Cycling",
      ),
      Tag(
        index: 1,
        text: "Trip",
      ),
      Tag(
        index: 2,
        text: "Order Tracking",
      ),
      Tag(
        index: 3,
        text: "Transport",
      ),
      Tag(
        index: 4,
        text: "Other",
      ),
    ];
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: selectedIndex == null ? 15.w : 13.w,
            vertical: selectedIndex == null ? 11.h : 5.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              width: 2,
              color: grey400,
            ),
          ),
          child: Row(
            children: [
              selectedIndex == null
                  ? Text(
                      "Choose category",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 2.5.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 5.h,
                      ),
                      child: Text(
                        items[selectedIndex!].text,
                        style: const TextStyle(
                          color: white,
                          fontSize: 12,
                        ),
                      ),
                    )
            ],
          ),
        ),
        addVerticalSpace(8),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 6.w,
            vertical: 2.h,
          ),
          child: Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: items.map<Widget>(buildTag).toList(),
          ),
        )
      ],
    );
  }

  Widget buildTag(Tag item) {
    bool isSelected = selectedIndex == item.index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = item.index;
        });
        widget.onSelected(item.text);
      },
      borderRadius: BorderRadius.circular(25.r),
      child: Ink(
        decoration: BoxDecoration(
          color: isSelected ? primary : white,
          border: Border.all(width: 2, color: primary),
          borderRadius: BorderRadius.circular(25.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 6.h,
        ),
        child: Text(
          item.text,
          style: TextStyle(
            color: isSelected ? white : primary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class Tag {
  int index;
  String text;

  Tag({
    required this.index,
    required this.text,
  });
}
