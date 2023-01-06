// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/features/authentication/logic/cubits/authentication_cubit.dart';

Widget errorOnLogin() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
      // int? code = state.userField!['code'];
      String? text = state.userField!["error"];
      if (text == null || text == "") return const SizedBox.shrink();
      return Text(text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.red,
              ),
          softWrap: true);
    }),
  );
}
