import 'package:bmi_calcuator/bmi.dart';
import 'package:bmi_calcuator/widgets.dart';
import 'package:flutter/material.dart';

class BMIResults extends StatelessWidget {
  final Bmi bmi;
  final int age;
  final bool isMale;

  const BMIResults({
    Key? key,
    required this.bmi,
    required this.age,
    required this.isMale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = bmi.category;
    return Scaffold(
      appBar: AppBar(title: const Text('Your Result')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  category.label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: category.color,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  bmi.value.toStringAsFixed(1),
                  style: numberStyle.copyWith(fontSize: 80),
                ),
                const Text('BMI', style: labelStyle),
                const SizedBox(height: 20),
                _BmiScale(category: category),
                const SizedBox(height: 20),
                const Text(
                  'Normal BMI range: ${Bmi.underweightLimit} – '
                  '${Bmi.normalLimit} kg/m²',
                  style: TextStyle(color: labelColor, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  'Healthy weight for ${bmi.heightCm} cm: '
                  '${bmi.minHealthyWeight.toStringAsFixed(1)} – '
                  '${bmi.maxHealthyWeight.toStringAsFixed(1)} kg',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: labelColor, fontSize: 16),
                ),
                const SizedBox(height: 20),
                Text(
                  category.advice,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                if (age < Bmi.adultAge) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Note: adult BMI categories are less accurate for '
                    'children and teens. Ask a doctor about age-specific '
                    'BMI percentiles.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.amberAccent, fontSize: 14),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _Detail(label: 'Gender', value: isMale ? 'Male' : 'Female'),
              _Detail(label: 'Age', value: '$age'),
              _Detail(label: 'Height', value: '${bmi.heightCm} cm'),
              _Detail(label: 'Weight', value: '${bmi.weightKg} kg'),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomButton(
        label: 'Recalculate',
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}

/// Coloured bar with one segment per category; the user's segment is
/// highlighted.
class _BmiScale extends StatelessWidget {
  final BmiCategory category;

  const _BmiScale({required this.category});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final c in BmiCategory.values)
          Expanded(
            child: Column(
              children: [
                Container(
                  height: c == category ? 14 : 8,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: c == category ? c.color : c.color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  child: Text(
                    c.label,
                    style: TextStyle(
                      fontSize: 12,
                      color: c == category ? Colors.white : labelColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Detail extends StatelessWidget {
  final String label;
  final String value;

  const _Detail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            Text(label.toUpperCase(),
                style: const TextStyle(color: labelColor, fontSize: 12)),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
