import 'package:dartx/dartx.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

export 'throw_info.dart';

class PatternInfo {
  // clubs in right hand:
  // clubs in left hand:
  // throwing hand:
  // throw:
  // tramline:
  // catching hand:
  // caused by:

  PatternInfo({required this.pattern});

  final Pattern pattern;

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
}
