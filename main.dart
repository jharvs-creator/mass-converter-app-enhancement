import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MassConverter(),
    );
  }
}

class MassConverter extends StatefulWidget {
  @override
  _MassConverterState createState() => _MassConverterState();
}

class _MassConverterState extends State<MassConverter> {
  TextEditingController controller = TextEditingController();

  String selectedUnit = ("Kilogram");
  double result = 0;

  void convert() {
    double value = double.parse(controller.text);

    if (selectedUnit == "Kilogram") {
      result = value * 1000; // kg to gram
    } else {
      result = value / 1000; // gram to kg
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mass Converter"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Value",
              ),
            ),

            SizedBox(height: 20),

            DropdownButton<String>(
              value: selectedUnit,
              isExpanded: true,
              items: [
                DropdownMenuItem(
                  value: "Kilogram",
                  child: Text("Kilogram to Gram"),
                ),
                DropdownMenuItem(
                  value: "Gram",
                  child: Text("Gram to Kilogram"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedUnit = value!;
                });
              },
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: convert,
              child: Text("Convert"),
            ),

            SizedBox(height: 20),

            Text(
              "Result: $result",
              style: TextStyle(fontSize: 32),
            ),
          ],
        ),
      ),
    );
  }
}