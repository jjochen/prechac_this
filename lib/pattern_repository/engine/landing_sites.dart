extension LandingSites on List<int> {
  List<int> fillMissingSites(List<int> missing) {
    return map((site) {
      if (site < 0) {
        final first = missing.first;
        missing.removeAt(0);
        return first;
      } else {
        return site;
      }
    }).toList();
  }
}
