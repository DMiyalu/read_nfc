import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/widgets/effects.dart';
import '../cubit/cubit/demande_intrant_registration_cubit.dart';
import 'damande_intrant_form.dart';
import 'widgets_form.dart';
import 'identification.dart';

Widget formTitle(context) {
  return BlocBuilder<DemandeIntrantRegistrationCubit,
      DemandeIntrantRegistrationState>(builder: (context, state) {
    return Text(
      state.field!['formTitle'] ?? 'Demande intrant',
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.white,
          ),
    );
  });
}

Widget formStep(context, GlobalKey<FormState> formKey) {
  return BlocBuilder<DemandeIntrantRegistrationCubit,
      DemandeIntrantRegistrationState>(builder: (context, state) {
    int formStep = state.field!['step'];
    if (formStep == 1) {
      return const Identification();
    }
    if (formStep == 2) {
      return previewProductorInfos(context, formKey);
    }
    if (formStep == 3) {
      return const DemandeIntrantForm();
    }
    return Center(child: loader(context));
  });
}
