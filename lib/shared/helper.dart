import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex/features/model/pokemon_details_model.dart';
import 'package:pokedex/shared/colors.dart';
import 'package:pokedex/shared/extensions/string_extension.dart';

class Helper {
  static String concatenateString(List<Types> data) {
    final stringList = <String>[];

    for (final x in data) {
      if (x.type?.name == null) {
        return '';
      }

      stringList.add(x.type!.name!.capitalize);
    }
    return stringList.reduce((value, element) => '$value, $element');
  }

  static String getBMI(int weight, int height) =>
      (weight / pow(height, 2)).toStringAsFixed(2);

  static String getAvgPower(List<Stats> stats) =>
      (stats.fold(0, (prev, e) => e.baseStat! + prev) / 6).toStringAsFixed(2);

  static double getProgress(num stat) => stat / 100;

  static Color getProgressColor(double progress) {
    if (progress <= .4) {
      return AppColors.progressOne;
    } else if (progress <= .6) {
      return AppColors.progressTwo;
    }

    return AppColors.progressThree;
  }

  static Color getContainerColor(String type) {
    if (type.toLowerCase().contains('grass')) {
      return AppColors.grass;
    } else if (type.toLowerCase().contains('fire')) {
      return AppColors.fire;
    } else if (type.toLowerCase().contains('water')) {
      return AppColors.water;
    }

    return AppColors.lightPurple.withOpacity(.3);
  }

  static Color getAvgPowerProgressColor(String stat) {
    final convertToDouble = double.parse(stat);

    if (convertToDouble <= 40) {
      return AppColors.progressOne;
    } else if (convertToDouble <= 60) {
      return AppColors.progressTwo;
    }

    return AppColors.progressThree;
  }
}
