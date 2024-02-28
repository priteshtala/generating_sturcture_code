abstract class BaseConfig {
  final String baseUrl;
  final String baseAPI;
  final bool isLogEnabled;
  final String stripePublishableKey;
  final String stripeSecretKey;

  const BaseConfig({
    required this.baseUrl,
    required this.baseAPI,
    required this.isLogEnabled,
    required this.stripePublishableKey,
    required this.stripeSecretKey,
  });
}
