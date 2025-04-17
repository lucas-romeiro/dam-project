import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dam_project/features/onboarding/screen/widgets/onboarding_button.dart';
import 'package:dam_project/features/onboarding/screen/widgets/onboarding_navigation.dart';
import 'package:dam_project/features/onboarding/screen/widgets/onboarding_page.dart';
import 'package:dam_project/features/onboarding/controller/onboarding_controller.dart';

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
