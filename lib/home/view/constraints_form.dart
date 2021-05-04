import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:prechac_this/home/home.dart';
import 'package:formz/formz.dart';

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _NumberOfJugglersInput(),
              const SizedBox(height: 8.0),
              _PeriodInput(),
              const SizedBox(height: 8.0),
              _NumberOfObjectsInput(),
              const SizedBox(height: 8.0),
              _MaxHeightInput(),
              const SizedBox(height: 8.0),
              _SubmitButton(),
            ],
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
        return TextField(
          key: const Key('constraintsForm_numberOfJugglersInput_textField'),
          onChanged: (numberOfJugglersString) => context
              .read<HomeCubit>()
              .numberOfJugglersChanged(int.parse(numberOfJugglersString)),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'number of jugglers',
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
        return TextField(
          key: const Key('constraintsForm_periodInput_textField'),
          onChanged: (periodString) =>
              context.read<HomeCubit>().periodChanged(int.parse(periodString)),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'period',
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
        return TextField(
          key: const Key('constraintsForm_numberOfObjectsInput_textField'),
          onChanged: (numberOfObjectsString) => context
              .read<HomeCubit>()
              .numberOfObjectsChanged(int.parse(numberOfObjectsString)),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'numberOfObjects',
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
        return TextField(
          key: const Key('constraintsForm_maxHeightInput_textField'),
          onChanged: (maxHeightString) => context
              .read<HomeCubit>()
              .maxHeightChanged(int.parse(maxHeightString)),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'max height',
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
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  primary: const Color(0xFFFFD600),
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<HomeCubit>().submit()
                    : null,
                child: const Text('SUBMIT'),
              );
      },
    );
  }
}
