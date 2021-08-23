import 'package:equatable/equatable.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

enum ThrowType { unknown, initalObject, coughtObject }

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

  int get throwIndex => pointInTime.toDouble().floor();
  bool get isStartingHand => throwIndex.isEven;

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
