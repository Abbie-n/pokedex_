import 'dart:math';

import 'package:pokedex/features/model/pokemon_details_model.dart';
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

  static double getProgress(int stat) => stat / 100;
}
