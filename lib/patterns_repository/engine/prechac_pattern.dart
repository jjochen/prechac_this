import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

import '../models/pattern.dart';

extension PrechacPattern on Pattern {
  bool satisfiesConstraint(PatternConstraint constraint) {
    if (numberOfPasses < constraint.minNumberOfPasses) {
      return false;
    }

    if (numberOfPasses > constraint.maxNumberOfPasses) {
      return false;
    }

    if (numberOfObjects != constraint.numberOfObjects.toFraction()) {
      return false;
    }

    return true;
  }
}
