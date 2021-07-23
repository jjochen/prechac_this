import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';

typedef ComputerCallback<M, R> = R Function(M message);

class Computer<M, R> {
  const Computer();

  Future<R> run(ComputerCallback<M, R> callback, M message) async {
    // TODO: cancel previous computation

    final resultPort = ReceivePort();
    final exitPort = ReceivePort();

    final isolate = await Isolate.spawn<IsolateInput<M, R>>(
      spawn,
      IsolateInput<M, R>(
        callback,
        message,
        resultPort.sendPort,
      ),
      onExit: exitPort.sendPort,
    );

    final completer = Completer<R>();

    resultPort.listen((dynamic resultData) {
      assert(resultData is IsolateOutput);
      if (completer.isCompleted) {
        return;
      }

      final output = resultData as IsolateOutput;
      if (output.success) {
        assert(output.result is R);
        completer.complete(output.result);
      } else {
        final error = output.error ?? Exception('unknown error');
        completer.completeError(error);
      }
    });

    exitPort.listen((message) {
      assert(completer.isCompleted);
    });

    await completer.future;
    resultPort.close();
    isolate.kill();
    return completer.future;
  }

  // code coverage not collected for isolates
  @visibleForTesting
  static void spawn<M, R>(IsolateInput<M, R> input) {
    try {
      final result = input.run();
      final output = IsolateOutput<R>.success(result);
      input.resultPort.send(output);
    } catch (error) {
      final output = IsolateOutput<R>.failure(error);
      input.resultPort.send(output);
    }
  }
}

@immutable
@visibleForTesting
class IsolateInput<M, R> {
  const IsolateInput(
    this.callback,
    this.message,
    this.resultPort,
  );

  final ComputerCallback<M, R> callback;
  final M message;
  final SendPort resultPort;

  R run() => callback(message);
}

@immutable
@visibleForTesting
class IsolateOutput<R> {
  const IsolateOutput(
    this.success,
    this.result,
    this.error,
  );

  factory IsolateOutput.success(R result) =>
      IsolateOutput<R>(true, result, null);

  factory IsolateOutput.failure(dynamic error) =>
      IsolateOutput<R>(false, null, error);

  final bool success;
  final R? result;
  final Object? error;
}
