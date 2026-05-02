import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLang = "English";
  final List<String> languages = ["English", "Hindi", "Bengali", "French", "German", "Persian", "Turkish"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Language")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) => RadioListTile(
                  title: Text(languages[index]),
                  value: languages[index],
                  groupValue: selectedLang,
                  onChanged: (val) => setState(() => selectedLang = val.toString()),
                ),
              ),
            ),
            CustomButton(
              text: "Next",
              onPressed: () => Navigator.pushNamed(context, '/ingredients', arguments: selectedLang),
            ),
          ],
        ),
      ),
    );
  }
}
