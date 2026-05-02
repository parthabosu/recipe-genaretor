import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/welcome_screen.dart';
import 'screens/language_screen.dart';
import 'screens/ingredient_screen.dart';
import 'screens/recipe_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(SmartRecipeAI());
}

class SmartRecipeAI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Recipe AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/language': (context) => LanguageScreen(),
        '/ingredients': (context) => IngredientScreen(),
        '/recipe': (context) => RecipeScreen(),
      },
    );
  }
}
