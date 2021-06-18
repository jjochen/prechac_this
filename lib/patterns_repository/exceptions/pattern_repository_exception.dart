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
  const NoPatternsFoundException([String message = '']) : super(message);
}

class ConstraintsNotValidException extends PatternRepositoryException {
  const ConstraintsNotValidException([String message = '']) : super(message);
}

// TODO: rename
class ConstraintMergeConflictException extends PatternRepositoryException {
  const ConstraintMergeConflictException([String message = ''])
      : super(message);
}
