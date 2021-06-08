// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/patterns_repository/constraint_parser/constraint_definition.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

void main() {
  group('ConstraintParserDefinition', () {
    late ConstraintParserDefinition definition;

    setUp(() {
      definition = ConstraintParserDefinition();
    });

    group('parses', () {
      test('self', () {
        final parser = definition.build();
        expect(
          parser.parse('4').value,
          ThrowConstraint.self(height: 4),
        );
      });

      test('pass', () {
        final parser = definition.build();
        expect(
          parser.parse('4.5p2').value,
          ThrowConstraint.pass(height: 4.5, passingIndex: 2),
        );
      });

      test('placeholder', () {
        final parser = definition.build();
        expect(
          parser.parse('_').value,
          ThrowConstraint.placeholder(),
        );
      });

      test('integerOrPlaceholder', () {
        final parser = definition.build(start: definition.integerOrPlaceholder);
        expect(
          parser.parse('4').value,
          4,
        );
        expect(
          parser.parse('_').value,
          isNull,
        );
      });

      test('floatOrPlaceholder', () {
        final parser = definition.build(start: definition.floatOrPlaceholder);
        expect(
          parser.parse('4').value,
          4,
        );
        expect(
          parser.parse('4.2').value,
          4.2,
        );
        expect(
          parser.parse('?').value,
          isNull,
        );
      });
    });
  });
}
