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

  String fromUnit = 'Gram';
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
                    const Text('From:',
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
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.input_rounded,
                            color: Color(0xff168a52),
                          ),
                        ),
                        items: units.map((unit){
                          return DropdownMenuItem(value: unit, child:Text(unit));
                        }).toList(),

                        onChanged: (value){
                          if (value != null) {
                            setState(() => fromUnit = value);
                          }
                        }),

                    const SizedBox(height: 16),

                    Center(
                      child: IconButton.filled(
                        onPressed: swapUnits,
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xffd9f1e2),
                          foregroundColor: const Color(0xff168a52),
                        ),
                        icon: const Icon(Icons.swap_vert_rounded),
                        tooltip: 'Swap units',
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text('To:',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff126b40),
                      ),
                    ),

                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                        initialValue: toUnit,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.output_rounded,
                            color: Color(0xff168a52),
                          ),
                        ),
                        items: units.map((unit){
                          return DropdownMenuItem(value: unit, child:Text(unit));
                        }).toList(),

                        onChanged: (value){
                          if (value != null) {
                            setState(() => toUnit = value);
                          }
                        }),

                    const SizedBox(height: 22),

                    const Text('Value',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff126b40),
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                        controller: controller,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                            hintText: 'Enter a value'
                        )
                    ),

                    const SizedBox(height: 22),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton.icon(
                          onPressed: convert,
                          label: const Text(
                            'Convert',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xff168a52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: clear,
                        label: const Text(
                          'Clear',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xff168a52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),

            if (result.isNotEmpty) ...[
              const SizedBox(height: 20),

              Card(
                color: const Color(0xffd9f1e2),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      const Text('Result',
                          style: TextStyle(
                              color: Color(0xff126b40),
                              fontWeight: FontWeight.bold,
                          ),
                      ),

                      const SizedBox(height: 6),
                      Text(
                        '$result $toUnit',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xff126b40),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )
                      ),

                    ],
                  ),
                ),
              )

            ],

            const SizedBox(height: 40),

            const Text('COPYRIGHT © 2026 | Jharvey Owen Tamayo ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),

          ],
        ),

      ),

    );
  }
}