import 'package:flutter/material.dart';

class DietDropdown extends StatelessWidget {
  final List<String> diets;
  final TextEditingController controller;

  const DietDropdown({
    super.key,
    required this.diets,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: DropdownButtonFormField<String>(
          value: controller.text.isNotEmpty ? controller.text : null,
          icon: const Icon(Icons.arrow_drop_down),
          decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.restaurant),
            hintText: 'Select a diet',
          ),
          items:
              diets.map((diet) {
                return DropdownMenuItem<String>(value: diet, child: Text(diet));
              }).toList(),
          onChanged: (value) {
            controller.text = value ?? '';
          },
        ),
      ),
    );
  }
}
