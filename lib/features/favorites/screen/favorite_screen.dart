import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:dam_project/features/favorites/controller/favorites_controller.dart';
import 'package:dam_project/features/recipe/model/recipe_model.dart';
import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:dam_project/features/recipe/controller/recipe_controller.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<void> _loadFavoritesFuture;

  @override
  void initState() {
    super.initState();
    _loadFavoritesFuture =
        Provider.of<FavoritesController>(
          context,
          listen: false,
        ).loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesController = Provider.of<FavoritesController>(context);
    final recipeController = Provider.of<RecipeController>(context);

    final favoriteItems = recipeController.getFavoriteRecipes(
      favoritesController.favoriteRecipeIds,
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: const Text(
          "Favorites Recipes",
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black),
        ),
      ),
      body: FutureBuilder(
        future: _loadFavoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Error loading favorites",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

          if (favoriteItems.isEmpty) {
            return const Center(
              child: Text(
                "You haven't favorited recipes yet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            itemCount: favoriteItems.length,
            itemBuilder: (context, index) {
              Recipe favorite = favoriteItems[index];
              return Dismissible(
                key: Key(favorite.id.toString()),
                background: Container(
                  color: AppColors.error,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: AppColors.white),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  favoritesController.toggleFavorite(favorite.id);

                  setState(() {
                    favoriteItems.removeAt(index);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.softGrey,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(favorite.image),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                favorite.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(
                                    Iconsax.flash_1,
                                    size: 16,
                                    color: AppColors.darkerGrey,
                                  ),
                                  Text(
                                    "${favorite.caloriesPerServing} Cal",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkerGrey,
                                    ),
                                  ),
                                  const Text(
                                    " . ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.darkerGrey,
                                    ),
                                  ),
                                  const Icon(
                                    Iconsax.clock,
                                    size: 16,
                                    color: AppColors.darkerGrey,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${favorite.prepTimeMinutes + favorite.cookTimeMinutes} Min",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkerGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
