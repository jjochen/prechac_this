import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListTile(
        key: Key('__juggler_details_item_${jugglerDetails.jugglerIndex}'),
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            'Objects in right hand: $rightHand\n'
            'Objects in left hand: $leftHand',
          ),
        ),
      ),
    );
  }
}
