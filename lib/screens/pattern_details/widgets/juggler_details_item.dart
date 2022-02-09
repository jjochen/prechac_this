import 'package:flutter/material.dart';
import 'package:prechac_this/core/core.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:prechac_this/screens/search_results/extensions/throw_color_scheme.dart';

class JugglerDetailsItem extends StatelessWidget {
  const JugglerDetailsItem({
    Key? key,
    required this.jugglerDetails,
  }) : super(key: key);

  final JugglerDetails jugglerDetails;

  @override
  Widget build(BuildContext context) {
    final rightHand = jugglerDetails.numberOfObjectsInHand(Hand.right);
    final leftHand = jugglerDetails.numberOfObjectsInHand(Hand.left);
    final jugglerName = jugglerDetails.jugglerIndex + 1;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListTile(
        key: Key('__juggler_details_item_${jugglerDetails.jugglerIndex}'),
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Juggler $jugglerName'),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.headline6,
                  children: jugglerDetails.localPattern
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
              Text('Objects in right hand: $rightHand'),
              Text('Objects in left hand: $leftHand'),
            ],
          ),
        ),
      ),
    );
  }
}
