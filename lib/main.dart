import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'common/config/providers.dart';
import 'common/config/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'common/config/themedata.dart';
import 'package:path_provider/path_provider.dart';
import 'common/widgets/error_widget.dart';
import 'features/authentication/logic/cubits/authentication_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path.toString());
  ErrorWidget.builder = (FlutterErrorDetails details) {
    bool inDebug = false;
    assert(() {
      inDebug = true;
      return true;
    }());
    if (inDebug) {
      return ErrorWidget(details.exception);
    }
    return customErrorWidget(details);
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...getProviders(),
        BlocProvider<AuthenticationCubit>(
          create: (BuildContext context) => AuthenticationCubit(),
        ),
      ],
      child: GetMaterialApp(
        title: 'SIGI ANDROID',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fr'),
        ],
        getPages: getPages(),
        theme: themeData(),
        initialRoute: '/splash',
      ),
    );
  }
}
