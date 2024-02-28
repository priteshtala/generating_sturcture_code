part of 'home_view.dart';

class HomeState extends Equatable {
  final bool isLightTheme;

  @override
  List<Object?> get props => [isLightTheme];

  const HomeState({
    this.isLightTheme = false,
  });

  HomeState copyWith({
    bool? isLightTheme,
  }) {
    return HomeState(
      isLightTheme: isLightTheme ?? this.isLightTheme,
    );
  }
}
