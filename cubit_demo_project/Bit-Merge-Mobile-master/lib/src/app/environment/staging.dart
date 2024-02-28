import 'package:bit_merge_mobile/packages/core/core.dart';

class StagingEnvironment extends Environment {
  const StagingEnvironment();

  @override
  String get baseUrl => "http://172.105.90.57:8081";

  @override
  String get baseAPI => "$baseUrl/api/";
  @override
  final String stripePublishableKey =
      "pk_test_51O2pThEdUxRA7oohWLho201eKXbxLytJiZOx0Ybfr6avUBJnSO9ejP0qqr2gw0bCtkbiYH5IciA7Bvrly1C3dYWf00GgsKp0rz";
  @override
  final String stripeSecretKey = "BaseConfig.stripeSecretKey";

  @override
  final bool isLogEnabled = false;
}
