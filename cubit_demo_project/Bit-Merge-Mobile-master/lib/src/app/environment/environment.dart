import 'package:bit_merge_mobile/packages/core/core.dart';

import 'development.dart';
import 'production.dart';
import 'staging.dart';

export 'development.dart';
export 'production.dart';
export 'staging.dart';
export 'model/config.dart';
export 'model/environment.dart';

class EnvironmentSelector {
  const EnvironmentSelector();

  Environment call() {
    const env = String.fromEnvironment("env", defaultValue: "development");
    switch (env) {
      case "staging":
        return const StagingEnvironment();
      case "production":
        return const ProductionEnvironment();
      default:
        return const DevelopmentEnvironment();
    }
  }
}
