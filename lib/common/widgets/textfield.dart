import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:dam_project/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool passwordInvisible;
  final TextEditingController controller;
  final String? Function(String?)?
  validator; // Adicionando validator como parâmetro

  const InputField({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.passwordInvisible = false,
    this.validator, // Inicializa o validator
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
          obscureText: passwordInvisible,
          controller: controller,
          validator: validator, // Usando o validator
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            icon: Icon(icon),
          ),
        ),
      ),
    );
  }
}
