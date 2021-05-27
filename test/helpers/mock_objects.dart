import 'package:prechac_this/patterns_repository/patterns_repository.dart';

final mockParameters = SearchParameters(
  numberOfJugglers: 2,
  period: 4,
  numberOfObjects: 4,
  maxHeight: 4,
);

final mockPattern = Pattern([
  Throw.self(height: 4),
  Throw.pass(height: 2),
  Throw.self(height: 1),
  Throw.pass(height: 1),
]);
