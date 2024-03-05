import 'dart:convert';
import 'dart:io';

final _colorNameList = [
  "primary",
  "onPrimary",
  "secondary",
  "onSecondary",
  "error",
  "onError",
  "background",
  "onBackground",
  "surface",
  "onSurface",
];
Map<String, dynamic> _lightColorScheme = {};
Map<String, dynamic> _darkColorScheme = {};

void main(List<String> args) {
  final currentDirectoryPath = args[0];

  print("Do you want single theme ? (y/n)");
  final isSingleResponse = stdin.readLineSync();

  if (isSingleResponse != null && isSingleResponse.toLowerCase() == 'y') {
    _getColorScheme(_lightColorScheme, "Default");
    _createJsonFile(
      "$currentDirectoryPath/theme-generator/light_theme.json",
      jsonEncode(_lightColorScheme),
    );
    return;
  }else{
    _getColorScheme(_lightColorScheme, "Light");

    // print("Set colorScheme dark theme (y/n) : ");
    // final response = stdin.readLineSync();



      _getColorScheme(_darkColorScheme, "Dark");

    _createJsonFile(
      "$currentDirectoryPath/theme-generator/light_theme.json",
      jsonEncode(_lightColorScheme),
    );
    if (_darkColorScheme.isNotEmpty) {
      _createJsonFile(
        "$currentDirectoryPath/theme-generator/dark_theme.json",
        jsonEncode(_darkColorScheme),
      );
    }
  }

}

Future<void> _createJsonFile(String path, String theme) async {
  await File("$path").writeAsString(theme);
}

void _getColorScheme(Map<String, dynamic> colorScheme, String theme) {
  print("--------------- $theme Color ---------------");
  for (String colorName in _colorNameList) {
    bool isValidInput = false;
    String colorCode = '';
    while (!isValidInput) {
      stdout.write("Enter color value for $colorName (e.g., 000033): ");
      colorCode = stdin.readLineSync() ?? '';
      isValidInput = _isValidColorCode(colorCode);
      if (!isValidInput) print("Invalid color code. Please enter a valid hexadecimal color code.");
    }
    colorScheme[colorName] = colorCode;
  }
}

bool _isValidColorCode(String colorCode) {
  RegExp colorValueRegex = RegExp(r'^(?:[0-9a-fA-F]{3,4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$');
  return colorValueRegex.hasMatch(colorCode);
}
