import '../../../l10n/l10n.dart';
import '../../../patterns_repository/patterns_repository.dart';
import '../home.dart';

extension ErrorMessages on AppLocalizations {
  String errorMessage(dynamic error, {String? noErrorFallback}) {
    if (error == null) {
      return noErrorFallback ?? constraintsFormUnknownErrorMessage;
    }

    if (error is ConstraintsInvalidException) {
      return constraintsFormConstraintsInvalidErrorMessage;
    }

    if (error is NoPatternsFoundException) {
      return constraintsFormNoPatternsFoundErrorMessage;
    }

    if (error is InputOutOfRangeException) {
      return constraintsFormOutOfRangeErrorMessage(
        error.minValue,
        error.maxValue,
      );
    }

    return constraintsFormUnknownErrorMessage;
  }
}
