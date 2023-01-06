import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/features/authentication/logic/cubits/authentication_cubit.dart';
import 'package:sigi_android/features/authentication/presentation/login/widgets/errorLogin.dart';
import 'form_widgets.dart';

Widget form(context, GlobalKey<FormState> formKey) {
  final email = TextEditingController();
  final password = TextEditingController();

  return Form(
    key: formKey,
    child: Column(
      children: [
        errorOnLogin(),
        const SizedBox(height: 20.0),
        nameField(context,
            label: "Numéro téléphone",
            hint: "08xxxxxxxx",
            icon: Icons.mail_outline_rounded,
            text: email),
        const SizedBox(height: 20),
        nameField(context,
            label: "Mot de passe",
            hint: "*******",
            icon: Icons.lock_outline_rounded,
            obscureText: true,
            text: password),
        const SizedBox(height: 10),
        passwordLost(context),
        const SizedBox(height: 35),
        customButton(context,
            text: "Se connecter",
            bkgColor: Theme.of(context).colorScheme.primary,
            textColor: Colors.white, onPressed: () async {
          if (formKey.currentState!.validate()) {
            BlocProvider.of<AuthenticationCubit>(context).onLoginUser(context,
                email: email.text, password: password.text);
          }
        })
      ],
    ),
  );
}

Widget passwordLost(context) {
  return Align(
    alignment: Alignment.centerRight,
    child: Ink(
      child: InkWell(
        onTap: () {},
        child: Text(
          "Mot de passe oublié ?",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.grey,
              ),
        ),
      ),
    ),
  );
}
