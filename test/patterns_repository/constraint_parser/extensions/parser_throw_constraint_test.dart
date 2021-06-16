// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/patterns_repository/constraint_parser/extensions/parser_throw_constraint.dart';
import 'package:prechac_this/patterns_repository/models/throw_constraint.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

void main() {
  group('ParserThrowConstraint', () {
    group('merges', () {
      test('_ and _', () {
        final throwConstraint1 = ThrowConstraint.placeholder();
        final throwConstraint2 = ThrowConstraint.placeholder();
        final result = ThrowConstraint.placeholder();
        expect(
          throwConstraint1.merge(throwConstraint2),
          result,
        );
      });

      test('_ and 1p', () {
        final throwConstraint1 = ThrowConstraint.placeholder();
        final throwConstraint2 = ThrowConstraint.pass(height: 1);
        final result = ThrowConstraint.pass(height: 1);
        expect(
          throwConstraint1.merge(throwConstraint2),
          result,
        );
      });

      test('_p2 and 3p', () {
        final throwConstraint1 = ThrowConstraint.pass(
          height: null,
          passingIndex: 2,
        );
        final throwConstraint2 = ThrowConstraint.pass(
          height: 3,
          passingIndex: null,
        );
        final result = ThrowConstraint.pass(
          height: 3,
          passingIndex: 2,
        );
        expect(
          throwConstraint1.merge(throwConstraint2),
          result,
        );
      });

      test('1p2 and 1p', () {
        final throwConstraint1 = ThrowConstraint.pass(
          height: 1,
          passingIndex: 2,
        );
        final throwConstraint2 = ThrowConstraint.pass(
          height: 1,
          passingIndex: null,
        );
        final result = ThrowConstraint.pass(
          height: 1,
          passingIndex: 2,
        );
        expect(
          throwConstraint1.merge(throwConstraint2),
          result,
        );
      });
    });
    group('fails to merge', () {
      test('1p1 and 2p2', () {
        final throwConstraint1 = ThrowConstraint.pass(
          height: 1,
          passingIndex: 1,
        );
        final throwConstraint2 = ThrowConstraint.pass(
          height: 2,
          passingIndex: 2,
        );
        expect(
          () => throwConstraint1.merge(throwConstraint2),
          throwsA(isA<ConstraintMergeConflictException>()),
        );
      });

      test('_p1 and 2p2', () {
        final throwConstraint1 = ThrowConstraint.pass(
          height: null,
          passingIndex: 1,
        );
        final throwConstraint2 = ThrowConstraint.pass(
          height: 2,
          passingIndex: 2,
        );
        expect(
          () => throwConstraint1.merge(throwConstraint2),
          throwsA(isA<ConstraintMergeConflictException>()),
        );
      });

      test('1p and 1', () {
        final throwConstraint1 = ThrowConstraint.pass(
          height: 1,
        );
        final throwConstraint2 = ThrowConstraint.self(
          height: 1,
        );
        expect(
          () => throwConstraint1.merge(throwConstraint2),
          throwsA(isA<ConstraintMergeConflictException>()),
        );
      });
    });
  });
}
