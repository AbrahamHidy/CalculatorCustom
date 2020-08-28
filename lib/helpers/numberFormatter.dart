import 'package:math_expressions/math_expressions.dart';

abstract class NumberFormatter {
  static String format(double toFormat) {
    double input = toFormat;
    String inputString = input.toString();
    if (inputString.endsWith('.0')) {
      return inputString.substring(0, inputString.length - 2);
    }
    return inputString;
  }
}
