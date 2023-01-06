import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/widgets/image.dart';
import 'package:sigi_android/common/widgets/widgets.dart';
import 'package:sigi_android/features/supervision/presentation/cubit/supervisor_cubit.dart';
import 'package:sigi_android/features/supervision/presentation/cubit/supervisor_state.dart';

Widget listSupervision(context) {
  return BlocBuilder<SupervisorCubit, SupervisorState>(
      builder: (context, state) {
    List supervisions = state.field!['supervisionList'];
    return supervisions.isNotEmpty
        ?
        // Text("data: ${_supervisions.toString()} ", style: Theme.of(context).textTheme.bodyText1,)

        Column(
            children: supervisions.map((supervisor) {
              return suiviCard(context, supervisor);
            }).toList(),
          )
        : emptyData(
            context,
            text: 'Pas de données supervisées',
            icon: Icons.data_exploration_outlined,
          );
  });
}

Widget suiviCard(context, Map supervisor) {
  return ListTile(
    onTap: () {},
    leading: Ink(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: imagePreview(
        base64String: supervisor['photos'][0],
        width: 50,
        height: 50,
      ),
    ),
    title: Text(
      getText(supervisor['text']),
      style: Theme.of(context).textTheme.bodyText1,
    ),
  );
}
