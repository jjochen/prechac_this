import 'package:equatable/equatable.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

class ThrowInfo with EquatableMixin {
  ThrowInfo({
    required this.pointInTime,
    required this.throwingJuggler,
    required this.throwingSiteswapPosition,
    required this.theThrow,
    required this.landingTime,
    required this.catchingJuggler,
    required this.numberOfThrownObjects,
  });

  final Fraction pointInTime;
  final int throwingJuggler;
  final int throwingSiteswapPosition;
  final Throw theThrow;
  final Fraction landingTime;
  final int catchingJuggler;
  final int numberOfThrownObjects;

  static ThrowInfo fromPattern({
    required Pattern pattern,
    required int juggler,
    required int index,
  }) {
    final jugglersOffset = pattern.prechator * juggler.toFraction();
    final point = (index.toFraction() + jugglersOffset).toMixedFraction();
    final pointInTime = point
        .copyWith(
          whole: point.whole % pattern.period,
        )
        .toFraction();
    final theThrow = pattern.throwAtIndex(index);
    final landingTime = pointInTime + theThrow.height;
    final catchingJuggler =
        (juggler + theThrow.passingIndex) % pattern.numberOfJugglers;
    final numberOfThrownObjects = theThrow.height == 0.toFraction() ? 0 : 1;

    return ThrowInfo(
      pointInTime: pointInTime,
      throwingJuggler: juggler,
      throwingSiteswapPosition: index,
      theThrow: theThrow,
      landingTime: landingTime,
      catchingJuggler: catchingJuggler,
      numberOfThrownObjects: numberOfThrownObjects,
    );
  }

  ThrowInfo copyWith({
    Fraction? pointInTime,
    int? throwingJuggler,
    int? throwingSiteswapPosition,
    Throw? theThrow,
    Fraction? landingTime,
    int? catchingJuggler,
    int? numberOfThrownObjects,
  }) {
    return ThrowInfo(
      pointInTime: pointInTime ?? this.pointInTime,
      throwingJuggler: throwingJuggler ?? this.throwingJuggler,
      throwingSiteswapPosition:
          throwingSiteswapPosition ?? this.throwingSiteswapPosition,
      theThrow: theThrow ?? this.theThrow,
      landingTime: landingTime ?? this.landingTime,
      catchingJuggler: catchingJuggler ?? this.catchingJuggler,
      numberOfThrownObjects:
          numberOfThrownObjects ?? this.numberOfThrownObjects,
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
        numberOfThrownObjects,
      ];
}
