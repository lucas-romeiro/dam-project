import 'package:flutter/material.dart';

class CalorieSlider extends StatefulWidget {
  final TextEditingController controller;

  const CalorieSlider({super.key, required this.controller});

  @override
  State<CalorieSlider> createState() => _CalorieSliderState();
}

class _CalorieSliderState extends State<CalorieSlider> {
  late double _calories;

  @override
  void initState() {
    super.initState();
    _calories = double.tryParse(widget.controller.text) ?? 2000;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.local_fire_department),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Calorias desejadas: ${_calories.toInt()} kcal",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          Slider(
            value: _calories,
            min: 0,
            max: 4500,
            divisions: 90,
            label: _calories.toInt().toString(),
            onChanged: (value) {
              setState(() {
                _calories = value;
                widget.controller.text = value.toInt().toString();
              });
            },
          ),
        ],
      ),
    );
  }
}
