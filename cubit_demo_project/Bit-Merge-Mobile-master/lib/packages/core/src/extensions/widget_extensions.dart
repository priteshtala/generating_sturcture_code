import 'package:flutter/widgets.dart';

extension $PageControllerExt on PageController {
  bool get attachedToView {
    return hasClients && positions.isNotEmpty && position.hasPixels && position.hasContentDimensions;
  }

  int get pageIndex {
    return attachedToView ? page?.round() ?? 0 : 0;
  }
}
