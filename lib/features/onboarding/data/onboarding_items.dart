import 'package:dam_project/features/onboarding/model/onboarding_model.dart';

class OnBoardingItems {
  List<OnBoardingModel> items = [
    OnBoardingModel(
      title: "Plan Meals the Easy Way",
      descriptions:
          "Say goodbye to last-minute dinner stress. Create weekly meal plans in minutes and stay on top of your food game — all for free.",
      image: "assets/images/onboarding/onboarding-image-1.png",
    ),
    OnBoardingModel(
      title: "Smart Shopping Lists",
      descriptions:
          "We auto-generate your grocery list based on your meal plan. No more forgotten ingredients or wasted trips to the store.",
      image: "assets/images/onboarding/onboarding-image-2.png",
    ),
    OnBoardingModel(
      title: "Eat Better, Your Way",
      descriptions:
          "Whether you're vegan, gluten-free, or just picky — we've got options. Customize your meals to fit your taste and lifestyle.",
      image: "assets/images/onboarding/onboarding-image-3.png",
    ),
    OnBoardingModel(
      title: "Save Time, Eat Smarter",
      descriptions:
          "No more last-minute dinner decisions. Plan your meals in minutes and reclaim your time for what matters most.",
      image: "assets/images/onboarding/onboarding-image-4.png",
    ),
  ];
}
