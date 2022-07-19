
// import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


// ///LocalStorageRepositorieContract: Interface that specifies the local storage behavior.
// abstract class LocalStorageRepositorieContract {
//   static LocalStorageRepositorieContract inject() => _LocalStorageRepositorieProvider();

//   static LocalStorageRepositorieContract get() => getIt<LocalStorageRepositorieContract>();

//   Future save(String key, String data);

//   Future getData(String key);

//   Future delete(String key);

//   Future init();

// }

class Preferences {


  static late SharedPreferences prefs;

  ///Constructor
  static Future init() async {
      prefs = await SharedPreferences.getInstance();
  }


  @override
   getData(key) async {
    return prefs.getString(key);
  }

  @override
   Future<bool> save(key, data) async {
    prefs.setString(key, data);
    return true;
  }
  @override
  Future<bool> delete(key) async {
    prefs.remove(key);
    return true;
  }
}