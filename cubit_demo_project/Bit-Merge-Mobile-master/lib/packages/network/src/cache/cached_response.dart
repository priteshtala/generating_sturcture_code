import 'dart:convert';

import 'package:equatable/equatable.dart';

base class CachedResponse extends Equatable {
  final dynamic data;
  final int? statusCode;
  final DateTime createAt;

  const CachedResponse({
    required this.data,
    required this.statusCode,
    required this.createAt,
  });

  @override
  List<Object?> get props => [data, statusCode, createAt];

  factory CachedResponse.fromJson(Map<String, dynamic> json) {
    return CachedResponse(
      data: jsonDecode(json['data']),
      statusCode: json['statusCode'],
      createAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': jsonEncode(data),
      'statusCode': statusCode,
      'createdAt': createAt.millisecondsSinceEpoch,
    };
  }
}
