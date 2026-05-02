import 'dart:convert';

class Recipe {
  final String name;
  final String description;
  final List<String> ingredients;
  final List<String> steps;
  final String cookingTime;
  final String calories;
  final String tips;

  Recipe({
    required this.name,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.cookingTime,
    required this.calories,
    required this.tips,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'] ?? 'Tasty Recipe',
      description: json['description'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      steps: List<String>.from(json['steps'] ?? []),
      cookingTime: json['cookingTime'] ?? 'N/A',
      calories: json['calories'] ?? 'N/A',
      tips: json['tips'] ?? '',
    );
  }
}
