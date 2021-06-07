// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/engine/prechac_throw.dart';
import 'package:prechac_this/patterns_repository/models/throw.dart';
import 'package:prechac_this/patterns_repository/models/throw_constraint.dart';
import 'package:test/test.dart';

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
            .satisfiesConstraint(ThrowConstraint.placeholder()),
        isTrue,
      );
    });

    test('Throw satisfies constraint for given height', () {
      expect(
        Throw.self(height: 4).satisfiesConstraint(
          ThrowConstraint(
            height: 4.toFraction(),
            passingIndex: null,
          ),
        ),
        isTrue,
      );
    });

    test('Throw does not satisfy constraint with wrong height', () {
      expect(
        Throw.self(height: 4).satisfiesConstraint(
          ThrowConstraint(
            height: 3.toFraction(),
            passingIndex: null,
          ),
        ),
        isFalse,
      );
    });

    test('Throw satisfies constraint for given passingIndex', () {
      expect(
        Throw.self(height: 4).satisfiesConstraint(
          const ThrowConstraint(
            height: null,
            passingIndex: 0,
          ),
        ),
        isTrue,
      );
    });

    test('Throw does not satisfy constraint with wrong passing index', () {
      expect(
        Throw.self(height: 4).satisfiesConstraint(
          const ThrowConstraint(
            height: null,
            passingIndex: 2,
          ),
        ),
        isFalse,
      );
    });
  });
}
