import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:pattern_repository/pattern_repository.dart';
import 'package:prechac_this/home/home.dart';
import 'package:formz/formz.dart';
import 'package:prechac_this/search_results/search_results.dart';

class ConstraintsForm extends StatelessWidget {
  ConstraintsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Failure')),
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
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.numberOfJugglers != current.numberOfJugglers,
      builder: (context, state) {
        return SpinBox(
          key: const Key('constraintsForm_numberOfJugglersInput'),
          onChanged: (numberOfJugglers) => context
              .read<HomeCubit>()
              .numberOfJugglersChanged(numberOfJugglers.toInt()),
          min: NumberOfJugglers.minValue.toDouble(),
          max: NumberOfJugglers.maxValue.toDouble(),
          value: NumberOfJugglers.defaultValue.toDouble(),
          decoration: InputDecoration(
            labelText: 'jugglers',
            helperText: '',
            errorText: state.numberOfJugglers.invalid
                ? 'invalid number of jugglers'
                : null,
          ),
        );
      },
    );
  }
}

class _PeriodInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => previous.period != current.period,
      builder: (context, state) {
        return SpinBox(
          key: const Key('constraintsForm_periodInput'),
          onChanged: (period) =>
              context.read<HomeCubit>().periodChanged(period.toInt()),
          min: Period.minValue.toDouble(),
          max: Period.maxValue.toDouble(),
          value: Period.defaultValue.toDouble(),
          decoration: InputDecoration(
            labelText: 'Period',
            helperText: '',
            errorText: state.period.invalid ? 'invalid period' : null,
          ),
        );
      },
    );
  }
}

class _NumberOfObjectsInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.numberOfObjects != current.numberOfObjects,
      builder: (context, state) {
        return SpinBox(
          key: const Key('constraintsForm_numberOfObjectsInput'),
          onChanged: (numberOfObjects) => context
              .read<HomeCubit>()
              .numberOfObjectsChanged(numberOfObjects.toInt()),
          min: NumberOfObjects.minValue.toDouble(),
          max: NumberOfObjects.maxValue.toDouble(),
          value: NumberOfObjects.defaultValue.toDouble(),
          decoration: InputDecoration(
            labelText: 'Objects',
            helperText: '',
            errorText: state.numberOfObjects.invalid
                ? 'invalid number of objects'
                : null,
          ),
        );
      },
    );
  }
}

class _MaxHeightInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => previous.maxHeight != current.maxHeight,
      builder: (context, state) {
        return SpinBox(
          key: const Key('constraintsForm_maxHeightInput'),
          onChanged: (maxHeight) =>
              context.read<HomeCubit>().maxHeightChanged(maxHeight.toInt()),
          min: MaxHeight.minValue.toDouble(),
          max: MaxHeight.maxValue.toDouble(),
          value: MaxHeight.defaultValue.toDouble(),
          decoration: InputDecoration(
            labelText: 'Max Height',
            helperText: '',
            errorText: state.maxHeight.invalid ? 'invalid max height' : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('constraintsForm_submit_raisedButton'),
                onPressed: () {
                  // TODO should be handled in bloc
                  if (state.status.isValidated) {
                    final parameters = SearchParameters(
                      numberOfJugglers: state.numberOfJugglers.value,
                      period: state.period.value,
                      numberOfObjects: state.numberOfObjects.value,
                      maxHeight: state.maxHeight.value,
                    );
                    Navigator.pushNamed(
                      context,
                      SearchResultsPage.routeNameWithParameters(parameters),
                    );
                  }
                }, //() => context.read<HomeCubit>().submit(),
                child: const Text('SUBMIT'),
              );
      },
    );
  }
}
