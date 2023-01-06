class ControlState {
  Map? field;
  ControlState({this.field});
}

Map? initialState() {
  return {
    'data': {
      'text': '',
      'photos': [],
    },
    'controlList': [],
    'sending': false,
    'showImageRequired': false,
    'status': 0,
  };
}
