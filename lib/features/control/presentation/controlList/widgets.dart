import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/widgets/image.dart';
import 'package:sigi_android/common/widgets/widgets.dart';
import 'package:sigi_android/features/control/presentation/cubit/control_cubit.dart';
import 'package:sigi_android/features/control/presentation/cubit/control_state.dart';

Widget listControl(context) {
  return BlocBuilder<ControlCubit, ControlState>(builder: (context, state) {
    return state.field!['controlList'].isNotEmpty
        ? Column(
            children: state.field!['controlList'].map<Widget>((control) {
              return controlCard(context, control);
            }).toList(),
          )
        : emptyData(
            context,
            text: 'Pas de données',
            icon: Icons.data_exploration_outlined,
          );
  });
}

Widget controlCard(context, Map control) {
  return ListTile(
    onTap: () {},
    leading: Ink(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: imagePreview(
        base64String: control['photos'][0],
        width: 50,
        height: 50,
      ),
    ),
    title: Text(
      getText(control['text']),
      style: Theme.of(context).textTheme.bodyText1,
    ),
  );
}
