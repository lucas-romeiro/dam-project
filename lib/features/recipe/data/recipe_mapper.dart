import 'dart:convert';
import 'package:dam_project/features/recipe/model/recipes_model.dart';

RecipesModel recipesModelFromJson(String str) =>
    RecipesModel.fromJson(json.decode(str));

String recipesModelToJson(RecipesModel data) => json.encode(data.toJson());
