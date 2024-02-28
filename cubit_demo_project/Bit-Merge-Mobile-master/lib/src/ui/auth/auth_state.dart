part of 'auth_view.dart';

class AuthState extends Equatable {
  final bool checkTerms;

  const AuthState({
    this.checkTerms = false,
  });

  @override
  List<Object?> get props => [checkTerms];

  AuthState copyWith({
    bool? checkTerms,
  }) {
    return AuthState(
      checkTerms: checkTerms ?? this.checkTerms,
    );
  }
}
