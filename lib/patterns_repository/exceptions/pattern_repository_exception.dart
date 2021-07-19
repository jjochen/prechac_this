import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
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
  const NoPatternsFoundException([String message = '']) : super(message);
}

class ConstraintsInvalidException extends PatternRepositoryException {
  const ConstraintsInvalidException([String message = '']) : super(message);
}
