import 'package:flutter_test/flutter_test.dart';
import 'package:fraction/fraction.dart';

import 'package:pattern_repository/src/models/throw.dart';
import 'package:pattern_repository/src/models/throw_constraints.dart';
import 'package:pattern_repository/src/engine/prechac_throw.dart';

void main() {
  group('PrechacThrow', () {
    test('Self is valid', () {
      expect(
        Throw.self(height: 1).isValid(),
        isTrue,
      );
    });

    test('Pass is valid', () {
      expect(
        Throw.pass(height: 1).isValid(),
        isTrue,
      );
    });

    test('Self with 0 height is valid', () {
      expect(
        Throw.self(height: 0).isValid(),
        isTrue,
      );
    });

    test('Pass with 0 height is not valid', () {
      expect(
        Throw.pass(height: 0).isValid(),
        isFalse,
      );
    });

    test('Pass with 0.5 height is not valid', () {
      expect(
        Throw.pass(height: 0.5).isValid(),
        isFalse,
      );
    });

    test('Self with 0.5 height is not valid', () {
      expect(
        Throw(height: 0.5.toFraction(), passingIndex: 0).isValid(),
        isFalse,
      );
    });

    test('Throw satisfies placeholder constraint', () {
      expect(
        Throw.self(height: 4)
            .satisfiesConstraints(ThrowConstraints.placeholder()),
        isTrue,
      );
    });

    test('Throw satisfies constraint for given height', () {
      expect(
        Throw.self(height: 4).satisfiesConstraints(
          ThrowConstraints(
            height: 4.toFraction(),
            passingIndex: null,
          ),
        ),
        isTrue,
      );
    });

    test('Throw does not satisfy constraint with wrong height', () {
      expect(
        Throw.self(height: 4).satisfiesConstraints(
          ThrowConstraints(
            height: 3.toFraction(),
            passingIndex: null,
          ),
        ),
        isFalse,
      );
    });

    test('Throw satisfies constraint for given passingIndex', () {
      expect(
        Throw.self(height: 4).satisfiesConstraints(
          ThrowConstraints(
            height: null,
            passingIndex: 0,
          ),
        ),
        isTrue,
      );
    });

    test('Throw does not satisfy constraint with wrong passing index', () {
      expect(
        Throw.self(height: 4).satisfiesConstraints(
          ThrowConstraints(
            height: null,
            passingIndex: 2,
          ),
        ),
        isFalse,
      );
    });
  });
}
