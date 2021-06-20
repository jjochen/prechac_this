// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

void main() {
  group('PatternRepositoryException', () {
    group('NoPatternsFoundException', () {
      test('supports value comparisons', () {
        expect(
          NoPatternsFoundException('message'),
          NoPatternsFoundException('message'),
        );
      });

      test('has correct string representation', () {
        expect(
          NoPatternsFoundException('message').toString(),
          'NoPatternsFoundException: message',
        );
      });
    });

    group('ConstraintsInvalidException', () {
      test('supports value comparisons', () {
        expect(
          ConstraintsInvalidException('message'),
          ConstraintsInvalidException('message'),
        );
      });

      test('has correct string representation', () {
        expect(
          ConstraintsInvalidException('message').toString(),
          'ConstraintsInvalidException: message',
        );
      });
    });

    group('ConstraintMergeConflictException', () {
      test('supports value comparisons', () {
        expect(
          ConstraintMergeConflictException('message'),
          ConstraintMergeConflictException('message'),
        );
      });

      test('has correct string representation', () {
        expect(
          ConstraintMergeConflictException().toString(),
          'ConstraintMergeConflictException',
        );
      });
    });
  });
}
