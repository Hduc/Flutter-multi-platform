import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:severingthing/common/model/text_field_validator.dart';

class Utils {
  static String? getTextValidator(BuildContext ctx, TextValidator? validator) {
    final localizations = AppLocalizations.of(ctx)!;

    switch (validator) {
      case TextValidator.empty:
        return localizations.emptyValidation;
      case TextValidator.email:
        return localizations.emailRequiredMessage;
      case TextValidator.password:
        return localizations.passwordRequiredMessage;
      case TextValidator.numeric:
        return localizations.numberValidation;
      default:
        return null;
    }
  }
}
