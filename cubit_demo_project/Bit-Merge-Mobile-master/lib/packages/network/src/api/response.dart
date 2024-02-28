import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

final class ApiResponse<T extends Object?> extends Equatable {
  final int? statusCode;
  final Response response;
  final T data;

  const ApiResponse({
    required this.statusCode,
    required this.response,
    required this.data,
  });

  @override
  List<Object?> get props => [statusCode, response, data];
}
