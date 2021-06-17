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

    group('ConstraintsNotValidException', () {
      test('supports value comparisons', () {
        expect(
          ConstraintsNotValidException('message'),
          ConstraintsNotValidException('message'),
        );
      });

      test('has correct string representation', () {
        expect(
          ConstraintsNotValidException('message').toString(),
          'ConstraintsNotValidException: message',
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
