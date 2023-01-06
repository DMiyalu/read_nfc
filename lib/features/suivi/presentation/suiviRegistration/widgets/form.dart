import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/common/widgets/effects.dart';
import 'package:sigi_android/features/suivi/presentation/cubit/monitoring_cubit.dart';
import 'package:sigi_android/features/suivi/presentation/cubit/monitoring_state.dart';

Widget form(context, GlobalKey<FormState> formKey) {
  return Form(
    key: formKey,
    child: Column(children: [
      BlocBuilder<MonitoringCubit, MonitoringState>(builder: (context, state) {
        return TextFormField(
          onChanged: (String text) {
            Map data = state.field!['data'];
            data['text'] = text;
            BlocProvider.of<MonitoringCubit>(context).onValueChange(data: data);
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
                "Veuillez entrez ici vos differentes observations sur le terrain",
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
          ),
        );
      }),
      const SizedBox(height: 25),
      _loader(context),
      BlocBuilder<MonitoringCubit, MonitoringState>(builder: (context, state) {
        return customButton(
          context,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if (state.field!['data']['photos'].isEmpty) {
                BlocProvider.of<MonitoringCubit>(context).onValideImages();
                return;
              }
              BlocProvider.of<MonitoringCubit>(context).onSendMonitoringData();
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
  return BlocBuilder<MonitoringCubit, MonitoringState>(
      builder: (context, state) {
    return state.field!['sending']
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(child: loader(context)),
          )
        : const SizedBox.shrink();
  });
}
