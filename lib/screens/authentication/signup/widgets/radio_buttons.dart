import 'package:flutter/material.dart';
import 'package:quickstep_app/utils/colors.dart';

class RadioButtons extends StatefulWidget {
  const RadioButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<RadioButtons> createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  String? selected;

  void _refreValue(String? value) {
    setState(() {
      selected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: "personal",
          groupValue: selected,
          onChanged: _refreValue,
          activeColor: primary,
        ),
        GestureDetector(
          onTap: () => _refreValue("personal"),
          child: const Text("For personal use"),
        ),
        const Spacer(),
        Radio(
          value: "business",
          groupValue: selected,
          onChanged: _refreValue,
          activeColor: primary,
        ),
        GestureDetector(
          onTap: () => _refreValue("business"),
          child: const Text("For business use"),
        ),
      ],
    );
  }
}
