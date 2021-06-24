import 'dart:async';
import 'dart:isolate';

import 'package:fraction/fraction.dart';

import 'constraint_parser/parser.dart';
import 'engine/engine.dart';
import 'models/models.dart';

export 'exceptions/pattern_repository_exception.dart';
export 'models/models.dart';

class PatternsRepository {
  Future<List<Pattern>> patterns(SearchParameters parameters) async {
    const computer = Computer<SearchParameters, List<Pattern>>();
    return await computer.run(findPatterns, parameters);
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

typedef ComputerCallback<M, R> = R Function(M message);

class Computer<M, R> {
  const Computer();

  Future<R> run(ComputerCallback<M, R> callback, M message) async {
    final resultPort = ReceivePort();
    final exitPort = ReceivePort();
    final errorPort = ReceivePort();

    final isolate = await Isolate.spawn<_IsolateInput<M, R>>(
      _spawn,
      _IsolateInput<M, R>(
        callback,
        message,
        resultPort.sendPort,
      ),
      onExit: exitPort.sendPort,
      onError: errorPort.sendPort,
    );

    final completer = Completer<R>();

    resultPort.listen((dynamic resultData) {
      assert(resultData is _IsolateOutput);
      if (completer.isCompleted) {
        return;
      }

      final output = resultData as _IsolateOutput;
      if (output.success) {
        assert(output.result is R);
        completer.complete(output.result);
      } else {
        final error = output.error ?? Exception('unknown error');
        completer.completeError(error);
      }
    });

    errorPort.listen((dynamic errorData) {
      assert(errorData is List<dynamic>);
      final errorDataList = errorData as List<dynamic>;
      assert(errorDataList.length == 2);
      final exception = Exception(errorDataList[0]);

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

  static void _spawn<M, R>(_IsolateInput<M, R> input) {
    try {
      final result = input.run();
      final output = _IsolateOutput<R>.success(result);
      input.resultPort.send(output);
    } catch (error) {
      final output = _IsolateOutput<R>.failure(error);
      input.resultPort.send(output);
    }
  }
}

class _IsolateInput<M, R> {
  const _IsolateInput(
    this.callback,
    this.message,
    this.resultPort,
  );

  final ComputerCallback<M, R> callback;
  final M message;
  final SendPort resultPort;

  R run() => callback(message);
}

class _IsolateOutput<R> {
  const _IsolateOutput(
    this.success,
    this.result,
    this.error,
  );

  factory _IsolateOutput.success(R result) =>
      _IsolateOutput<R>(true, result, null);

  factory _IsolateOutput.failure(dynamic error) =>
      _IsolateOutput<R>(false, null, error);

  final bool success;
  final R? result;
  final Object? error;
}
