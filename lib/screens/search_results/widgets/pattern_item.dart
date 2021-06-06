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
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headline6,
              children: pattern
                  .mapThrowsAsStringWithStyle(
                    (throwString, style) => TextSpan(
                      text: '$throwString ',
                      style: textStyleForStyle(style),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle? textStyleForStyle(ThrowStyle style) {
    switch (style) {
      case ThrowStyle.classic:
        return const TextStyle(color: Color(0xff0000ff));
      case ThrowStyle.equi:
        return const TextStyle(color: Color(0xffff0000));
      case ThrowStyle.bi:
        return const TextStyle(color: Color(0xff800080));
      case ThrowStyle.instantbi:
        return const TextStyle(color: Color(0xff00ff00));
      default:
        return null;
    }
  }
}
