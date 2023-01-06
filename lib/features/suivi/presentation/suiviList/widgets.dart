import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/widgets/image.dart';
import 'package:sigi_android/common/widgets/widgets.dart';
import 'package:sigi_android/features/suivi/presentation/cubit/monitoring_cubit.dart';
import 'package:sigi_android/features/suivi/presentation/cubit/monitoring_state.dart';

Widget listSuivi(context) {
  return BlocBuilder<MonitoringCubit, MonitoringState>(
      builder: (context, state) {
    return state.field!['suiviList'].isNotEmpty
        ? Column(
            children: state.field!['suiviList'].map<Widget>((suivi) {
              return suiviCard(context, suivi);
            }).toList(),
          )
        : emptyData(
            context,
            text: 'Pas de données',
            icon: Icons.data_exploration_outlined,
          );
  });
}

Widget suiviCard(context, Map suivi) {
  return ListTile(
    onTap: () {},
    leading: Ink(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: imagePreview(
        base64String: suivi['photos'][0],
        width: 50,
        height: 50,
      ),
    ),
    title: Text(
      getText(suivi['text']),
      style: Theme.of(context).textTheme.bodyText1,
    ),
  );
}
