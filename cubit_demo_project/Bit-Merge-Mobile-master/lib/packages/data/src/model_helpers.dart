import 'package:bit_merge_mobile/packages/core/core.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart' as mime;
import 'package:path/path.dart' as path;

typedef JsonMap = Map<String, dynamic>;

typedef ModelParser<T> = T Function(JsonMap json);

List<T> parseList<T>(dynamic value, ModelParser<T> parser) {
  List<T> list = <T>[];
  if (value is! Iterable) return list;
  for (var json in value) {
    list.add(parser(json));
  }
  return list;
}

List<double> parseDoubleList(dynamic value) {
  List<double> list = <double>[];
  if (value is! Iterable) return list;
  for (var element in value) {
    list.add(parseDouble(element));
  }
  return list;
}

JsonMap? parseJson(dynamic value) => value is JsonMap ? value : null;

double parseDouble(dynamic value) => value.toString().toDouble();

bool parseBool(dynamic value) => value == true || value == 1 || value == 1.toString() || value == true.toString();

DateTime parseUtcDateTimeToLocal(String value) => value.parseUtcDateTime().toLocal();

int parseInt(dynamic value) => value.toString().toInt();

String valueToString(dynamic value) => value.toString();

Future<MultipartFile> getMultipartFileFromPath(String filePath) async {
  final String? mimeType = mime.lookupMimeType(filePath);
  final mediaType = mimeType == null ? null : MediaType.parse(mimeType);
  return MultipartFile.fromFile(filePath, filename: path.basename(filePath), contentType: mediaType);
}
