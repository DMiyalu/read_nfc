part of 'fournisseur_list_cubit.dart';

class FournisseurListState {
  Map? fournisseurs;
  FournisseurListState({this.fournisseurs});
}

Map initialState() {
  return {
    'fournisseursList': <Fournisseur>[],
    'loading': false,
  };
}
