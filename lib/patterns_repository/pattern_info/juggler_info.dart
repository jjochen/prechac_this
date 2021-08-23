import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

enum Hand { left, right }

class JugglerInfo {
  JugglerInfo(this.index);

  final int index;

  Hand startingHand = Hand.right;
  Hand get noneStartingHand =>
      startingHand == Hand.right ? Hand.left : Hand.right;

  void toggleStartingHand() {
    startingHand = noneStartingHand;
  }

  Hand? throwingHandAtPointInTime(Fraction pointInTime) {
    final throwInfo = throwInfoAtPointInTime(pointInTime);
    if (throwInfo == null) {
      return null;
    }
    return throwInfo.isStartingHand ? startingHand : noneStartingHand;
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

  ThrowInfo? throwInfoAtPointInTime(Fraction pointInTime) {
    final throwInfo = _throwInfoCache[pointInTime];
    return throwInfo;
  }

  void setThrowInfo({
    required ThrowInfo? throwInfo,
    required Fraction pointInTime,
  }) {
    _throwInfoCache[pointInTime] = throwInfo;
  }

  final _throwInfoCache = <Fraction, ThrowInfo?>{};
}
