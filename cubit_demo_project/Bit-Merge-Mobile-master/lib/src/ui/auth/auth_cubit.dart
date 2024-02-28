part of 'auth_view.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit(super.context, super.initialState);

  void onSelectTerms(bool? value) {
    emit(state.copyWith(checkTerms: value));
  }

  void onGoogleLogin() {
    context.navigator.pushNamed(HomeView.routeName);
  }
}
