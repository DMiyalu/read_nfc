class ProfilState {
  Map? field;
  ProfilState({this.field});
}

Map? initialState() {
  return {
    'userProfile': {},
    'status': 0,
    'loading': false,
  };
}
