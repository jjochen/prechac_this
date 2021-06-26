import 'package:equatable/equatable.dart';

abstract class PatternRepositoryException
    with EquatableMixin
    implements Exception {
  const PatternRepositoryException(this.message);

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
