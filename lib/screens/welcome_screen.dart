import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu, size: 100, color: AppColors.primary),
            SizedBox(height: 20),
            Text("Smart Recipe AI", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary)),
            SizedBox(height: 10),
            Text("Turn ingredients into delicious recipes using AI", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            SizedBox(height: 50),
            CustomButton(
              text: "Get Started",
              onPressed: () => Navigator.pushNamed(context, '/language'),
            ),
          ],
        ),
      ),
    );
  }
}
