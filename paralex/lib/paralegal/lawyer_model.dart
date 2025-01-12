import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Lawyer2 {
  final String? imgPath;
  final String lawyerName;
  final String specialization;
  final double rating;
  final int reviewCount;
  final double hourlyRates;

  Lawyer2({
    this.imgPath,
    required this.lawyerName,
    required this.specialization,
    required this.rating,
    required this.reviewCount,
    required this.hourlyRates,
  });
  factory Lawyer2.fromJson(Map<String, dynamic> json) {
    return Lawyer2(
      imgPath: json['imgPath'] ?? 'assets/images/law_catalogue.png',
      lawyerName: json['lawyerName'],
      specialization: json['specialization'],
      rating: json['rating'],
      reviewCount: json['reviewCount'],
      hourlyRates: json['hourlyRates'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imgPath': imgPath,
      'lawyerName': lawyerName,
      'specialization': specialization,
      'rating': rating,
      'reviewCount': reviewCount,
      'hourlyRates': hourlyRates,
    };
  }
}

List<Lawyer> parseLawyers(List<dynamic> responseBody) {
  // final parsed = responseBody.cast<Map<String, dynamic>>();
  // debugPrint('parsed>>>$parsed');

  return responseBody.map((json) => Lawyer.fromJson(json)).toList();
}

class Lawyer {
  final String id;
  final String state;
  final Location location;
  final String supremeCourtNumber;
  final List<String> practiceAreas;
  final User? user;
  final String lawyerName;
  final bool status;
  final List<int> time;

  Lawyer({
    required this.id,
    required this.state,
    required this.location,
    required this.supremeCourtNumber,
    required this.practiceAreas,
    this.user,
    required this.lawyerName,
    required this.status,
    required this.time,
  });

  factory Lawyer.fromJson(Map<String, dynamic> json) {
    return Lawyer(
      id: json['id'],
      state: json['state'],
      location: Location.fromJson(json['location']),
      supremeCourtNumber: json['supremeCourtNumber'],
      practiceAreas: List<String>.from(json['practiceAreas']),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      lawyerName: json['lawyerName'],
      status: json['status'],
      time: List<int>.from(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state': state,
      'location': location.toJson(),
      'supremeCourtNumber': supremeCourtNumber,
      'practiceAreas': practiceAreas,
      'user': user?.toJson(),
      'lawyerName': lawyerName,
      'status': status,
      'time': time,
    };
  }
}

class Location {
  final double x;
  final double y;

  Location({
    required this.x,
    required this.y,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      x: json['x'],
      y: json['y'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }
}

class User {
  final String id;
  final String? name;
  final String firstName;
  final String lastName;
  final String? dateOfBirth;
  final String customerCode;
  final String walletId;
  final String businessId;
  final String email;
  final String userType;
  final String registrationLevel;
  final String? phoneNumber;
  final String? photoUrl;
  final List<int> time;
  final String? bailBond;
  final bool enabled;
  final String username;
  final bool accountNonExpired;
  final bool accountNonLocked;
  final bool credentialsNonExpired;

  User({
    required this.id,
    this.name,
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
    required this.customerCode,
    required this.walletId,
    required this.businessId,
    required this.email,
    required this.userType,
    required this.registrationLevel,
    this.phoneNumber,
    this.photoUrl,
    required this.time,
    this.bailBond,
    required this.enabled,
    required this.username,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: json['dateOfBirth'],
      customerCode: json['customerCode'],
      walletId: json['walletId'],
      businessId: json['businessId'],
      email: json['email'],
      userType: json['userType'],
      registrationLevel: json['registrationLevel'],
      phoneNumber: json['phoneNumber'],
      photoUrl: json['photoUrl'],
      time: List<int>.from(json['time']),
      bailBond: json['bailBond'],
      enabled: json['enabled'],
      username: json['username'],
      accountNonExpired: json['accountNonExpired'],
      accountNonLocked: json['accountNonLocked'],
      credentialsNonExpired: json['credentialsNonExpired'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'customerCode': customerCode,
      'walletId': walletId,
      'businessId': businessId,
      'email': email,
      'userType': userType,
      'registrationLevel': registrationLevel,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'time': time,
      'bailBond': bailBond,
      'enabled': enabled,
      'username': username,
      'accountNonExpired': accountNonExpired,
      'accountNonLocked': accountNonLocked,
      'credentialsNonExpired': credentialsNonExpired,
    };
  }
}
