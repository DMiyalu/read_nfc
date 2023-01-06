import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/features/supervision/presentation/cubit/supervisor_cubit.dart';
import 'package:sigi_android/features/supervision/presentation/cubit/supervisor_state.dart';
import 'widgets/form.dart';
import 'widgets/widgets.dart';

class SupervisorForm extends StatefulWidget {
  const SupervisorForm({Key? key}) : super(key: key);

  @override
  State<SupervisorForm> createState() => _SupervisorFormState();
}

class _SupervisorFormState extends State<SupervisorForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            Center(
              child: Text(
                'Appuyer pour prendre une image',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
            BlocBuilder<SupervisorCubit, SupervisorState>(
                builder: (context, state) {
              return state.field!['showImageRequired']
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Prennez au moins une capture',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.red,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            }),
            const SizedBox(height: 10),
            Ink(
              child: InkWell(
                onTap: () =>
                    BlocProvider.of<SupervisorCubit>(context).onTakePicture(),
                child: Icon(
                  Icons.camera,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 65,
                ),
              ),
            ),
            const SizedBox(height: 20),
            images(context),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Note ou commentaire de supervision',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.left,
              ),
            ),
            // const SizedBox(height: 15),
            form(context, formKey),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
