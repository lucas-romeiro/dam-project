import 'package:dam_project/features/authentication/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dam_project/common/widgets/menu_selector.dart';
import 'package:dam_project/features/home/screens/widgets/home_banner.dart';
import 'package:dam_project/features/recipe/screen/recipe_card.dart';
import 'package:dam_project/features/recipe/controller/recipe_controller.dart';
import 'package:dam_project/features/authentication/controller/auth_controller.dart';
import 'package:dam_project/common/widgets/textfield.dart';
import 'package:dam_project/utils/constants/app_colors.dart';
import 'package:dam_project/utils/device/device_utils.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final recipeController = context.watch<RecipeController>();
    final user = context.watch<AuthController>().loggedUser;

    final isLoading = recipeController.isLoading;
    final recipes = recipeController.recipes;
    final error = recipeController.error;
    final selectedIndex = recipeController.selectedIndex;
    final menuItems = recipeController.categories;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : error != null
                ? Center(child: Text("Erro: $error"))
                : recipes.isEmpty
                ? const Center(child: Text("Nenhuma receita encontrada."))
                : SingleChildScrollView(
                  child: Column(
                    children: [
                      headerPart(user),
                      const SizedBox(height: 20),
                      InputField(
                        label: "Search any recipe",
                        icon: Icons.search,
                        controller: _searchController,
                        // onChanged:
                        //     (value) => recipeController.searchRecipes(value),
                      ),

                      const SizedBox(height: 20),

                      // Banner
                      SizedBox(
                        width: DeviceUtils.getScreenWidth(context) * .9,
                        child: HomeBanner(),
                      ),
                      const SizedBox(height: 40),

                      // Categories
                      categories(),
                      const SizedBox(height: 20),

                      MenuItemSelector(
                        menuItems: menuItems,
                        selectedIndex: selectedIndex,
                        onItemSelected: (index) {
                          recipeController.setSelectedIndex(index);
                        },
                      ),

                      const SizedBox(height: 20),

                      // Recipe Card
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(recipes.length, (index) {
                            final recipe = recipes[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? 20 : 10,
                                right: 10,
                              ),
                              child: RecipeCard(
                                recipe: recipe,
                                width:
                                    DeviceUtils.getScreenWidth(context) / 2.45,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  Padding categories() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Categories",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Text(
            "See all",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Padding headerPart(User? user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Hello ${user?.fullName ?? 'world'},\n",
                  style: const TextStyle(fontSize: 16),
                ),
                const TextSpan(
                  text: "What do you want to eat today?",
                  style: TextStyle(fontSize: 13, color: Colors.black45),
                ),
              ],
            ),
          ),
          const Spacer(),
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/images/login/no-user.png"),
          ),
        ],
      ),
    );
  }
}
