typedef SetStateFunction = void Function(void Function());


class StateController {
  static final _shared = StateController._instance();
  StateController._instance();
  factory StateController() => _shared;

  final List<SetStateFunction> _functionList = [];

  void addStateFunction(SetStateFunction stateFunction) {
    _functionList.add(stateFunction);
  }

  void setStates() {
    for (int i = 0; i < _functionList.length; i++) {
      _functionList[i](() {});
    }
  }
}
