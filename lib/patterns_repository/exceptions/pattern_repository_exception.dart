abstract class PatternRepositoryException implements Exception {
  const PatternRepositoryException(this.message);
  final String message;
}

class NoPatternsFoundException extends PatternRepositoryException {
  const NoPatternsFoundException([String message = '']) : super(message);
}

class ConstraintsNotValidException extends PatternRepositoryException {
  const ConstraintsNotValidException([String message = '']) : super(message);
}

class ConstraintMergeConflictException extends PatternRepositoryException {
  const ConstraintMergeConflictException([String message = ''])
      : super(message);
}
