import 'package:flutter/material.dart';

void main() => runApp(BMICalculatorApp());

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: BMICalculatorPage(),
    );
  }
}

class BMICalculatorPage extends StatefulWidget {
  @override
  _BMICalculatorPageState createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  double? bmi;
  String result = "";

  void calculateBMI() {
    final double? height = double.tryParse(heightController.text);
    final double? weight = double.tryParse(weightController.text);

    if (height != null && weight != null && height > 0 && weight > 0) {
      final double bmiValue = weight / ((height / 100) * (height / 100));
      String category = "";

      if (bmiValue < 18.5) {
        category = "Underweight";
      } else if (bmiValue < 24.9) {
        category = "Normal weight";
      } else if (bmiValue < 29.9) {
        category = "Overweight";
      } else {
        category = "Obese";
      }

      setState(() {
        bmi = bmiValue;
        result = category;
      });
    } else {
      setState(() {
        bmi = null;
        result = "Invalid input!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Height (cm)'),
            ),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Weight (kg)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 30),
            if (bmi != null)
              Column(
                children: [
                  Text('Your BMI: ${bmi!.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 24)),
                  Text('Category: $result',
                      style: TextStyle(fontSize: 20, color: Colors.teal)),
                ],
              ),
            if (bmi == null && result.isNotEmpty)
              Text(result,
                  style: TextStyle(fontSize: 20, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
