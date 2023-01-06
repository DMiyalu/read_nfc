class SupervisorState {
  Map? field;
  SupervisorState({this.field});
}

Map? initialState() {
  return {
    'data': {
      'text': '',
      'photos': [],
    },
    'supervisionList': [],
    'sending': false,
    'showImageRequired': false,
    'status': 0,
  };
}
