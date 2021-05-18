mixin Compare<T> on Comparable<T> {
  bool operator <=(T other) => compareTo(other) <= 0;

  bool operator >=(T other) => compareTo(other) >= 0;

  bool operator <(T other) => compareTo(other) < 0;

  bool operator >(T other) => compareTo(other) > 0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    // ignore: test_types_in_equals
    return other is T && compareTo(other as T) == 0;
  }
}
