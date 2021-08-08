import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';

typedef ComputerCallback<M, R> = R Function(M message);

class Computer<M, R> {
  Computer();

  ReceivePort? _resultPort;
  ReceivePort? _exitPort;
  Isolate? _isolate;

  Future<R> run(ComputerCallback<M, R> callback, M message) async {
    _cancelComputation();

    _resultPort = ReceivePort();
    _exitPort = ReceivePort();

    _isolate = await Isolate.spawn<IsolateInput<M, R>>(
      spawn,
      IsolateInput<M, R>(
        callback,
        message,
        _resultPort!.sendPort,
      ),
      onExit: _exitPort!.sendPort,
    );

    final completer = Completer<R>();

    _resultPort?.listen((dynamic resultData) {
      assert(resultData is IsolateOutput);
      if (completer.isCompleted) {
        return;
      }

      final output = resultData as IsolateOutput;
      if (output.success) {
        assert(output.result is R);
        completer.complete(output.result as R);
      } else {
        final error = output.error ?? Exception('unknown error');
        completer.completeError(error);
      }
    });

    _exitPort?.listen((message) {
      assert(completer.isCompleted);
    });

    await completer.future;
    _cancelComputation();
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

  void _cancelComputation() {
    _resultPort?.close();
    _exitPort?.close();
    _isolate?.kill(priority: Isolate.immediate);
    _resultPort = null;
    _exitPort = null;
    _isolate = null;
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
