import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:dam_project/features/onboarding/controller/onboarding_controller.dart';
import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:dam_project/utils/device/device_utils.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnBoardingController>(context);

    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child:
            controller.isLastPage
                ? OnBoardingButton()
                : OnBoardingNavigation(controller: controller),
      ),
      body: OnBoardingPage(controller: controller),
    );
  }
}

class OnBoardingButton extends StatelessWidget {
  const OnBoardingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.primary,
      ),
      width: DeviceUtils.getScreenWidth(context) * .9,
      height: 55,
      child: TextButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("onboarding", true);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Placeholder()),
          );
        },
        child: const Text("Get started", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

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
