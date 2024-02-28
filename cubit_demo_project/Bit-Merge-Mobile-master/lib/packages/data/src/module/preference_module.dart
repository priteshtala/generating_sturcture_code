import 'package:bit_merge_mobile/packages/data/data.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class PreferenceModule {
  @singleton
  @preResolve
  Future<AppPreference> getPreference() => SharedPreferences.getInstance().then(AppPreference.new);
}
