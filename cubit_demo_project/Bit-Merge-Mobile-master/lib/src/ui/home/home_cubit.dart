part of 'home_view.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit(super.context, super.initialState);

  final DependencyHelper _dependencyHelper = DependencyHelper.getInstance();
  late final AppPreference preference = _dependencyHelper<AppPreference>();

  void onThemeChanged({required bool isLightTheme}) {
    emit(state.copyWith(isLightTheme: isLightTheme));
    preference.themeMode = isLightTheme ? ThemeMode.light : ThemeMode.dark;
    BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(themeMode: preference.themeMode));
  }
}
