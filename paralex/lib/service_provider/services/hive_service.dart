import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Box<bool?> loggedInBox = Hive.box<bool?>('loggedIn');

  static Future<void> registerHive() async {
    await Hive.initFlutter();
    await Hive.openBox<bool?>('loggedIn');
    // Hive.registerAdapter(UserModelAdapter());
  }

  static Future<void> closeHive() async {
    await Hive.close();
  }


  bool? getLoggedIn() {
    try {
      return loggedInBox.get('loggedIn');
    } catch (e) {
      log('$e');
      return null;
    }
  }

  void updateUser(bool? bool) {
    if (bool != null) {
      loggedInBox.put('loggedIn', bool);
      log('loggedIn: $bool');
    }
    else{
      log('bool is null');
    }
  }


  Future<void> deleteData() async {
    await loggedInBox.delete('loggedIn');
  }
}
