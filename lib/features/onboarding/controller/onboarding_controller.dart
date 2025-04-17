import 'package:flutter/material.dart';
import 'package:dam_project/features/onboarding/data/onboarding_items.dart';

class OnBoardingController extends ChangeNotifier {
  final onboardingItems = OnBoardingItems();
  final pageController = PageController();

  bool _isLastPage = false;

  bool get isLastPage => _isLastPage;

  void onPageChanged(int index) {
    _isLastPage = index == onboardingItems.items.length - 1;
    notifyListeners();
  }

  void goToNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeIn,
    );
  }

  void skipToLastPage() {
    pageController.jumpToPage(onboardingItems.items.length - 1);
  }

  void onDotClicked(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeIn,
    );
  }
}
