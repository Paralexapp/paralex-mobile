import 'package:hive/hive.dart';

part 'local_storage.g.dart';

@HiveType(typeId: 1)
class LocalStorage {
  LocalStorage({this.idToken, this.phoneNumber, this.stateOfResidence, this.username, this.email, this.photoUrl, this.time});
  @HiveField(0)
  String? idToken;

  @HiveField(1)
  String? phoneNumber;

  @HiveField(2)
  String? stateOfResidence;

  @HiveField(3)
  String? username;

  @HiveField(4)
  String? email;

  @HiveField(5)
  String? photoUrl;

  @HiveField(6)
  String? time;
}
