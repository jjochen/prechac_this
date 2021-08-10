// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:isolate';

import 'package:prechac_this/core/computer.dart';
import 'package:test/test.dart';

String validMethod(int message) => message.toString();
String throwingMethod(int message) => throw Exception('test method');

void main() {
  group('Computer', () {
    late Computer<int, String> computer;

    setUp(() {
      computer = Computer<int, String>();
    });

    group('run()', () {
      test('completes', () async {
        expect(
            computer.run(validMethod, 1).then((output) {
              expect(output, '1');
            }).catchError((Object error) {
              assert(false);
            }),
            completes);
      });

      test('passes error', () async {
        expect(
            computer.run(throwingMethod, 1).then((output) {
              assert(false);
            }).catchError((Object error) {
              expect(error, isA<Exception>());
            }),
            completes);
      });
    });

    group('spawn()', () {
      test('sends IsolateOutput', () {
        final port = ReceivePort();
        Computer.spawn(IsolateInput(validMethod, 1, port.sendPort));

        port.listen((dynamic data) {
          expect(data, isA<IsolateOutput>());
        });
      });

      test('sends result', () {
        final port = ReceivePort();
        Computer.spawn(IsolateInput(validMethod, 1, port.sendPort));

        port.listen((dynamic data) {
          final output = data as IsolateOutput;
          expect(output.success, isTrue);
          expect(output.result, '1');
          expect(output.error, isNull);
        });
      });

      test('sends error', () {
        final port = ReceivePort();
        Computer.spawn(IsolateInput(throwingMethod, 1, port.sendPort));

        port.listen((dynamic data) {
          final output = data as IsolateOutput;
          expect(output.success, isFalse);
          expect(output.result, isNull);
          expect(output.error, isA<Exception>());
        });
      });
    });
  });
}
