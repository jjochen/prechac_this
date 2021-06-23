import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';

abstract class PatternRepositoryException
    with EquatableMixin
    implements Exception {
  const PatternRepositoryException(this.message);

  factory PatternRepositoryException.fromErrorData(dynamic data) {
    assert(data is String);
    final string = data as String;

    final components = string.split(': ');
    final type = components.elementAtOrNull(0);
    final message = components.elementAtOrNull(1) ?? '';

    if (type == 'NoPatternsFoundException') {
      return NoPatternsFoundException(message);
    }

    assert(type == 'ConstraintsInvalidException');
    return ConstraintsInvalidException(message);
  }

  final String message;

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    final type = runtimeType.toString();
    if (message.isEmpty) {
      return type;
    }
    return '$type: $message';
  }
}

class NoPatternsFoundException extends PatternRepositoryException {
  NoPatternsFoundException([String message = '']) : super(message);
}

class ConstraintsInvalidException extends PatternRepositoryException {
  ConstraintsInvalidException([String message = '']) : super(message);
}
