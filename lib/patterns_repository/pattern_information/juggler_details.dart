import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

enum Hand { left, right }

class JugglerDetails {
  JugglerDetails({
    required this.jugglerIndex,
    required Pattern pattern,
  }) {
    final prechatorOffset = pattern.prechator * jugglerIndex.toFraction();
    patternOffset = prechatorOffset.toDouble().floor() % pattern.period;
    timeOffset = prechatorOffset.toMixedFraction().fractionalPart.reduce();
    localPattern = pattern.rotate(-patternOffset);
  }

  final int jugglerIndex;
  late final int patternOffset;
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
    var throwDetails = _cachedThrowDetails(pointInTime: pointInTime);
    if (throwDetails == null) {
      throwDetails = _gatherThrowDetails(pointInTime: pointInTime);
      _setCachedThrowDetails(
        throwDetails: throwDetails,
        pointInTime: pointInTime,
      );
    }
    return throwDetails;
  }

  int localThrowIndexAtPointInTime(Fraction pointInTime) {
    final mixedFraction = pointInTime.toMixedFraction();
    if (mixedFraction.fractionalPart.reduce() != timeOffset) {
      return -1;
    }
    return mixedFraction.whole % localPattern.period;
  }

  final _throwDetailsCache = <Fraction, ThrowDetails?>{};

  ThrowDetails? _cachedThrowDetails({
    required Fraction pointInTime,
  }) {
    final throwDetails = _throwDetailsCache[pointInTime.reduce()];
    return throwDetails;
  }

  void _setCachedThrowDetails({
    required ThrowDetails? throwDetails,
    required Fraction pointInTime,
  }) {
    _throwDetailsCache[pointInTime.reduce()] = throwDetails;
  }

  ThrowDetails? _gatherThrowDetails({
    required Fraction pointInTime,
  }) {
    final localThrowIndex = localThrowIndexAtPointInTime(pointInTime);
    if (localThrowIndex < 0) {
      return null;
    }
    final siteswapPosition =
        (localThrowIndex + patternOffset) % localPattern.period;
    final theThrow = localPattern.throwAtIndex(localThrowIndex);
    final landingTime = pointInTime + theThrow.height;
    final catchingJuggler =
        (jugglerIndex + theThrow.passingIndex) % localPattern.numberOfJugglers;
    final numberOfObjectsThrown = theThrow.height.toDouble() == 0 ? 0 : 1;

    return ThrowDetails(
      pointInTime: pointInTime.reduce(),
      throwingJuggler: jugglerIndex,
      throwingSiteswapPosition: siteswapPosition,
      theThrow: theThrow,
      landingTime: landingTime.reduce(),
      catchingJuggler: catchingJuggler,
      numberOfObjectsThrown: numberOfObjectsThrown,
    );
  }
}
