import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weight Converter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            primary: Colors.green,
            surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xfff2faf5),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xffc8dfd1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xffc8dfd1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
        ),
      ),
      home: MassConverter(),
    );
  }
}

class MassConverter extends StatefulWidget {
  @override
  _MassConverterState createState() => _MassConverterState();
}

class _MassConverterState extends State<MassConverter> {
  final TextEditingController controller = TextEditingController();

  String fromUnit = 'Tonne';
  String toUnit = 'Kilogram';
  String result = '';

  final Map<String, double> gramsPerUnit = {
    'Tonne': 1000000,
    'Kilogram': 1000,
    'Gram': 1,
    'Milligram': 0.001,
    'Microgram': 0.000001,
    'Imperial Ton': 1016046.9088,
    'US Ton': 907184.74,
    'Stone': 6350.29318,
    'Pound': 453.59237,
    'Ounce': 28.349523125,
  };

  void convert() {
    final input = double.tryParse(controller.text);

    if (input ==null) {
      setState((){
        result = 'Please enter a valid number';
      });
      return;
    }

    final grams = input * gramsPerUnit[fromUnit]!;
    final convertedValue = grams / gramsPerUnit[toUnit]!;

    setState(() {
      result = convertedValue.toStringAsFixed(2);
    });
  }

  void clear() {
    setState(() {
      controller.clear();
      result = '';
    });
  }

  void swapUnits() {
    setState(() {
      final temporary = fromUnit;
      fromUnit = toUnit;
      toUnit = temporary;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final units = gramsPerUnit.keys.toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF168a52),
        foregroundColor: Colors.white,
        title: const Text("Mass Converter", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 22),

            Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                  padding: const  EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Convert From',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF126B40),
                      ),
                    ),

                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                        initialValue: fromUnit,
                        isExpanded: true,
                        items: units.map((unit){
                          return DropdownMenuItem(value: unit, child:Text(unit));
                        }).toList(),

                        onChanged: (value){
                          if (value != null) {
                            setState(() => fromUnit = value);
                          }
                        })
                  ],
                ),
              ),

            )

          ],
        ),

      ),

    );
  }
}