import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/core.dart';
import '../../../patterns_repository/patterns_repository.dart';

class PatternItem extends StatelessWidget {
  const PatternItem({
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
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headline6,
              children: pattern
                  .mapThrowsAsStringWithStyle(
                    (throwString, style) => TextSpan(
                      text: throwString,
                      style: textStyleForStyle(style, context),
                    ),
                  )
                  .joinToList(const TextSpan(text: ' ')),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle? textStyleForStyle(ThrowStyle style, BuildContext context) {
    switch (style) {
      case ThrowStyle.classic:
        return TextStyle(
          color: Theme.of(context).colorScheme.classicThrowColor,
        );
      case ThrowStyle.equi:
        return TextStyle(
          color: Theme.of(context).colorScheme.equiThrowColor,
        );
      case ThrowStyle.bi:
        return TextStyle(
          color: Theme.of(context).colorScheme.biThrowColor,
        );
      case ThrowStyle.instantBi:
        return TextStyle(
          color: Theme.of(context).colorScheme.instantBiThrowColor,
        );
      default:
        return null;
    }
  }
}
