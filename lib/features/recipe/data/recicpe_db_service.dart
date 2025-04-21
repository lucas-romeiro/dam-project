import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:dam_project/features/recipe/model/recipe_model.dart';
import 'package:dam_project/utils/constants/app_enums.dart';

class RecipeDbService {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'recipes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE recipes (
            id INTEGER PRIMARY KEY,
            name TEXT,
            ingredients TEXT,
            instructions TEXT,
            prepTimeMinutes INTEGER,
            cookTimeMinutes INTEGER,
            servings INTEGER,
            difficulty TEXT,
            cuisine TEXT,
            caloriesPerServing INTEGER,
            tags TEXT,
            userId INTEGER,
            image TEXT,
            rating REAL,
            reviewCount INTEGER,
            mealType TEXT
          )
        ''');

        await db.execute('''CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            recipeId INTEGER,
            FOREIGN KEY(recipeId) REFERENCES recipes(id)
          )
        ''');
      },
    );
  }

  // Salvar a receita favorita
  Future<void> toggleFavorite(int recipeId) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'recipeId = ?',
      whereArgs: [recipeId],
    );

    if (result.isEmpty) {
      // Adicionar aos favoritos
      await db.insert('favorites', {'recipeId': recipeId});
    } else {
      // Remover dos favoritos
      await db.delete(
        'favorites',
        where: 'recipeId = ?',
        whereArgs: [recipeId],
      );
    }
  }

  // Verificar se a receita está favoritada
  Future<bool> isFavorite(int recipeId) async {
    final db = await database;
    final result = await db.query(
      'favorites',
      where: 'recipeId = ?',
      whereArgs: [recipeId],
    );

    return result.isNotEmpty;
  }

  // Obter todas as receitas favoritas
  Future<List<int>> getFavoriteRecipeIds() async {
    final db = await database;
    final result = await db.query('favorites');
    return result.map((e) => e['recipeId'] as int).toList();
  }

  // Salvar várias receitas
  Future<void> saveRecipes(List<Recipe> recipes) async {
    final db = await database;
    for (var recipe in recipes) {
      await db.insert('recipes', {
        'id': recipe.id,
        'name': recipe.name,
        'ingredients': recipe.ingredients.join(';'),
        'instructions': recipe.instructions.join(';'),
        'prepTimeMinutes': recipe.prepTimeMinutes,
        'cookTimeMinutes': recipe.cookTimeMinutes,
        'servings': recipe.servings,
        'difficulty': recipe.difficulty.name,
        'cuisine': recipe.cuisine,
        'caloriesPerServing': recipe.caloriesPerServing,
        'tags': recipe.tags.join(';'),
        'userId': recipe.userId,
        'image': recipe.image,
        'rating': recipe.rating,
        'reviewCount': recipe.reviewCount,
        'mealType': recipe.mealType.join(';'),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  // Obter todas as receitas
  Future<List<Recipe>> getAllRecipes() async {
    final db = await database;
    final maps = await db.query('recipes');

    return maps.map((map) {
      return Recipe(
        id: map['id'] as int,
        name: map['name'] as String,
        ingredients: (map['ingredients'] as String).split(
          ';',
        ), // Usando ; para separar
        instructions: (map['instructions'] as String).split(';'),
        prepTimeMinutes: map['prepTimeMinutes'] as int,
        cookTimeMinutes: map['cookTimeMinutes'] as int,
        servings: map['servings'] as int,
        difficulty: difficultyValues.map[map['difficulty']]!,
        cuisine: map['cuisine'] as String,
        caloriesPerServing: map['caloriesPerServing'] as int,
        tags: (map['tags'] as String).split(';'),
        userId: map['userId'] as int,
        image: map['image'] as String,
        rating: (map['rating'] as num).toDouble(),
        reviewCount: map['reviewCount'] as int,
        mealType: (map['mealType'] as String).split(';'),
      );
    }).toList();
  }
}
