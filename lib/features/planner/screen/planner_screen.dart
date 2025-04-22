import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dam_project/features/authentication/controller/auth_controller.dart';
import 'package:dam_project/features/planner/controller/planner_controller.dart';
import 'package:dam_project/features/planner/screen/widgets/progress_indicator_value.dart';
import 'package:dam_project/features/recipe/screen/recipe_card.dart';
import 'package:dam_project/utils/device/device_utils.dart';
import 'package:dam_project/utils/constants/app_colors.dart';

class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final planner = context.watch<PlannerController>();
    final user = auth.loggedUser!;

    final calories = user.calories?.toInt() ?? 2000;
    final diet = user.diet ?? 'None';

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        title: const Text(
          "My Daily Meal Plan",
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            planner.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (planner.mealPlan == null) ...[
                        const Text(
                          "You haven't generated your daily meal planner yet.",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.darkGrey,
                          ),
                        ),
                        const Text(
                          "Press the button to get it now.",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.darkGrey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 8,
                            ),
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed:
                              planner.mealPlan != null
                                  ? null
                                  : () => planner.generateMealPlan(
                                    targetCalories: calories,
                                    diet: diet,
                                  ),
                          child: const Text(
                            "Generate your daily meal plan",
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      ],

                      if (planner.mealPlan != null) ...[
                        Text(
                          "Your personalized daily meal plan has been successfully generated!",
                          style: TextStyle(
                            color: AppColors.darkerGrey,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 50),
                        Row(
                          children: [
                            Text(
                              "Nutritional Info",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildMealPlanIndicators(planner.mealPlan!),

                        const SizedBox(height: 25),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Meals",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              planner.mealPlan!.recipes.length,
                              (index) {
                                final recipe = planner.mealPlan!.recipes[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: index == 0 ? 20 : 10,
                                    right: 10,
                                  ),
                                  child: RecipeCard(
                                    recipe: recipe,
                                    width:
                                        DeviceUtils.getScreenWidth(context) /
                                        2.45,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
      ),
    );
  }

  Widget _buildMealPlanIndicators(planner) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProgressIndicatorValue(
          name: "Carbs",
          amount: "${planner.carbs} g",
          percentage: "(56%)",
          color: Colors.green,
          data: 0.4,
        ),
        ProgressIndicatorValue(
          color: Colors.red,
          name: 'Fat',
          amount: '${planner.fat} g',
          percentage: '(72%)',
          data: 0.6,
        ),
        ProgressIndicatorValue(
          color: Colors.orange,
          name: 'Protein',
          amount: '${planner.protein} g',
          percentage: '(8%)',
          data: 0.2,
        ),
        ProgressIndicatorValue(
          color: Colors.green,
          name: 'Calories',
          amount: '${planner.calories} kcal',
          percentage: "",
          data: 0.7,
        ),
      ],
    );
  }
}
