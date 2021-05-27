extension ConfigMap on Map<String, dynamic> {
  V? tryValueForKey<V>(String key) {
    final value = this[key];

    if (value == null) {
      return null;
    }

    if (value is V) {
      return value;
    }

    return null;
  }

  V valueForKey<V>(String key, {required V fallback}) {
    final value = this[key];

    if (value == null) {
      return fallback;
    }

    if (value is V) {
      return value;
    }

    return fallback;
  }

  String? tryStringForKey(String key) {
    return tryValueForKey<String>(key);
  }

  String stringForKey(String key, {required String fallback}) {
    return valueForKey<String>(key, fallback: fallback);
  }

  Uri? tryUriForKey(String key) {
    final uriString = tryStringForKey(key);
    if (uriString == null) {
      return null;
    }

    return Uri.tryParse(uriString);
  }

  Uri uriForKey(String key, {required Uri fallback}) {
    return tryUriForKey(key) ?? fallback;
  }

  bool boolForKey(String key, {required bool fallback}) {
    final value = tryValueForKey<dynamic>(key);

    if (value == null) {
      return fallback;
    }

    if (value is bool) {
      return value;
    }

    if (value is int) {
      if (value == 1) {
        return true;
      } else if (value == 0) {
        return false;
      } else {
        return fallback;
      }
    }

    if (value is String) {
      if (value == 'true') {
        return true;
      } else if (value == 'false') {
        return false;
      } else {
        return fallback;
      }
    }

    return fallback;
  }

  int intForKey(String key, {required int fallback}) {
    final value = tryValueForKey<dynamic>(key);

    if (value == null) {
      return fallback;
    }

    if (value is int) {
      return value;
    }

    if (value is String) {
      return int.tryParse(value) ?? fallback;
    }

    return fallback;
  }

  double doubleForKey(String key, {required double fallback}) {
    final value = tryValueForKey<dynamic>(key);

    if (value == null) {
      return fallback;
    }

    if (value is double) {
      return value;
    }

    if (value is String) {
      return double.tryParse(value) ?? fallback;
    }

    return fallback;
  }
}
