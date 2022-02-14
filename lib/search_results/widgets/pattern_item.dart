import 'package:flutter/material.dart';
import 'package:prechac_this/core/core.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:prechac_this/search_results/extensions/throw_color_scheme.dart';

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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        key: Key('__pattern_item_${pattern.id}'),
        onTap: onTap,
        dense: true,
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
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .colorForStyle(style),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                    .joinToList(const TextSpan(text: ' ')),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
