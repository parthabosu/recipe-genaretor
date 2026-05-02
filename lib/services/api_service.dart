import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe_model.dart';
import '../utils/constants.dart';

class ApiService {
  static Future<Recipe> generateRecipe({
    required List<String> veg,
    required List<String> nonVeg,
    required String cuisine,
    required String spice,
    required String language,
  }) async {
    final prompt = """
    Create a detailed recipe in $language language.
    Ingredients: Veg: ${veg.join(', ')}, Non-Veg: ${nonVeg.join(', ')}.
    Cuisine: $cuisine, Spice Level: $spice.
    Return ONLY a JSON object with this structure:
    {
      "name": "Recipe Title",
      "description": "Short description",
      "ingredients": ["item 1", "item 2"],
      "steps": ["step 1", "step 2"],
      "cookingTime": "30 mins",
      "calories": "400 kcal",
      "tips": "One secret tip"
    }
    """;

    try {
      final response = await http.post(
        Uri.parse(AppConstants.apiUrl),
        headers: {
          'Authorization': 'Bearer ${AppConstants.apiKey}',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://smartrecipeai.com', // Required by OpenRouter
        },
        body: jsonEncode({
          'model': AppConstants.aiModel,
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'];
        // Remove markdown code blocks if AI includes them
        final cleanJson = content.replaceAll(RegExp(r'```json|```'), '');
        return Recipe.fromJson(jsonDecode(cleanJson));
      } else {
        throw Exception("Failed to connect to AI");
      }
    } catch (e) {
      throw Exception("Error generating recipe: $e");
    }
  }
}
