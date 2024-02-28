import 'package:bit_merge_mobile/packages/core/core.dart';
import 'package:intl/intl.dart';

extension $StringExtension on String {
  DateTime parseUtcDateTime([String format = "yyyy-MM-dd HH:mm:ss"]) {
    var time = DateFormat(format).parseUTC(replaceAll("T", " ").replaceAll("Z", " "));
    return time;
  }

  DateTime parseLocalDateTime([String format = "yyyy-MM-dd HH:mm:ss"]) {
    var time = DateFormat(format).parse(replaceAll("T", " ").replaceAll("Z", " "));
    return time;
  }

  String toLocalString([String format = "yyyy-MM-dd HH:mm:ss"]) {
    var time = DateTime.parse(this).toLocalString(format);
    return time.toString();
  }

  String emailFormat([int? number = 3]) {
    if (isEmpty) return this;
    var parts = split('@');
    if (parts.first.length > 3) {
      return "${parts.first.substring(0, number).padRight(parts.first.length, '*')}@${parts.last}";
    }
    return this;
  }

  String phoneFormat() {
    if (isEmpty) return this;
    if (length > 6) {
      return substring(0, 3).padRight(length - 3, '*') + substring(length - 3, length);
    }
    return this;
  }

  String get capitalize {
    if (length <= 1) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension $NullableStringExtension on String? {
  bool get isNullOrEmpty => this?.trim().isEmpty ?? true;

  int toInt() {
    return this == null ? 0 : int.tryParse(this!) ?? 0;
  }

  double toDouble() {
    return this == null ? 0 : double.tryParse(this!) ?? 0.0;
  }
}
