import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share_plus/share_plus.dart';
import '../services/api_service.dart';
import '../models/recipe_model.dart';
import '../utils/constants.dart';

class RecipeScreen extends StatefulWidget {
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  Recipe? recipe;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (recipe == null) fetchRecipe();
  }

  void fetchRecipe() async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    setState(() => isLoading = true);
    try {
      final res = await ApiService.generateRecipe(
        veg: args['veg'], nonVeg: args['nonVeg'], cuisine: args['cuisine'], spice: args['spice'], language: args['lang']
      );
      setState(() { recipe = res; isLoading = false; });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error generating recipe!")));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe?.name ?? "Generating...")),
      body: isLoading 
        ? Center(child: SpinKitFadingCircle(color: AppColors.primary, size: 50))
        : SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe!.description, style: TextStyle(fontStyle: FontStyle.italic)),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("⏱ ${recipe!.cookingTime}"),
                    Text("🔥 ${recipe!.calories}"),
                  ],
                ),
                SizedBox(height: 20),
                Text("Ingredients:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ...recipe!.ingredients.map((e) => Text("• $e")),
                SizedBox(height: 20),
                Text("Steps:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ...recipe!.steps.asMap().entries.map((e) => Text("${e.key + 1}. ${e.value}")),
                SizedBox(height: 20),
                Text("Chef's Tip:", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary)),
                Text(recipe!.tips),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(child: ElevatedButton(onPressed: fetchRecipe, child: Text("Regenerate"))),
                    SizedBox(width: 10),
                    Expanded(child: ElevatedButton(onPressed: () => Share.share(recipe!.name), child: Text("Share"))),
                  ],
                )
              ],
            ),
          ),
    );
  }
}
