import 'package:bit_merge_mobile/packages/core/core.dart';
import 'package:bit_merge_mobile/packages/data/data.dart';
import 'package:bit_merge_mobile/src/app/dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends BaseCubit<UserState>  {
  UserCubit(super.context, super.initialState);

  static UserCubit of(BuildContext context, [bool listen = false]) {
    return BlocProvider.of<UserCubit>(context, listen: listen);
  }

  final DependencyHelper _dependencyHelper = DependencyHelper.getInstance();
  late final AppPreference _preference = _dependencyHelper<AppPreference>();

  @override
  void onCreate() {
    super.onCreate();
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
