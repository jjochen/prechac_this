import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:formz/formz.dart';

import '../home.dart';

class ConstraintsForm extends StatelessWidget {
  const ConstraintsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConstraintsFormBloc, ConstraintsFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure && state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 250),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _NumberOfJugglersInput(),
                const SizedBox(height: 2.0),
                _PeriodInput(),
                const SizedBox(height: 2.0),
                _NumberOfObjectsInput(),
                const SizedBox(height: 2.0),
                _MaxHeightInput(),
                const SizedBox(height: 2.0),
                _MinNumberOfPassesInput(),
                const SizedBox(height: 2.0),
                _MaxNumberOfPassesInput(),
                const SizedBox(height: 2.0),
                _ContainsInput(),
                const SizedBox(height: 2.0),
                _SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NumberOfJugglersInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) =>
          previous.numberOfJugglers != current.numberOfJugglers,
      builder: (context, state) {
        return SpinBox(
          key: const Key('constraintsForm_numberOfJugglersInput'),
          onChanged: (numberOfJugglers) => context
              .read<ConstraintsFormBloc>()
              .add(NumberOfJugglersDidChange(numberOfJugglers.toInt())),
          min: NumberOfJugglers.minValue.toDouble(),
          max: NumberOfJugglers.maxValue.toDouble(),
          value: NumberOfJugglers.defaultValue.toDouble(),
          decoration: InputDecoration(
            labelText: 'jugglers',
            helperText: '',
            errorText: state.numberOfJugglers.errorText,
          ),
        );
      },
    );
  }
}

class _PeriodInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) => previous.period != current.period,
      builder: (context, state) {
        return SpinBox(
          key: const Key('constraintsForm_periodInput'),
          onChanged: (period) => context
              .read<ConstraintsFormBloc>()
              .add(PeriodDidChange(period.toInt())),
          min: Period.minValue.toDouble(),
          max: Period.maxValue.toDouble(),
          value: Period.defaultValue.toDouble(),
          decoration: InputDecoration(
            labelText: 'Period',
            helperText: '',
            errorText: state.period.errorText,
          ),
        );
      },
    );
  }
}

class _NumberOfObjectsInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) =>
          previous.numberOfObjects != current.numberOfObjects,
      builder: (context, state) {
        return SpinBox(
          key: const Key('constraintsForm_numberOfObjectsInput'),
          onChanged: (numberOfObjects) => context
              .read<ConstraintsFormBloc>()
              .add(NumberOfObjectsDidChange(numberOfObjects.toInt())),
          min: NumberOfObjects.minValue.toDouble(),
          max: NumberOfObjects.maxValue.toDouble(),
          value: NumberOfObjects.defaultValue.toDouble(),
          decoration: InputDecoration(
            labelText: 'Objects',
            helperText: '',
            errorText: state.numberOfObjects.errorText,
          ),
        );
      },
    );
  }
}

class _MaxHeightInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) => previous.maxHeight != current.maxHeight,
      builder: (context, state) {
        return SpinBox(
          key: const Key('constraintsForm_maxHeightInput'),
          onChanged: (maxHeight) => context
              .read<ConstraintsFormBloc>()
              .add(MaxHeightDidChange(maxHeight.toInt())),
          min: MaxHeight.minValue.toDouble(),
          max: MaxHeight.maxValue.toDouble(),
          value: MaxHeight.defaultValue.toDouble(),
          decoration: InputDecoration(
            labelText: 'Max Height',
            helperText: '',
            errorText: state.maxHeight.errorText,
          ),
        );
      },
    );
  }
}

class _MinNumberOfPassesInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) =>
          previous.minNumberOfPasses != current.minNumberOfPasses,
      builder: (context, state) {
        return SpinBox(
          key: const Key('constraintsForm_minNumberOfPassesInput'),
          onChanged: (minNumberOfPasses) => context
              .read<ConstraintsFormBloc>()
              .add(MinNumberOfPassesDidChange(minNumberOfPasses.toInt())),
          min: MinNumberOfPasses.minValue.toDouble(),
          max: MinNumberOfPasses.maxValue.toDouble(),
          value: MinNumberOfPasses.defaultValue.toDouble(),
          decoration: InputDecoration(
            labelText: 'Min number of passes',
            helperText: '',
            errorText: state.minNumberOfPasses.errorText,
          ),
        );
      },
    );
  }
}

class _MaxNumberOfPassesInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) =>
          previous.maxNumberOfPasses != current.maxNumberOfPasses,
      builder: (context, state) {
        return SpinBox(
          key: const Key('constraintsForm_maxNumberOfPassesInput'),
          onChanged: (maxNumberOfPasses) => context
              .read<ConstraintsFormBloc>()
              .add(MaxNumberOfPassesDidChange(maxNumberOfPasses.toInt())),
          min: MaxNumberOfPasses.minValue.toDouble(),
          max: MaxNumberOfPasses.maxValue.toDouble(),
          value: MaxNumberOfPasses.defaultValue.toDouble(),
          decoration: InputDecoration(
            labelText: 'Max number of passes',
            helperText: '',
            errorText: state.maxNumberOfPasses.errorText,
          ),
        );
      },
    );
  }
}

class _ContainsInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConstraintsFormBloc, ConstraintsFormState>(
      buildWhen: (previous, current) => previous.contains != current.contains,
      builder: (context, state) {
        return TextField(
          key: const Key('constraintsForm_containsInput'),
          onChanged: (contains) => context
              .read<ConstraintsFormBloc>()
              .add(ContainsDidChange(contains)),
          decoration: InputDecoration(
            labelText: 'Contains',
            helperText: '',
            errorText: state.maxNumberOfPasses.errorText,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                child: const Text('SUBMIT'),
              );
      },
    );
  }
}
