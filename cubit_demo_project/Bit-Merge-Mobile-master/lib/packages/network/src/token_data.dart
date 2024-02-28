import 'package:equatable/equatable.dart';

base class TokenData extends Equatable {
  final String accessToken;
  final String refreshToken;

  const TokenData({required this.accessToken, required this.refreshToken});

  @override
  List<Object?> get props => [accessToken, refreshToken];

  factory TokenData.fromJson(Map<String, dynamic> json) {
    return TokenData(
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
