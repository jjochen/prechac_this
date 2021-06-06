extension Joinable<E> on Iterable<E> {
  List<E> joinToList(E separator) {
    var iterator = this.iterator;
    if (!iterator.moveNext()) {
      return [];
    }

    var list = <E>[]..add(iterator.current);
    while (iterator.moveNext()) {
      list..add(separator)..add(iterator.current);
    }

    return list;
  }
}
