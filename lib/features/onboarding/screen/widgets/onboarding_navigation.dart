import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:dam_project/features/onboarding/controller/onboarding_controller.dart';

class OnBoardingNavigation extends StatelessWidget {
  const OnBoardingNavigation({super.key, required this.controller});

  final OnBoardingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: controller.skipToLastPage,
          child: const Text("Skip"),
        ),
        SmoothPageIndicator(
          controller: controller.pageController,
          count: controller.onboardingItems.items.length,
          onDotClicked: controller.onDotClicked,
          effect: const WormEffect(
            dotHeight: 12,
            dotWidth: 12,
            activeDotColor: AppColors.primary,
          ),
        ),
        TextButton(
          onPressed: controller.goToNextPage,
          child: const Text("Next"),
        ),
      ],
    );
  }
}
