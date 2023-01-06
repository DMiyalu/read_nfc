import 'package:flutter/material.dart';

class AideScreen extends StatefulWidget {
  const AideScreen({Key? key}) : super(key: key);

  @override
  State<AideScreen> createState() => _AideScreenState();
}

class _AideScreenState extends State<AideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: Text('Aide', style: Theme.of(context).textTheme.bodyText1)),
      ),
    );
  }
}