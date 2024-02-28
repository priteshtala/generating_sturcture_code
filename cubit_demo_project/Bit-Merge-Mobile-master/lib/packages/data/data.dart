import 'dart:async';

import 'package:bit_merge_mobile/packages/core/core.dart';
import 'package:bit_merge_mobile/packages/data/data.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart' hide Environment;

export 'src/model/model.dart';
export 'src/model_helpers.dart';
export 'src/pref/app_pref.dart';
export 'src/services/services.dart';

@InjectableInit(
  initializerName: r'$initializeDataLayer',
  ignoreUnregisteredTypes: [Environment],
  asExtension: true,
)
FutureOr<GetIt> initializeDataLayer(GetIt getInstance) => getInstance.$initializeDataLayer();
