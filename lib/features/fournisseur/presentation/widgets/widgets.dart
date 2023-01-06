import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/widgets/effects.dart';
import 'package:sigi_android/common/widgets/widgets.dart';
import 'package:sigi_android/features/fournisseur/data/fournisseur_model.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurList/cubit/fournisseur_list_cubit.dart';
import 'package:sigi_android/features/fournisseur/presentation/widgets/fournisseur_card.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'search_bar.dart';

Widget savedList(context) {
  return SingleChildScrollView(
    child: Column(children: [
      const SearchBar(),
      const SizedBox(height: 20),
      BlocBuilder<FournisseurListCubit, FournisseurListState>(
          builder: (context, state) {
        if (state.fournisseurs!['loading']) {
          return _loader(context);
        }

        List<Fournisseur>? _fournisseurs =
            state.fournisseurs!['fournisseursList'];

        return _fournisseurs!.isNotEmpty
            ? Column(
                children: _fournisseurs.map<Widget>((Fournisseur fournisseur) {
                  timeago.setLocaleMessages(
                      'fr_short', timeago.FrShortMessages());
                  DateTime _date = DateTime.parse("2022-07-23");
                  String _formatTime =
                      timeago.format(_date, locale: 'fr_short');
                  return FournisseurCard(
                    // timeAgo: _formatTime,
                    fournisseur: fournisseur.toJson(),
                    onTap: () => () {},
                  );
                }).toList(),
              )
            : Center(
                child: emptyData(
                  context,
                  text: 'Pas de données',
                ),
              );
      }),
    ]),
  );
}

Widget _loader(context) {
  return Center(child: loader(context));
}

// Widget _title(context, {required String text}) {
//   return Container(
//     padding: const EdgeInsets.symmetric(vertical: 10),
//     width: double.infinity,
//     decoration: BoxDecoration(
//         border: Border(
//       bottom: BorderSide(
//         color: Theme.of(context).colorScheme.secondary.withOpacity(.3),
//         width: 1,
//       ),
//       top: BorderSide.none,
//       left: BorderSide.none,
//       right: BorderSide.none,
//     )),
//     child: Text(
//       text,
//       style: Theme.of(context).textTheme.bodyText1!.copyWith(
//             fontSize: 14,
//           ),
//       textAlign: TextAlign.left,
//     ),
//   );
// }
