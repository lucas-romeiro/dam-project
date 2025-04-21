import 'package:dam_project/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dam_project/features/recipe/model/recipe_model.dart';
import 'package:dam_project/features/recipe/screen/recipe_card.dart';
import 'package:dam_project/utils/constants/app_colors.dart';

class AllRecipesScreen extends StatelessWidget {
  final List<Recipe> recipes;

  const AllRecipesScreen({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          const SizedBox(width: 15),
          const Text(
            "Quick & Easy",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(flex: 2),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child:
            recipes.isEmpty
                ? const Center(child: Text("Nenhuma receita encontrada."))
                : GridView.builder(
                  itemCount: recipes.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return RecipeCard(
                      recipe: recipe,
                      width: DeviceUtils.getScreenWidth(context) / 2.45 + 15,
                    );
                  },
                ),
      ),
    );
  }
}
