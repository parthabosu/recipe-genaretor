import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';

class IngredientScreen extends StatefulWidget {
  @override
  _IngredientScreenState createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  List<String> veg = [];
  List<String> nonVeg = [];
  String cuisine = "Indian";
  String spice = "Medium";
  TextEditingController vegController = TextEditingController();
  TextEditingController nonVegController = TextEditingController();

  void addNonVeg(String value) {
    if (nonVeg.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Max 5 Non-Veg items allowed!")));
    } else if (value.isNotEmpty) {
      setState(() => nonVeg.add(value));
      nonVegController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String language = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text("Add Ingredients")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Veg Ingredients", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
            TextField(controller: vegController, decoration: InputDecoration(hintText: "Enter veg and press Enter"),
              onSubmitted: (v) { setState(() => veg.add(v)); vegController.clear(); }),
            Wrap(children: veg.map((e) => Chip(label: Text(e), onDeleted: () => setState(() => veg.remove(e)))).toList()),
            
            SizedBox(height: 20),
            Text("Non-Veg (Max 5)", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            TextField(controller: nonVegController, decoration: InputDecoration(hintText: "Enter non-veg and press Enter"),
              onSubmitted: addNonVeg),
            Wrap(children: nonVeg.map((e) => Chip(label: Text(e), onDeleted: () => setState(() => nonVeg.remove(e)))).toList()),

            SizedBox(height: 20),
            DropdownButtonFormField(value: cuisine, items: ["Indian", "Chinese", "Italian", "Turkish", "Continental"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), 
              onChanged: (v) => cuisine = v.toString(), decoration: InputDecoration(labelText: "Cuisine")),

            SizedBox(height: 40),
            CustomButton(text: "Generate Recipe", onPressed: () {
              Navigator.pushNamed(context, '/recipe', arguments: {
                'veg': veg, 'nonVeg': nonVeg, 'cuisine': cuisine, 'spice': spice, 'lang': language
              });
            }),
          ],
        ),
      ),
    );
  }
}
