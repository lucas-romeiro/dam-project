import 'package:flutter/material.dart';
import 'package:dam_project/features/onboarding/controller/onboarding_controller.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key, required this.controller});

  final OnBoardingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: PageView.builder(
        controller: controller.pageController,
        itemCount: controller.onboardingItems.items.length,
        onPageChanged: controller.onPageChanged,
        itemBuilder: (context, index) {
          final item = controller.onboardingItems.items[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(item.image),
              const SizedBox(height: 15),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                item.descriptions,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
