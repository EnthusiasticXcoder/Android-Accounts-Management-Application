
typedef SetStateFunction = void Function(void Function());

class BalanceState {
  late SetStateFunction _setStateFunction;

  static final _shared = BalanceState._instance();
  BalanceState._instance();
  factory BalanceState() => _shared;

  void setFunction(SetStateFunction setStateFunction) {
    _setStateFunction = setStateFunction;
  }

  SetStateFunction get getState => _setStateFunction;
}
