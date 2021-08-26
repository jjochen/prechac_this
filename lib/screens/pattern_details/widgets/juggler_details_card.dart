import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

class JugglerDetailsCard extends StatelessWidget {
  const JugglerDetailsCard({
    Key? key,
    required this.jugglerDetails,
  }) : super(key: key);

  final JugglerDetails jugglerDetails;

  @override
  Widget build(BuildContext context) {
    final rightHand = jugglerDetails.numberOfObjectsInHand(Hand.right);
    final leftHand = jugglerDetails.numberOfObjectsInHand(Hand.left);
    return Card(
      child: Text(
        'Objects in right hand: $rightHand\n'
        'Objects in left hand: $leftHand',
      ),
    );
  }
}
