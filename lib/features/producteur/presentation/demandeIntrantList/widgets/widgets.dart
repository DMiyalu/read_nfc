import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/widgets/widgets.dart';
import 'package:sigi_android/features/producteur/data/fundingRequest/funding_request_model.dart';
import 'package:sigi_android/features/producteur/presentation/demandeIntrantList/cubit/demande_intrant_list_cubit.dart';
import 'package:sigi_android/features/producteur/presentation/demandeIntrantList/widgets/producteur_card.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget savedList(context) {
  return SingleChildScrollView(
    child: Column(children: [
      // _subtitle(context, text: 'Liste des demandes intrants'),
      BlocBuilder<DemandeIntrantListCubit, DemandeIntrantListState>(
          builder: (context, state) {
        List<FundingRequest>? _demandeIntrants = state.field!['data'];

        if (_demandeIntrants!.isEmpty) {
          return Center(
              child: emptyData(context, text: 'Pas des demandes enregistrées'));
        }
        return Column(
          children: _demandeIntrants.map<Widget>((FundingRequest intrant) {
            // DateTime _date = DateTime.parse("2022-07-23");
            // String _formatTime = timeago.format(_date, locale: 'fr_short');
            return ProducteurCard(
              // producer: producer,
              // timeAgo: _formatTime,
              onTap: () => () {},
              fields: const ['Ptech', 'Longueur', 'Largeur'],
              values: [intrant.ptech, intrant.length, intrant.width],
            );
          }).toList(),
        );
      }),
    ]),
  );
}

Widget _subtitle(context, {required String text}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    width: double.infinity,
    decoration: BoxDecoration(
        border: Border(
      bottom: BorderSide(
        color: Theme.of(context).colorScheme.secondary.withOpacity(.3),
        width: 1,
      ),
      top: BorderSide.none,
      left: BorderSide.none,
      right: BorderSide.none,
    )),
    child: Text(
      text,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 14,
          ),
      textAlign: TextAlign.left,
    ),
  );
}
