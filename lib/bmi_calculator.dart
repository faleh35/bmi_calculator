import 'package:bmi_calcuator/bmi.dart';
import 'package:bmi_calcuator/bmi_results.dart';
import 'package:bmi_calcuator/widgets.dart';
import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  static const int minHeight = 100;
  static const int maxHeight = 220;
  static const int minAge = 2;
  static const int maxAge = 120;
  static const int minWeight = 20;
  static const int maxWeight = 250;

  const BMICalculator({Key? key}) : super(key: key);

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  int userHeight = 170;
  int age = 25;
  int weight = 70;
  bool isMale = true;

  void _calculate() {
    final bmi = Bmi(heightCm: userHeight, weightKg: weight);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BMIResults(bmi: bmi, age: age, isMale: isMale),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GenderCard(
                      icon: Icons.male,
                      label: 'Male',
                      selected: isMale,
                      onTap: () => setState(() => isMale = true),
                    ),
                  ),
                  Expanded(
                    child: GenderCard(
                      icon: Icons.female,
                      label: 'Female',
                      selected: !isMale,
                      onTap: () => setState(() => isMale = false),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _buildHeightCard()),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CounterCard(
                      label: 'Age',
                      value: age,
                      min: BMICalculator.minAge,
                      max: BMICalculator.maxAge,
                      onChanged: (value) => setState(() => age = value),
                    ),
                  ),
                  Expanded(
                    child: CounterCard(
                      label: 'Weight',
                      unit: 'KG',
                      value: weight,
                      min: BMICalculator.minWeight,
                      max: BMICalculator.maxWeight,
                      onChanged: (value) => setState(() => weight = value),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButton(
        label: 'Calculate',
        onPressed: _calculate,
      ),
    );
  }

  Widget _buildHeightCard() {
    return InfoCard(
      child: FittedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('HEIGHT', style: labelStyle),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text('$userHeight', style: numberStyle),
                const Text(' CM', style: labelStyle),
              ],
            ),
            SizedBox(
              width: 300,
              child: Slider(
                value: userHeight.toDouble(),
                min: BMICalculator.minHeight.toDouble(),
                max: BMICalculator.maxHeight.toDouble(),
                divisions: BMICalculator.maxHeight - BMICalculator.minHeight,
                label: '$userHeight cm',
                activeColor: activeCardColor,
                inactiveColor: Colors.black26,
                onChanged: (value) =>
                    setState(() => userHeight = value.round()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
