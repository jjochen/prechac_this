extension RotateableList<T> on List<T> {
  List<T> rotate([int v = 1]) {
    if (isEmpty) {
      return this;
    }

    var i = v % length;
    return sublist(i)..addAll(sublist(0, i));
  }
}
