// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/common/widgets/effects.dart';
import 'package:sigi_android/features/supervision/presentation/cubit/supervisor_cubit.dart';
import 'package:sigi_android/features/supervision/presentation/cubit/supervisor_state.dart';

Widget form(context, GlobalKey<FormState> formKey) {
  return Form(
    key: formKey,
    child: Column(children: [
      BlocBuilder<SupervisorCubit, SupervisorState>(builder: (context, state) {
        return TextFormField(
          onChanged: (String text) {
            Map data = state.field!['data'];
            data['text'] = text;
            BlocProvider.of<SupervisorCubit>(context).onValueChange(data: data);
          },
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
          validator: (String? value) {
            if (value == '') {
              return 'Mettez une description';
            }
          },
          autofocus: false,
          maxLines: 5,
          minLines: 1,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hintText: "Note ou commentaire de supervision",
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
          ),
        );
      }),
      const SizedBox(height: 25),
      _loader(context),
      BlocBuilder<SupervisorCubit, SupervisorState>(builder: (context, state) {
        return customButton(
          context,
          onPressed: () {
            print("*****tape");
            if (formKey.currentState!.validate()) {
              if (state.field!['data']['photos'].isEmpty) {
                print("*****image validation");
                BlocProvider.of<SupervisorCubit>(context).onValideImages();
                return;
              }
              print("*****validation sucess");
              BlocProvider.of<SupervisorCubit>(context).onSendSupervisionData();
            }
          },
          text: "Terminer",
          textColor: Colors.white,
          bkgColor: Theme.of(context).colorScheme.primary,
        );
      })
    ]),
  );
}

Widget _loader(context) {
  return BlocBuilder<SupervisorCubit, SupervisorState>(
      builder: (context, state) {
    return state.field!['sending']
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(child: loader(context)),
          )
        : const SizedBox.shrink();
  });
}
