import 'dart:async';
import 'package:pattern_repository/src/models/constraints.dart';

import 'models/models.dart';

class PatternRepository {
  Stream<List<Pattern>> patterns(Constraints constraints) {
    return Stream.fromIterable([
      [
        Pattern([
          SimpleThrow(height: 4),
          SimpleThrow(height: 2, passingIndex: 1),
          SimpleThrow(height: 1),
          SimpleThrow(height: 1, passingIndex: 1),
        ])
      ]
    ]);
  }
}
