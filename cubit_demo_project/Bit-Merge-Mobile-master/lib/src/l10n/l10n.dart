import 'package:flutter/widgets.dart';

import 'generated/l10n.dart';

export 'generated/l10n.dart';

extension LocalizationsExtension on BuildContext {
  BitMergeLocalization get l10n => BitMergeLocalization.of(this);
}
