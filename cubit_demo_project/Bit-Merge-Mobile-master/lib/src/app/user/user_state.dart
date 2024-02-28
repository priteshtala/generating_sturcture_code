part of 'user_cubit.dart';

class UserState extends LoadingState {
  final bool isLogin;

  const UserState({
    this.isLogin = false,
    super.isLoading,
  });

  @override
  List<Object?> get props => super.props..addAll([isLogin]);

  @override
  UserState copyWith({
    bool? isLogin,
    bool? isLoading,
  }) {
    return UserState(
      isLogin: isLogin ?? this.isLogin,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
