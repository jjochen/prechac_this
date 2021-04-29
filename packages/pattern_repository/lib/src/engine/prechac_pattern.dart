import 'package:fraction/fraction.dart';

import '../models/pattern.dart';

extension PrechacPattern on Pattern {
  bool isValid({
    required int minNumberOfPasses,
    required int maxNumberOfPasses,
    required int numberOfObjects,
    required int numberOfJugglers,
  }) {
    final numberOfPasses = this.numberOfPasses();
    if (numberOfPasses < minNumberOfPasses) {
      return false;
    }

    if (numberOfPasses > maxNumberOfPasses) {
      return false;
    }

    final averageNumberOfObjects = averageNumberOfObjectsPerJuggler();
    final combinedNumberOfObjects =
        averageNumberOfObjects * Fraction(numberOfJugglers);
    if (combinedNumberOfObjects != numberOfObjects.toFraction()) {
      return false;
    }

    return true;
  }
}
