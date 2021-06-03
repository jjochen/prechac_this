import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../patterns_repository/patterns_repository.dart';

class PatternItem extends StatelessWidget {
  PatternItem({
    Key? key,
    required this.pattern,
    this.onTap,
  }) : super(key: key);

  final Pattern pattern;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key('__pattern_item_${pattern.id}'),
      onTap: onTap,
      title: Hero(
        tag: '${pattern.id}__heroTag',
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            pattern.toString(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
