import 'package:intl/intl.dart';

extension DoubleExtensions on double {

  String asCurrencyWith2Decimals() {
    final formatter = NumberFormat.currency(
      symbol: "\$", // or set to your currency symbol
      decimalDigits: 2,
    );
    return formatter.format(this);
  }

  String asCurrencyWith6Decimals() {
    final formatter = NumberFormat.currency(
      symbol: "\$", // or set to your currency symbol
      decimalDigits: 6,
    );
    return formatter.format(this);
  }

  String asNumberString() {
    return toStringAsFixed(2);
  }

  String asPercentString() {
    return '${asNumberString()}%';
  }

  String formattedWithAbbreviations() {
    final num = this.abs();
    final sign = this < 0 ? "-" : "";

    if (num >= 1000000000000) {
      final formatted = num / 1000000000000;
      return '$sign${formatted.toStringAsFixed(2)}Tr';
    } else if (num >= 1000000000) {
      final formatted = num / 1000000000;
      return '$sign${formatted.toStringAsFixed(2)}Bn';
    } else if (num >= 1000000) {
      final formatted = num / 1000000;
      return '$sign${formatted.toStringAsFixed(2)}M';
    } else if (num >= 1000) {
      final formatted = num / 1000;
      return '$sign${formatted.toStringAsFixed(2)}K';
    } else {
      return asNumberString();
    }
  }
}
