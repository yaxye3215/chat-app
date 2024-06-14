import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static SharedPreferences? _prefsInstances;

  static Future<SharedPreferences> get _instance async {
    _prefsInstances ??= await SharedPreferences.getInstance();
    return _prefsInstances!;
  }

  static get defValue => "";

  static Future<SharedPreferences> init() async {
    _prefsInstances = await _instance;
    return _prefsInstances!;
  }

  static String getString(String key) {
    return _prefsInstances?.getString(key) ?? defValue;
  }

  static String removeString(String key) {
    _prefsInstances?.remove(key);
    return defValue;
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }
}
