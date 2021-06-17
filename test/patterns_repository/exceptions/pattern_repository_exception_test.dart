// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

void main() {
  group('PatternRepositoryException', () {
    test('NoPatternsFoundException', () {
      expect(
        NoPatternsFoundException('message'),
        isNotNull,
      );
    });

    test('ConstraintsNotValidException', () {
      expect(
        ConstraintsNotValidException('message'),
        isNotNull,
      );
    });

    test('ConstraintMergeConflictException', () {
      expect(
        ConstraintMergeConflictException('message'),
        isNotNull,
      );
    });
  });
}
