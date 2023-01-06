import 'package:flutter/material.dart';
import 'widgets/form.dart';
import 'widgets/logo.dart';
import 'widgets/title.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              logo(context),
              const SizedBox(height: 70),
              title(context),
              const SizedBox(height: 70),
              form(context, _formKey),
              const SizedBox(height: 45),
              partnersLogo(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
