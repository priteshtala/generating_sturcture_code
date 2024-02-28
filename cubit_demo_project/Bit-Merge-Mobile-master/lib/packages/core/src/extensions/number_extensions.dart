import 'package:intl/intl.dart';

extension $NumberExtension on num? {
  String formattedAmount([int? decimalDigits]) {
    final NumberFormat numberFormat = NumberFormat.currency(
      locale: "en",
      customPattern: '##,###.##',
      decimalDigits: decimalDigits ?? 2,
    );
    final String amountString = numberFormat.format(this ?? 0);
    return amountString;
  }


  double fromApiAmount() {
    return this == null ? 0 : this! * 0.000000000000000001;
  }
}
