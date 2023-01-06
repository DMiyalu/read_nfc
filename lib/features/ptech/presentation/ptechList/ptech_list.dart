import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/widgets/appbar.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/common/widgets/widgets.dart';
import 'package:sigi_android/features/producteur/presentation/demandeIntrantList/widgets/producteur_card.dart';
import 'package:sigi_android/features/ptech/data/ptech_model.dart';
import 'package:sigi_android/features/ptech/presentation/ptechList/cubit/ptech_cubit.dart';
import 'package:sigi_android/features/ptech/presentation/ptechList/cubit/ptech_state.dart';

class PtechList extends StatefulWidget {
  const PtechList({Key? key}) : super(key: key);

  @override
  State<PtechList> createState() => _PtechListState();
}

class _PtechListState extends State<PtechList> {
  @override
  void initState() {
    BlocProvider.of<PtechCubit>(context).onFetchPtechs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, text: "PTech", onTap: () => Get.toNamed('/')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<PtechCubit, PtechState>(builder: (context, state) {
          final List<PtechModel?> ptechs = state.field!['ptechList'];
          if (ptechs.isEmpty) {
            return Center(
                child: emptyData(context, text: "Pas des ptechs enregistrés"));
          }
          return Column(
            children: ptechs
                .map(
                  (ptech) => ProducteurCard(
                    onTap: () {},
                    timeAgo: '',
                    trailling: const SizedBox(),
                    fields: const ['Nom PTech', 'Nom intrant'],
                    values: [ptech!.name, ptech.intrants[0]['name']],
                  ),
                )
                .toList(),
          );
        }),
      ),
      floatingActionButton: floatingActionButton(
        context,
        tag: "ptech",
        onTap: () => Get.toNamed('/ptech_form'),
        icon: Icons.add_rounded,
      ),
    );
  }
}
