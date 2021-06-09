// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:petitparser/petitparser.dart';
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
      group('throwConstraint', () {
        late Parser parser;

        setUp(() {
          parser = definition.build(start: definition.throwConstraint);
        });

        group('self', () {
          test('1', () {
            expect(
              parser.parse('1').value,
              ThrowConstraint.self(height: 1),
            );
          });

          test('42', () {
            expect(
              parser.parse('42').value,
              ThrowConstraint.self(height: 42),
            );
          });
        });

        group('pass', () {
          test('4.5p2', () {
            expect(
              parser.parse('4.5p2').value,
              ThrowConstraint.pass(height: 4.5, passingIndex: 2),
            );
          });

          test('4.5p', () {
            expect(
              parser.parse('4.5p').value,
              ThrowConstraint.pass(height: 4.5, passingIndex: 1),
            );
          });

          test('4p', () {
            expect(
              parser.parse('4p').value,
              ThrowConstraint.pass(height: 4, passingIndex: 1),
            );
          });

          test('4p_', () {
            expect(
              parser.parse('4p_').value,
              ThrowConstraint.pass(height: 4, passingIndex: null),
            );
          });

          test('_p2', () {
            expect(
              parser.parse('_p2').value,
              ThrowConstraint.pass(height: null, passingIndex: 2),
            );
          });

          test('_p_', () {
            expect(
              parser.parse('_p_').value,
              ThrowConstraint.pass(height: null, passingIndex: null),
            );
          });
        });

        group('placeholder', () {
          test('_', () {
            expect(
              parser.parse('_').value,
              ThrowConstraint.placeholder(),
            );
          });

          test('*', () {
            expect(
              parser.parse('*').value,
              ThrowConstraint.placeholder(),
            );
          });

          test('?', () {
            expect(
              parser.parse('*').value,
              ThrowConstraint.placeholder(),
            );
          });
        });
      });

      group('integerOrPlaceholder', () {
        late Parser parser;

        setUp(() {
          parser = definition.build(start: definition.integerOrPlaceholder);
        });

        test('4', () {
          expect(
            parser.parse('4').value,
            4,
          );
        });

        test('_', () {
          expect(
            parser.parse('_').value,
            isNull,
          );
        });
      });

      group('floatOrPlaceholder', () {
        late Parser parser;

        setUp(() {
          parser = definition.build(start: definition.floatOrPlaceholder);
        });
        test('4', () {
          expect(
            parser.parse('4').value,
            4,
          );
        });

        test('4.2', () {
          expect(
            parser.parse('4.2').value,
            4.2,
          );
        });

        test('_', () {
          expect(
            parser.parse('_').value,
            isNull,
          );
        });
      });
    });
  });
}
