import 'package:equatable/equatable.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

enum ThrowType { unknown, initalObject, coughtObject }
enum Hand { unknown, left, right }

class ThrowInfo with EquatableMixin {
  ThrowInfo({
    required this.pointInTime,
    required this.throwingJuggler,
    required this.throwingSiteswapPosition,
    required this.theThrow,
    required this.landingTime,
    required this.catchingJuggler,
    required this.numberOfObjectsThrown,
  });

  final Fraction pointInTime;
  final int throwingJuggler;
  final int throwingSiteswapPosition;
  final Throw theThrow;
  final Fraction landingTime;
  final int catchingJuggler;
  final int numberOfObjectsThrown;

  ThrowType throwType = ThrowType.unknown;
  Hand hand = Hand.unknown;

  //TODO: needs tests
  int get throwIndex => pointInTime.toDouble().floor();

  static ThrowInfo atIndex({
    required Pattern pattern,
    required int juggler,
    required int index,
    bool normalize = true,
  }) {
    final jugglersOffset = pattern.prechator * juggler.toFraction();
    final point = (index.toFraction() + jugglersOffset).toMixedFraction();
    final pointInTime = point
        .copyWith(
          whole: normalize ? point.whole % pattern.period : point.whole,
        )
        .toFraction();
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

  static ThrowInfo? atPointInTime({
    required Pattern pattern,
    required int juggler,
    required Fraction pointInTime,
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

  @override
  List<Object> get props => [
        pointInTime,
        throwingJuggler,
        throwingSiteswapPosition,
        theThrow,
        landingTime,
        catchingJuggler,
        numberOfObjectsThrown,
      ];
}
