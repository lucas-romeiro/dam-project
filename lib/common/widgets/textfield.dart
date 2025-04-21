import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:dam_project/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isVisible;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const InputField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    this.isVisible = false,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: DeviceUtils.getScreenWidth(context) * .9,
      height: 55,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextFormField(
          obscureText: isVisible,
          controller: controller,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: label,
            icon: Icon(icon),
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
