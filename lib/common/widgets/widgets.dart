import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/features/synchronization/download/cubit/synchronization_download_cubit.dart';

Widget emptyData(context, {required String text, IconData? icon}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon ?? Icons.do_disturb_alt_sharp,
          size: 50,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 20),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

String getText(String text) {
  if (text.length > 15) return "${text.substring(1, 15)}...";
  return text;
}

// Showing bottomSheet on UI during download(synchronization)
Widget downloadStatus(context) {
  return BlocBuilder<SynchronizationDownloadCubit,
      SynchronizationDownloadState>(builder: (context, state) {
    return Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.10,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        border: Border.all(color: Colors.black12, width: 3.0),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Text(
        'Chargement ${state.field!['step']}...',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
            ),
        textAlign: TextAlign.center,
      ),
    );
  });
}
