import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:dam_project/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback press;

  const Button({super.key, required this.label, required this.press});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getScreenWidth(context) * .9,
      height: 55,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: press,
        child: Text(label, style: const TextStyle(color: AppColors.white)),
      ),
    );
  }
}
