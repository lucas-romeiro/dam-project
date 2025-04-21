import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:dam_project/features/recipe/model/recipe_model.dart';
import 'package:dam_project/features/recipe/screen/recipe_detail_screen.dart'; // Importa seu controller
import 'package:dam_project/features/favorites/controller/favorites_controller.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final double width;

  const RecipeCard({super.key, required this.recipe, this.width = 160});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      },
      child: Container(
        height: 260,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(recipe.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ⭐ Botão de favorito com Consumer
            Consumer<FavoritesController>(
              builder: (context, favoritesController, _) {
                final isFavorite = favoritesController.isFavorite(recipe.id);

                return GestureDetector(
                  onTap: () => favoritesController.toggleFavorite(recipe.id),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.softBlack,
                    ),
                    child: Icon(
                      isFavorite
                          ? Iconsax.heart5
                          : Iconsax.heart, // ícone preenchido ou não
                      color: isFavorite ? Colors.red : AppColors.white,
                      size: 18,
                    ),
                  ),
                );
              },
            ),

            // 🔽 Infos da receita
            Container(
              padding: const EdgeInsets.all(10),
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.softBlack,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 0,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${recipe.caloriesPerServing} Kcal",
                    style: const TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "⭐ ${recipe.rating}",
                        style: const TextStyle(color: AppColors.lightGrey),
                      ),
                      Text(
                        "⏱️ ${recipe.prepTimeMinutes + recipe.cookTimeMinutes} min",
                        style: const TextStyle(color: AppColors.lightGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
