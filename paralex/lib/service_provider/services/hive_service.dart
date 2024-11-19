import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paralax/service_provider/repo/local/local_storage.dart';

class HiveService {
  static Box<bool?> loggedInBox = Hive.box<bool?>('loggedIn');
  static Box<LocalStorage> localStorageBox = Hive.box<LocalStorage>('localStorage');

  // static Future<void> registerHive() async {
  //   await Hive.initFlutter();
  //   Hive.registerAdapter(LocalStorageAdapter());
  //   await Hive.openBox<bool?>('loggedIn');
  //   await Hive.openBox<LocalStorage?>('localStorage');
  // }

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
  LocalStorage? getLocalStorage() {
    try {
      return localStorageBox.get('localStorage');
    } catch (e) {
      log('$e');
      return null;
    }
  }

  void updateLoggedIn(bool? bool) {
    if (bool != null) {
      loggedInBox.put('loggedIn', bool);
      log('loggedIn: $bool');
    }
    else{
      log('bool is null');
    }
  }
  void updateLocalStorage(LocalStorage? localStorage) {
    if (localStorage != null) {
      localStorageBox.put('localStorage', localStorage);
      log('localStorage: $localStorage');
    }
    else{
      log('local storage is null');
    }
  }


  Future<void> deleteLoggedIn() async {
    await loggedInBox.delete('loggedIn');
    log('logged in box is deleted');
  }
  Future<void> deleteLocalStorage() async {
    await localStorageBox.delete('localStorage');
    log('local storage is deleted');
  }
}

///flutter packages pub run build_runner build