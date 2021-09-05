import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

enum Hand { left, right }

class JugglerDetails {
  JugglerDetails({
    required this.index,
    required Pattern pattern,
  }) {
    timeOffset = pattern.prechator * index.toFraction();
    offset = timeOffset.toDouble().floor() % pattern.period;
    localPattern = pattern.rotate(-offset);
  }

  final int index;
  late final int offset;
  late final Fraction timeOffset;
  late final Pattern localPattern;

  Hand startingHand = Hand.right;
  Hand get noneStartingHand =>
      startingHand == Hand.right ? Hand.left : Hand.right;

  void toggleStartingHand() {
    startingHand = noneStartingHand;
  }

  Hand? throwingHandAtPointInTime(Fraction pointInTime) {
    final throwDetails = throwDetailsAtPointInTime(pointInTime);
    if (throwDetails == null) {
      return null;
    }
    return throwDetails.isStartingHand ? startingHand : noneStartingHand;
  }

  int _numberOfObjectsInFirstHand = 0;
  int _numberOfObjectsInSecondHand = 0;

  int numberOfObjectsInHand(Hand hand) {
    return hand == startingHand
        ? _numberOfObjectsInFirstHand
        : _numberOfObjectsInSecondHand;
  }

  void incremetNumberOfObjects({required bool startingHand}) {
    if (startingHand) {
      _numberOfObjectsInFirstHand++;
    } else {
      _numberOfObjectsInSecondHand++;
    }
  }

  ThrowDetails? throwDetailsAtPointInTime(Fraction pointInTime) {
    final throwDetails = _throwDetailsCache[pointInTime.reduce()];
    return throwDetails;
  }

  void setThrowDetails({
    required ThrowDetails? throwDetails,
    required Fraction pointInTime,
  }) {
    _throwDetailsCache[pointInTime.reduce()] = throwDetails;
  }

  final _throwDetailsCache = <Fraction, ThrowDetails?>{};
}
