// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bit_merge_mobile/packages/core/core.dart' as _i6;
import 'package:bit_merge_mobile/packages/data/data.dart' as _i3;
import 'package:bit_merge_mobile/packages/data/src/module/network_module.dart'
    as _i9;
import 'package:bit_merge_mobile/packages/data/src/module/preference_module.dart'
    as _i8;
import 'package:bit_merge_mobile/packages/data/src/services/auth/auth_repository.dart'
    as _i7;
import 'package:bit_merge_mobile/packages/network/network.dart' as _i4;
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> $initializeDataLayer({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final preferenceModule = _$PreferenceModule();
    final networkModule = _$NetworkModule();
    await gh.singletonAsync<_i3.AppPreference>(
      () => preferenceModule.getPreference(),
      preResolve: true,
    );
    await gh.singletonAsync<_i4.CacheService>(
      () => networkModule.getCacheService(),
      preResolve: true,
    );
    gh.singleton<_i5.Dio>(networkModule.getDioInstance(
      pref: gh<_i3.AppPreference>(),
      environment: gh<_i6.Environment>(),
    ));
    gh.lazySingleton<_i7.AuthRepository>(
        () => _i7.AuthRepository(dio: gh<_i5.Dio>()));
    return this;
  }
}

class _$PreferenceModule extends _i8.PreferenceModule {}

class _$NetworkModule extends _i9.NetworkModule {}
