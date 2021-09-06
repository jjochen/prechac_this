import 'package:flutter/material.dart';
import 'package:prechac_this/l10n/l10n.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:prechac_this/screens/pattern_details/pattern_details.dart';

class PatternDetailsPage extends StatelessWidget {
  PatternDetailsPage({
    Key? key,
    required Pattern pattern,
  })  : patternDetails = PatternDetails(pattern: pattern),
        super(key: key);

  final PatternDetails patternDetails;

  // TODO: needs tests

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.patternDetailsAppBarTitle),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: patternDetails.pattern.numberOfJugglers,
        itemBuilder: (context, index) {
          final jugglerDetails = patternDetails.infoForJuggler(index);
          return JugglerDetailsItem(jugglerDetails: jugglerDetails);
        },
      ),
    );
  }
}
