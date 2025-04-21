import 'package:flutter/material.dart';
import 'package:dam_project/features/recipe/model/recipe_model.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Exibindo a imagem
            Image.network(recipe.image, fit: BoxFit.cover),
            const SizedBox(height: 16),

            // Exibindo o nome da receita
            Text(
              recipe.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Exibindo informações como calorias e tempo de preparo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.local_fire_department, color: Colors.orange),
                Text("${recipe.caloriesPerServing} Cal"),
                const SizedBox(width: 16),
                const Icon(Icons.timer, color: Colors.blue),
                Text("${recipe.prepTimeMinutes + recipe.cookTimeMinutes} min"),
              ],
            ),
            const SizedBox(height: 12),

            // Exibindo a avaliação da receita
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text("${recipe.rating}/5"),
              ],
            ),
            const SizedBox(height: 24),

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
                    ...recipe.ingredients.map((i) => Text("• $i")).toList(),
                  ],
                ),
              ),

            const SizedBox(height: 24),

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

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
