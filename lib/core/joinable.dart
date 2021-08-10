extension Joinable<E> on Iterable<E> {
  List<E> joinToList(E separator) {
    final iterator = this.iterator;
    if (!iterator.moveNext()) {
      return [];
    }

    final list = <E>[iterator.current];
    while (iterator.moveNext()) {
      list..add(separator)..add(iterator.current);
    }

    return list;
  }
}
