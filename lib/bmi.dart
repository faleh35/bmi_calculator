import 'dart:math';

import 'package:flutter/material.dart';

/// WHO adult BMI categories.
enum BmiCategory { underweight, normal, overweight, obese }

extension BmiCategoryInfo on BmiCategory {
  String get label {
    switch (this) {
      case BmiCategory.underweight:
        return 'Underweight';
      case BmiCategory.normal:
        return 'Normal';
      case BmiCategory.overweight:
        return 'Overweight';
      case BmiCategory.obese:
        return 'Obese';
    }
  }

  Color get color {
    switch (this) {
      case BmiCategory.underweight:
        return Colors.lightBlueAccent;
      case BmiCategory.normal:
        return Colors.greenAccent;
      case BmiCategory.overweight:
        return Colors.orangeAccent;
      case BmiCategory.obese:
        return Colors.redAccent;
    }
  }

  String get advice {
    switch (this) {
      case BmiCategory.underweight:
        return 'You have a lower than normal body weight. '
            'Consider eating a bit more and talking to a doctor.';
      case BmiCategory.normal:
        return 'You have a normal body weight. Good job!';
      case BmiCategory.overweight:
        return 'You have a higher than normal body weight. '
            'Try to exercise more.';
      case BmiCategory.obese:
        return 'Your body weight is well above normal. '
            'Consider talking to a doctor.';
    }
  }
}

class Bmi {
  static const double underweightLimit = 18.5;
  static const double normalLimit = 25;
  static const double overweightLimit = 30;

  /// BMI categories are defined for adults only.
  static const int adultAge = 18;

  final int heightCm;
  final int weightKg;
  final double value;

  Bmi({required this.heightCm, required this.weightKg})
      : value = weightKg / pow(heightCm / 100, 2);

  BmiCategory get category {
    if (value < underweightLimit) return BmiCategory.underweight;
    if (value < normalLimit) return BmiCategory.normal;
    if (value < overweightLimit) return BmiCategory.overweight;
    return BmiCategory.obese;
  }

  /// Weight range (kg) that gives a normal BMI for this height.
  double get minHealthyWeight => underweightLimit * pow(heightCm / 100, 2);

  double get maxHealthyWeight => normalLimit * pow(heightCm / 100, 2);
}
