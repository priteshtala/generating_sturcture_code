import 'package:bit_merge_mobile/packages/core/core.dart';

class DevelopmentEnvironment extends Environment {
  const DevelopmentEnvironment();

  @override
  String get baseUrl => "https://api.mystic-planets.com";

  @override
  String get baseAPI => "$baseUrl/api/";

  @override
  final String stripePublishableKey =
      "pk_test_51O2pThEdUxRA7oohWLho201eKXbxLytJiZOx0Ybfr6avUBJnSO9ejP0qqr2gw0bCtkbiYH5IciA7Bvrly1C3dYWf00GgsKp0rz";
  @override
  final String stripeSecretKey = "BaseConfig.stripeSecretKey";

  @override
  final bool isLogEnabled = true;
}
