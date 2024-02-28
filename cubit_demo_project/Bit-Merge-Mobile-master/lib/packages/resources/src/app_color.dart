import 'package:flutter/material.dart';

class AppColor extends ThemeExtension<AppColor> {
  final Color failure;
  final Color success;
  final Color pending;

  Color get failureContainer => failure.withAlpha(50);

  Color get onFailureContainer => failure;

  Color get successContainer => success.withAlpha(50);

  Color get onSuccessContainer => success;

  const AppColor({
    required this.failure,
    required this.success,
    required this.pending,
  });

  static AppColor of(BuildContext context) {
    var extension = Theme.of(context).extension<AppColor>();
    assert(extension != null);
    return extension!;
  }

  @override
  ThemeExtension<AppColor> copyWith({
    Color? failure,
    Color? success,
    Color? pending,
  }) {
    return AppColor(
      failure: failure ?? this.failure,
      success: success ?? this.success,
      pending: pending ?? this.pending,
    );
  }

  @override
  ThemeExtension<AppColor> lerp(ThemeExtension<AppColor>? other, double t) {
    if (other is! AppColor) return this;
    return copyWith(
      failure: Color.lerp(failure, other.failure, t),
      success: Color.lerp(success, other.success, t),
      pending: Color.lerp(pending, other.pending, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppColor &&
          runtimeType == other.runtimeType &&
          failure == other.failure &&
          success == other.success &&
          pending == other.pending;

  @override
  int get hashCode => failure.hashCode ^ success.hashCode ^ pending.hashCode;
}

extension AppColorContextExtension on BuildContext {
  AppColor get appColor => AppColor.of(this);
}

extension AppColorThemeExtension on ThemeData {
  AppColor get appColor {
    var extension = this.extension<AppColor>();
    assert(extension != null);
    return extension!;
  }
}
