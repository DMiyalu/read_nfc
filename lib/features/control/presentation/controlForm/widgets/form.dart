import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/common/widgets/effects.dart';
import 'package:sigi_android/features/control/presentation/cubit/control_cubit.dart';
import 'package:sigi_android/features/control/presentation/cubit/control_state.dart';

Widget form(context, GlobalKey<FormState> formKey) {
  return Form(
    key: formKey,
    child: Column(children: [
      BlocBuilder<ControlCubit, ControlState>(builder: (context, state) {
        return TextFormField(
          onChanged: (String text) {
            Map data = state.field!['data'];
            data['text'] = text;
            BlocProvider.of<ControlCubit>(context).onValueChange(data: data);
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
            hintText:
                "Veuillez entrez ici vos remarques ou observations",
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
          ),
        );
      }),
      const SizedBox(height: 25),
      _loader(context),
      BlocBuilder<ControlCubit, ControlState>(builder: (context, state) {
        return customButton(
          context,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if (state.field!['data']['photos'].isEmpty) {
                BlocProvider.of<ControlCubit>(context).onValideImages();
                return;
              }
              BlocProvider.of<ControlCubit>(context).onSendControlData();
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
  return BlocBuilder<ControlCubit, ControlState>(
      builder: (context, state) {
    return state.field!['sending']
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(child: loader(context)),
          )
        : const SizedBox.shrink();
  });
}
