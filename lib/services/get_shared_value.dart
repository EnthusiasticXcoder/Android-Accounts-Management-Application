import 'package:shared_preferences/shared_preferences.dart';

class GetSharedValue {
  String _text = 'Android';
  late final SharedPreferences _instance;

  static final _shared = GetSharedValue._sharedInstance();
  GetSharedValue._sharedInstance();
  factory GetSharedValue() => _shared;

  String get userName => _text;

  Future<void> setinstance() async {
    _instance = await SharedPreferences.getInstance();
    gettext();
  }

  void setvalue({required String value}) {
    if (value.isNotEmpty) _text = value;
    _instance.setString(nameKey, value);
  }

  void gettext() {
    final value = _instance.getString(nameKey);
    if (value != null) _text = value;
  }
}

const nameKey = 'Name';
