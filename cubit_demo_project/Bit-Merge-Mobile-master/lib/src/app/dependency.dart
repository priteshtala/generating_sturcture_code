import 'dart:async';

import 'package:bit_merge_mobile/packages/core/core.dart';
import 'package:bit_merge_mobile/packages/data/data.dart';
import 'package:bit_merge_mobile/packages/utils/bus_events.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'environment/environment.dart';

class DependencyHelper {
  final Completer<bool> _initializeCompleter = Completer();
  final GetIt _getItInstance = GetIt.asNewInstance();

  static DependencyHelper? _instance;

  DependencyHelper._private() {
    _initDependencies();
  }

  Future<void> _initDependencies() async {
    _getItInstance
      ..registerSingleton<RouteObserver>(RouteObserver())
      ..registerLazySingleton<Environment>(const EnvironmentSelector().call);
    await initializeDataLayer(_getItInstance);
    _initializeCompleter.complete(true);
  }

  factory DependencyHelper.getInstance() => _instance ??= DependencyHelper._private();

  FutureOr<void> initialize() async {
    await _initializeCompleter.future;
  }

  T call<T extends Object>({String? instanceName}) {
    assert(_initializeCompleter.isCompleted);
    return _getItInstance<T>(instanceName: instanceName);
  }

  T get<T extends Object>({String? instanceName}) => this<T>(instanceName: instanceName);
}
