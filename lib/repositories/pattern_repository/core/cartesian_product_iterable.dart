class CartesianProductIterable<E> extends Iterable<List<E>> {
  CartesianProductIterable(this.lists);
  final List<List<E>> lists;

  @override
  Iterator<List<E>> get iterator => CartesianProductIterator(lists);
}

class CartesianProductIterator<E> extends Iterator<List<E>> {
  CartesianProductIterator(this.lists)
      : indeces = List<int>.generate(lists.length, (index) {
          return index == lists.length - 1 ? -1 : 0;
        }),
        lengths =
            List<int>.generate(lists.length, (index) => lists[index].length);

  final List<List<E>> lists;
  final List<int> indeces;
  final List<int> lengths;
  late bool isEmpty = _getIsEmpty();
  bool _getIsEmpty() => lengths.contains(0);

  @override
  bool moveNext() {
    if (isEmpty) {
      return false;
    }

    return _moveNextAtIndex(lists.length - 1);
  }

  bool _moveNextAtIndex(int indexOfList) {
    if (indexOfList < 0) {
      return false;
    }

    final length = lengths[indexOfList];
    var indexOfElement = indeces[indexOfList];
    indexOfElement++;
    if (indexOfElement >= length) {
      indeces[indexOfList] = 0;
      return _moveNextAtIndex(indexOfList - 1);
    } else {
      indeces[indexOfList] = indexOfElement;
      return true;
    }
  }

  @override
  List<E> get current {
    var elements = <E>[];
    var indexOfList = 0;

    for (final list in lists) {
      final indexOfElement = indeces[indexOfList];
      final element = list[indexOfElement];
      elements.add(element);
      indexOfList++;
    }

    return elements;
  }
}
