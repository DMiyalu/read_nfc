import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/screens/home-screen/home.dart';
// ignore: unused_import
import 'package:sigi_android/common/screens/routestack.dart';
import 'package:sigi_android/features/authentication/presentation/login/login.dart';

import 'features/authentication/logic/cubits/authentication_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  initState() {
    BlocProvider.of<AuthenticationCubit>(context).oncheckUserAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
      int? status = state.userField!['code'];
      if (status == 200) return const Home();
      if (status == 404 || status == 500) return const Login();
      return const Scaffold();
    });
  }
}
