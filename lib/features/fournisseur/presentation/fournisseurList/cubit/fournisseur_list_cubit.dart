import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/features/fournisseur/data/fournisseur_local_data_provider.dart';
import 'package:sigi_android/features/fournisseur/data/fournisseur_model.dart';
import 'package:sigi_android/features/fournisseur/data/fournisseur_remote_data_provider.dart';
import 'package:sigi_android/features/fournisseur/logic/fournisseur_repository.dart';
part 'fournisseur_list_state.dart';

class FournisseurListCubit extends Cubit<FournisseurListState> {
  FournisseurListCubit()
      : super(FournisseurListState(fournisseurs: initialState()));

  FournisseurRepository fournisseurRepository = FournisseurRepository(
      FournisseurLocalDataProvider(), FournisseurRemoteDataProvider());

  void onLoadFournisseurs() async {
    emit(FournisseurListState(fournisseurs: {
      ...state.fournisseurs!,
      'loading': true,
    }));

    // await Future.delayed(Duration(seconds: 5));

    List<Fournisseur>? fournisseurs =
        await fournisseurRepository.fetchFournisseurs();

    // if (fournisseurs == null) {
    //   emit(FournisseurListState(fournisseurs: {
    //     ...state.fournisseurs!,
    //     'loading': false,
    //   }));
    //   return;
    // }

    emit(FournisseurListState(fournisseurs: {
      ...state.fournisseurs!,
      'fournisseursList': fournisseurs ?? <Fournisseur>[],
      'loading': false,
    }));
  }

  void onRefreshFournisseurs(Fournisseur fournisseur) async {
    print('***refresh fournisseurList: $fournisseur');
    emit(FournisseurListState(fournisseurs: {
      ...state.fournisseurs!,
      'loading': true,
    }));

    List<Fournisseur> fournisseurs = [
      fournisseur,
      ...state.fournisseurs!['fournisseursList']
    ];
    print('fournisseurlist refreshed: ${fournisseurs.toString()}');
    emit(FournisseurListState(fournisseurs: {
      ...state.fournisseurs!,
      'fournisseursList': fournisseurs,
      'loading': false,
    }));
  }
}
