import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:dam_project/features/favorites/controller/favorites_controller.dart';
import 'package:dam_project/features/recipe/model/recipe_model.dart';
import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:dam_project/utils/device/device_utils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;
    final screenHeight = DeviceUtils.getScreenHeight(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildBottomButtons(context), // Alterado aqui
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Imagem
                Hero(
                  tag: recipe.image,
                  child: Container(
                    height: screenHeight / 2.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(recipe.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // Botão de voltar
                Positioned(
                  top: 50,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: AppColors.softBlack,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Indicador de arrasto
            Center(
              child: Container(
                width: 40,
                height: 8,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            // Conteúdo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Calorias e tempo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 5),
                      Text("${recipe.caloriesPerServing} Cal"),
                      const SizedBox(width: 16),
                      const Icon(Icons.timer, color: Colors.blue),
                      const SizedBox(width: 5),
                      Text(
                        "${recipe.prepTimeMinutes + recipe.cookTimeMinutes} min",
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Avaliação
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        itemSize: 20,
                        initialRating: recipe.rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder:
                            (context, _) =>
                                const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (value) {},
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${recipe.rating}/5",
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "(${recipe.reviewCount} reviews)",
                        style: TextStyle(color: AppColors.softBlack),
                      ),
                    ],
                  ),

                  // Exibindo os ingredientes
                  if (recipe.ingredients.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Ingredients",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...recipe.ingredients
                              .map((i) => Text("• $i"))
                              .toList(),
                        ],
                      ),
                    ),

                  const SizedBox(height: 8),

                  // Exibindo as instruções de preparo
                  if (recipe.instructions.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Instructions",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...recipe.instructions
                              .map(
                                (step) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("• $step"),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),

                  const SizedBox(height: 45),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Botões inferiores: Start Cooking + Favorite
  Widget buildBottomButtons(BuildContext context) {
    final favoritesController = Provider.of<FavoritesController>(context);
    final recipe = widget.recipe; // Acessando corretamente `recipe` aqui
    final isFavorite = favoritesController.isFavorite(recipe.id);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 13),
              foregroundColor: AppColors.white,
            ),
            onPressed: () {
              // ação do botão
            },
            child: const Text(
              "Start Cooking",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),

          // Botão de favorito
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.lightGrey, width: 2),
            ),
            child: IconButton(
              onPressed: () {
                favoritesController.toggleFavorite(recipe.id);
              },
              icon: Icon(
                isFavorite ? Iconsax.heart5 : Iconsax.heart,
                color: isFavorite ? Colors.red : AppColors.softBlack,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
