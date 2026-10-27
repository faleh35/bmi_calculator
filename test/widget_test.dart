import 'package:bmi_calcuator/bmi.dart';
import 'package:bmi_calcuator/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Bmi', () {
    test('calculates value from height and weight', () {
      expect(Bmi(heightCm: 180, weightKg: 81).value, closeTo(25.0, 0.001));
    });

    test('maps values to categories', () {
      expect(
          Bmi(heightCm: 180, weightKg: 55).category, BmiCategory.underweight);
      expect(Bmi(heightCm: 180, weightKg: 70).category, BmiCategory.normal);
      expect(Bmi(heightCm: 180, weightKg: 90).category, BmiCategory.overweight);
      expect(Bmi(heightCm: 180, weightKg: 110).category, BmiCategory.obese);
    });

    test('uses category boundaries as lower bounds', () {
      // At 1 m height the BMI equals the weight.
      expect(Bmi(heightCm: 100, weightKg: 25).category, BmiCategory.overweight);
      expect(Bmi(heightCm: 100, weightKg: 30).category, BmiCategory.obese);
    });

    test('gives healthy weight range for height', () {
      final bmi = Bmi(heightCm: 200, weightKg: 80);
      expect(bmi.minHealthyWeight, closeTo(74.0, 0.001));
      expect(bmi.maxHealthyWeight, closeTo(100.0, 0.001));
    });
  });

  testWidgets('increments age and weight', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('25'), findsOneWidget);
    expect(find.text('70'), findsOneWidget);

    await tester.tap(find.byTooltip('Increase Age'));
    await tester.tap(find.byTooltip('Decrease Weight'));
    await tester.pump();

    expect(find.text('26'), findsOneWidget);
    expect(find.text('69'), findsOneWidget);
  });

  testWidgets('shows result screen and returns', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('CALCULATE'));
    await tester.pumpAndSettle();

    // Defaults: 170 cm, 70 kg -> BMI 24.2.
    expect(find.text('24.2'), findsOneWidget);
    expect(find.text('NORMAL'), findsOneWidget);

    await tester.tap(find.text('RECALCULATE'));
    await tester.pumpAndSettle();

    expect(find.text('BMI Calculator'), findsOneWidget);
  });
  testWidgets('fits a small phone and warns under 18', (tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(320, 568);
    tester.binding.window.devicePixelRatioTestValue = 1;
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);

    await tester.pumpWidget(const MyApp());
    for (var i = 0; i < 10; i++) {
      await tester.tap(find.byTooltip('Decrease Age'));
      await tester.pump();
    }
    await tester.tap(find.text('CALCULATE'));
    await tester.pumpAndSettle();

    expect(find.textContaining('children and teens'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();
    expect(find.text('15'), findsOneWidget);
  });
}
