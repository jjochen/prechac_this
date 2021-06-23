import 'dart:async';
import 'dart:isolate';

import 'package:fraction/fraction.dart';

import 'constraint_parser/parser.dart';
import 'engine/engine.dart';
import 'exceptions/pattern_repository_exception.dart';
import 'models/models.dart';

export 'exceptions/pattern_repository_exception.dart';
export 'models/models.dart';

class PatternsRepository {
  Future<List<Pattern>> patterns(SearchParameters parameters) async {
    final resultPort = ReceivePort();
    final exitPort = ReceivePort();
    final errorPort = ReceivePort();

    final isolate = await Isolate.spawn(
      _spawn,
      _IsolateConfiguration(
        parameters,
        resultPort.sendPort,
      ),
      onExit: exitPort.sendPort,
      onError: errorPort.sendPort,
    );

    final completer = Completer<List<Pattern>>();

    resultPort.listen((dynamic resultData) {
      assert(resultData == null || resultData is List<Pattern>);
      if (!completer.isCompleted) {
        completer.complete(resultData as List<Pattern>);
      }
    });

    errorPort.listen((dynamic errorData) {
      assert(errorData is List<dynamic>);
      final errorDataList = errorData as List<dynamic>;
      assert(errorDataList.length == 2);

      Exception exception;
      try {
        exception = PatternRepositoryException.fromErrorData(errorDataList[0]);
      } catch (_) {
        exception = Exception(errorDataList[0]);
      }

      final stack = StackTrace.fromString(errorDataList[1] as String);

      if (completer.isCompleted) {
        Zone.current.handleUncaughtError(exception, stack);
      } else {
        completer.completeError(exception, stack);
      }
    });

    exitPort.listen((dynamic exitData) {
      if (!completer.isCompleted) {
        completer.completeError(
            Exception('Isolate exited without result or error.'));
      }
    });

    await completer.future;
    resultPort.close();
    errorPort.close();
    isolate.kill();
    return completer.future;
  }

  static void _spawn(_IsolateConfiguration configuration) {
    final result = findPatterns(configuration.parameters);
    configuration.resultPort.send(result);
  }

  static List<Pattern> findPatterns(SearchParameters parameters) {
    final constraints = parameters.parse();
    const engine = Engine();
    return engine.fillConstraint(patternConstraint: constraints);
  }

  Pattern prechacThisThrow({
    required Pattern pattern,
    required int index,
    required PrechacDirection direction,
  }) {
    final numberOfJugglers = pattern.numberOfJugglers;
    final prechator = pattern.prechator;
    final oldThrow = pattern.throwAtIndex(index);
    final oldHeight = oldThrow.height;
    final oldPassingIndex = oldThrow.passingIndex;
    final Fraction newHeight;
    final int newPassingIndex;
    if (direction == PrechacDirection.up) {
      newHeight = oldHeight + prechator;
      newPassingIndex = (oldPassingIndex + 1) % numberOfJugglers;
    } else {
      newHeight = oldHeight - prechator;
      newPassingIndex =
          oldPassingIndex == 0 ? numberOfJugglers - 1 : (oldPassingIndex - 1);
    }
    return pattern.copyWithThrow(
      newThrow: Throw(height: newHeight, passingIndex: newPassingIndex),
      index: index,
    );
  }
}

class _IsolateConfiguration {
  const _IsolateConfiguration(
    this.parameters,
    this.resultPort,
  );
  final SearchParameters parameters;
  final SendPort resultPort;
}
