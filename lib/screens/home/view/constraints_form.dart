import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../../l10n/l10n.dart';
import '../home.dart';
import 'error_messages.dart';

class ConstraintsForm extends StatelessWidget {
  const ConstraintsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const interItemSpacing = 20.0;

    return BlocListener<ConstraintsFormBloc, ConstraintsFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          final l10n = context.l10n;
          final message = l10n.errorMessage(state.error);
          if (message != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  key: const Key('constraintsForm_errorSnackBar'),
                  content: Text(message),
                ),
              );
          }
        }
      },
      child: SingleChildScrollView(
        child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 350),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _NumberOfJugglersInput(),
                  const SizedBox(height: interItemSpacing),
                  _PeriodInput(),
                  const SizedBox(height: interItemSpacing),
                  _NumberOfObjectsInput(),
                  const SizedBox(height: interItemSpacing),
                  _MaxHeightInput(),
                  const SizedBox(height: interItemSpacing),
                  _MinNumberOfPassesInput(),
                  const SizedBox(height: interItemSpacing),
                  _MaxNumberOfPassesInput(),
                  const SizedBox(height: interItemSpacing),
                  _ContainsInput(),
                  const SizedBox(height: interItemSpacing),
                  _SubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DropDownFormField extends FormField<int?> {
  _DropDownFormField({
    Key? key,
    required ValueChanged<int> onChanged,
    required int minValue,
    required int maxValue,
    int? initialValue,
    bool isRequired = true,
    InputDecoration? decoration,
  }) : super(
            key: key,
            initialValue: initialValue,
            builder: (state) {
              return SelectFormField(
                onChanged: (stringValue) {
                  var intValue = int.parse(stringValue);
                  return onChanged(intValue);
                },
                type: SelectFormFieldType.dropdown,
                initialValue: initialValue.toString(),
                decoration: decoration,
                items: _items(
                  minValue,
                  maxValue,
                  isRequired,
                ),
              );
            });

  static List<Map<String, dynamic>> _items(
    int minValue,
    int maxValue,
    bool isRequired,
  ) {
    var items = <Map<String, dynamic>>[];
    if (!isRequired) {
      items.add({
        'value': null,
        'label': '',
      });
    }

    items.addAll(
      List.generate(
        maxValue - minValue + 1,
        (index) => {'value': index + minValue},
      ),
    );

    return items;
  }
}

class _NumberOfJugglersInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) =>
          previous.numberOfJugglers != current.numberOfJugglers,
      builder: (context, state) {
        return _DropDownFormField(
          key: const Key('constraintsForm_numberOfJugglersInput'),
          onChanged: (numberOfJugglers) => context
              .read<ConstraintsFormBloc>()
              .add(NumberOfJugglersDidChange(numberOfJugglers)),
          minValue: NumberOfJugglers.minValue,
          maxValue: NumberOfJugglers.maxValue,
          initialValue: NumberOfJugglers.defaultValue,
          decoration: InputDecoration(
            labelText: l10n.constraintsFormNumberOfJugglersLabel,
            errorText: l10n.errorMessage(state.numberOfJugglers.error),
          ),
        );
      },
    );
  }
}

class _PeriodInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) => previous.period != current.period,
      builder: (context, state) {
        return _DropDownFormField(
          key: const Key('constraintsForm_periodInput'),
          onChanged: (period) =>
              context.read<ConstraintsFormBloc>().add(PeriodDidChange(period)),
          minValue: Period.minValue,
          maxValue: Period.maxValue,
          initialValue: Period.defaultValue,
          decoration: InputDecoration(
            labelText: l10n.constraintsFormPeriodLabel,
            errorText: l10n.errorMessage(state.period.error),
          ),
        );
      },
    );
  }
}

class _NumberOfObjectsInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) =>
          previous.numberOfObjects != current.numberOfObjects,
      builder: (context, state) {
        return _DropDownFormField(
          key: const Key('constraintsForm_numberOfObjectsInput'),
          onChanged: (numberOfObjects) => context
              .read<ConstraintsFormBloc>()
              .add(NumberOfObjectsDidChange(numberOfObjects.toInt())),
          minValue: NumberOfObjects.minValue,
          maxValue: NumberOfObjects.maxValue,
          initialValue: NumberOfObjects.defaultValue,
          decoration: InputDecoration(
            labelText: l10n.constraintsFormNumberOfObjectsLabel,
            errorText: l10n.errorMessage(
              state.numberOfObjects.error,
            ),
          ),
        );
      },
    );
  }
}

class _MaxHeightInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) => previous.maxHeight != current.maxHeight,
      builder: (context, state) {
        return _DropDownFormField(
          key: const Key('constraintsForm_maxHeightInput'),
          onChanged: (maxHeight) => context
              .read<ConstraintsFormBloc>()
              .add(MaxHeightDidChange(maxHeight.toInt())),
          minValue: MaxHeight.minValue,
          maxValue: MaxHeight.maxValue,
          initialValue: MaxHeight.defaultValue,
          decoration: InputDecoration(
            labelText: l10n.constraintsFormMaxHeightLabel,
            errorText: l10n.errorMessage(
              state.maxHeight.error,
            ),
          ),
        );
      },
    );
  }
}

class _MinNumberOfPassesInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) =>
          previous.minNumberOfPasses != current.minNumberOfPasses ||
          previous.period != current.period,
      builder: (context, state) {
        return _DropDownFormField(
          key: const Key('constraintsForm_minNumberOfPassesInput'),
          onChanged: (minNumberOfPasses) => context
              .read<ConstraintsFormBloc>()
              .add(MinNumberOfPassesDidChange(minNumberOfPasses.toInt())),
          minValue: MinNumberOfPasses.minValue,
          maxValue: min(MinNumberOfPasses.maxValue, state.period.value),
          initialValue: min(MinNumberOfPasses.defaultValue, state.period.value),
          decoration: InputDecoration(
            labelText: l10n.constraintsFormMinNumberOfPassesLabel,
            errorText: l10n.errorMessage(state.minNumberOfPasses.error),
          ),
        );
      },
    );
  }
}

class _MaxNumberOfPassesInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) =>
          previous.maxNumberOfPasses != current.maxNumberOfPasses ||
          previous.period != current.period,
      builder: (context, state) {
        return _DropDownFormField(
          key: const Key('constraintsForm_maxNumberOfPassesInput'),
          onChanged: (maxNumberOfPasses) => context
              .read<ConstraintsFormBloc>()
              .add(MaxNumberOfPassesDidChange(maxNumberOfPasses)),
          minValue: MaxNumberOfPasses.minValue,
          maxValue: min(MaxNumberOfPasses.maxValue, state.period.value),
          initialValue: MaxNumberOfPasses.defaultValue,
          isRequired: false,
          decoration: InputDecoration(
            labelText: l10n.constraintsFormMaxNumberOfPassesLabel,
            errorText: l10n.errorMessage(state.maxNumberOfPasses.error),
          ),
        );
      },
    );
  }
}

class _ContainsInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) => previous.contains != current.contains,
      builder: (context, state) {
        return TextField(
          key: const Key('constraintsForm_containsInput'),
          onChanged: (contains) => context
              .read<ConstraintsFormBloc>()
              .add(ContainsDidChange(contains)),
          decoration: InputDecoration(
            labelText: l10n.constraintsFormContainsLabel,
            errorText: l10n.errorMessage(
              state.contains.error,
            ),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator(
                key: Key('constraintsForm_submit_progressIndicator'),
              )
            : ElevatedButton(
                key: const Key('constraintsForm_submit_raisedButton'),
                onPressed: state.status.isValidated
                    ? () => context.read<ConstraintsFormBloc>().add(Submit())
                    : null,
                child: Text(l10n.constraintsFormSubmitButtonText),
              );
      },
    );
  }
}
