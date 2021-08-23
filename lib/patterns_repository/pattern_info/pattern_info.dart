import 'package:dartx/dartx.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/pattern_info/juggler_info.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

export 'juggler_info.dart';
export 'throw_info.dart';

class PatternInfo {
  // clubs in right hand:
  // clubs in left hand:
  // throwing hand:
  // throw:
  // tramline:
  // catching hand:
  // caused by:

  PatternInfo({
    required this.pattern,
  }) : _jugglerInfoCache = _gatherInformation(pattern: pattern);

  final Pattern pattern;
  final List<JugglerInfo> _jugglerInfoCache;

  List<Fraction> pointsInTime() {
    final points = <Fraction>{};
    for (var juggler = 0; juggler < pattern.numberOfJugglers; juggler++) {
      final offset = pattern.prechator * juggler.toFraction();
      for (var index = 0; index < pattern.period; index++) {
        final offsetPoint = (index.toFraction() + offset).toMixedFraction();
        final normalizedPoint = offsetPoint.copyWith(
          whole: offsetPoint.whole % pattern.period,
        );
        points.add(normalizedPoint.toFraction());
      }
    }
    return points.sorted();
  }

  JugglerInfo infoForJuggler(int index) {
    return _jugglerInfoCache[index];
  }

  // methods used by the initializer
  static List<JugglerInfo> _gatherInformation({required Pattern pattern}) {
    final jugglersInformation = List.generate(
      pattern.numberOfJugglers,
      (index) => JugglerInfo(index),
    );

    var initialObjectCount = 0;
    var pointInTime = Fraction(0);
    final timeDelta = pattern.timeBetweenThrows();
    while (initialObjectCount.toFraction() < pattern.numberOfObjects &&
        pointInTime < pattern.period.toFraction()) {
      for (final jugglerInfo in jugglersInformation) {
        final throwInfo = _throwInfoAtPointInTime(
          jugglerInfo: jugglerInfo,
          pointInTime: pointInTime,
          pattern: pattern,
        );
        if (throwInfo == null || throwInfo.numberOfObjectsThrown == 0) {
          continue;
        }

        if (throwInfo.throwType == ThrowType.unknown) {
          throwInfo.throwType = ThrowType.initalObject;
          jugglerInfo.incremetNumberOfObjects(
            startingHand: throwInfo.isStartingHand,
          );
          initialObjectCount++;
        }

        final catchingJugglerInfo =
            jugglersInformation[throwInfo.catchingJuggler];
        final catchInfo = _throwInfoAtPointInTime(
          jugglerInfo: catchingJugglerInfo,
          pointInTime: throwInfo.landingTime,
          pattern: pattern,
        );
        catchInfo?.throwType = ThrowType.coughtObject;
      }
      pointInTime += timeDelta;
    }

    return jugglersInformation;
  }

  static ThrowInfo? _throwInfoAtPointInTime({
    required JugglerInfo jugglerInfo,
    required Fraction pointInTime,
    required Pattern pattern,
  }) {
    var throwInfo = jugglerInfo.throwInfoAtPointInTime(pointInTime);
    if (throwInfo == null) {
      throwInfo = _gatherJugglersThrowInfoAtPointInTime(
        juggler: jugglerInfo.index,
        pointInTime: pointInTime,
        pattern: pattern,
      );
      jugglerInfo.setThrowInfo(throwInfo: throwInfo, pointInTime: pointInTime);
    }
    return throwInfo;
  }

  static ThrowInfo? _gatherJugglersThrowInfoAtPointInTime({
    required int juggler,
    required Fraction pointInTime,
    required Pattern pattern,
  }) {
    final jugglersOffset = pattern.prechator * juggler.toFraction();
    final indexFraction = (pointInTime - jugglersOffset).reduce();
    if (!indexFraction.isWhole) {
      return null;
    }
    final index = indexFraction.numerator % pattern.period;
    final theThrow = pattern.throwAtIndex(index);
    final landingTime = pointInTime + theThrow.height;
    final catchingJuggler =
        (juggler + theThrow.passingIndex) % pattern.numberOfJugglers;
    final numberOfObjectsThrown = theThrow.height == 0.toFraction() ? 0 : 1;

    return ThrowInfo(
      pointInTime: pointInTime.reduce(),
      throwingJuggler: juggler,
      throwingSiteswapPosition: index,
      theThrow: theThrow,
      landingTime: landingTime.reduce(),
      catchingJuggler: catchingJuggler,
      numberOfObjectsThrown: numberOfObjectsThrown,
    );
  }
}
