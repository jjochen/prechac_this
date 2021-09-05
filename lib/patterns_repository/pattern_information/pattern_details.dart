import 'package:dartx/dartx.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

enum ThrowDirection { self, tramline, cross }

class PatternDetails {
  PatternDetails({
    required this.pattern,
  }) : _jugglerDetailsCache = _gatherInformation(pattern: pattern);

  final Pattern pattern;
  final List<JugglerDetails> _jugglerDetailsCache;

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

  JugglerDetails infoForJuggler(int index) {
    return _jugglerDetailsCache[index];
  }

  Hand? throwingHandAtPointInTime({
    required int juggler,
    required Fraction pointInTime,
  }) {
    return infoForJuggler(juggler).throwingHandAtPointInTime(pointInTime);
  }

  Hand? catchingHandAtPointInTime({
    required int juggler,
    required Fraction pointInTime,
  }) {
    final throwInfo =
        infoForJuggler(juggler).throwDetailsAtPointInTime(pointInTime);
    if (throwInfo == null) {
      return null;
    }
    return throwingHandAtPointInTime(
      juggler: throwInfo.catchingJuggler,
      pointInTime: throwInfo.landingTime,
    );
  }

  ThrowDirection? throwDirectionAtPointInTime({
    required int juggler,
    required Fraction pointInTime,
  }) {
    final throwInfo =
        infoForJuggler(juggler).throwDetailsAtPointInTime(pointInTime);
    if (throwInfo == null) {
      return null;
    }

    if (throwInfo.theThrow.isSelf) {
      return ThrowDirection.self;
    }

    final throwingHand = throwingHandAtPointInTime(
      juggler: juggler,
      pointInTime: pointInTime,
    );
    final catchingHand = catchingHandAtPointInTime(
      juggler: juggler,
      pointInTime: pointInTime,
    );
    return throwingHand == catchingHand
        ? ThrowDirection.cross
        : ThrowDirection.tramline;
  }

  // methods used by the initializer
  static List<JugglerDetails> _gatherInformation({required Pattern pattern}) {
    final jugglersInformation = List.generate(
      pattern.numberOfJugglers,
      (index) => JugglerDetails(index: index, pattern: pattern),
    );

    var initialObjectCount = 0;
    var pointInTime = Fraction(0);
    final timeDelta = pattern.timeBetweenThrows();
    while (initialObjectCount.toFraction() < pattern.numberOfObjects ||
        pointInTime < pattern.period.toFraction()) {
      for (final jugglerDetails in jugglersInformation) {
        final throwDetails = _throwDetailsAtPointInTime(
          jugglerDetails: jugglerDetails,
          pointInTime: pointInTime,
          pattern: pattern,
        );
        if (throwDetails == null || throwDetails.numberOfObjectsThrown == 0) {
          continue;
        }

        if (throwDetails.throwType == ThrowType.unknown) {
          throwDetails.throwType = ThrowType.initalObject;
          jugglerDetails.incremetNumberOfObjects(
            startingHand: throwDetails.isStartingHand,
          );
          initialObjectCount++;
        }

        final catchingJugglerDetails =
            jugglersInformation[throwDetails.catchingJuggler];
        final catchInfo = _throwDetailsAtPointInTime(
          jugglerDetails: catchingJugglerDetails,
          pointInTime: throwDetails.landingTime,
          pattern: pattern,
        );
        catchInfo?.throwType = ThrowType.coughtObject;
      }
      pointInTime = (pointInTime + timeDelta).reduce();
    }

    return jugglersInformation;
  }

  static ThrowDetails? _throwDetailsAtPointInTime({
    required JugglerDetails jugglerDetails,
    required Fraction pointInTime,
    required Pattern pattern,
  }) {
    var throwDetails = jugglerDetails.throwDetailsAtPointInTime(pointInTime);
    if (throwDetails == null) {
      throwDetails = _gatherJugglersThrowDetailsAtPointInTime(
        juggler: jugglerDetails.index,
        pointInTime: pointInTime,
        pattern: pattern,
      );
      jugglerDetails.setThrowDetails(
          throwDetails: throwDetails, pointInTime: pointInTime);
    }
    return throwDetails;
  }

  static ThrowDetails? _gatherJugglersThrowDetailsAtPointInTime({
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

    return ThrowDetails(
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
