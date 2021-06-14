import 'package:fraction/fraction.dart';

import '../models/pattern.dart';
import '../patterns_repository.dart';

extension EnginePattern on Pattern {
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
