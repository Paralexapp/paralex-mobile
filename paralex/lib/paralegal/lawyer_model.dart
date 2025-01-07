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

List<Lawyer> parseLawyers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  debugPrint('parsed>>>$parsed');
  return parsed.map<Lawyer>((json) => Lawyer.fromJson(json)).toList();
}

class Lawyer {
  final String id;
  final String state;
  final Location location;
  final String supremeCourtNumber;
  final List<String> practiceAreas;
  final User user;
  final String lawyerName;
  final bool status;
  final String? time;

  Lawyer({
    required this.id,
    required this.state,
    required this.location,
    required this.supremeCourtNumber,
    required this.practiceAreas,
    required this.user,
    required this.lawyerName,
    required this.status,
    this.time,
  });

  // Manual fromJson method
  factory Lawyer.fromJson(Map<String, dynamic> json) {
    return Lawyer(
      id: json['id'] ?? '',
      state: json['state'] ?? '',
      location: Location.fromJson(json['location']),
      supremeCourtNumber: json['supremeCourtNumber'] ?? '',
      practiceAreas: List<String>.from(json['practiceAreas']),
      user: User.fromJson(json['user']),
      lawyerName: json['lawyerName'] ?? '',
      status: json['status'] ?? '',
      time: json['time'] ?? '',
    );
  }

  // Manual toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state': state,
      'location': location.toJson(),
      'supremeCourtNumber': supremeCourtNumber,
      'practiceAreas': practiceAreas,
      'user': user.toJson(),
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
      x: json['x'].toDouble() ?? 0,
      y: json['y'].toDouble() ?? 0,
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
  final String name;
  final String firstName;
  final String lastName;
  final String? dateOfBirth;
  final String? customerCode;
  final String email;
  final String userType;
  final String registrationLevel;
  final String phoneNumber;
  final String? photoUrl;
  final String? time;
  final String? bailBond;
  final bool enabled;
  final String username;
  final List<String>? authorities;
  final bool accountNonExpired;
  final bool accountNonLocked;
  final bool credentialsNonExpired;

  User({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
    this.customerCode,
    required this.email,
    required this.userType,
    required this.registrationLevel,
    required this.phoneNumber,
    this.photoUrl,
    this.time,
    this.bailBond,
    required this.enabled,
    required this.username,
    this.authorities,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      customerCode: json['customerCode'] ?? '',
      email: json['email'] ?? '',
      userType: json['userType'] ?? '',
      registrationLevel: json['registrationLevel'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      photoUrl: json['photoUrl'] ?? 'assets/images/law_catalogue.png',
      time: json['time'],
      bailBond: json['bailBond'] ?? '',
      enabled: json['enabled'] ?? '',
      username: json['username'] ?? '',
      authorities:
          json['authorities'] != null ? List<String>.from(json['authorities']) : null,
      accountNonExpired: json['accountNonExpired'] ?? '',
      accountNonLocked: json['accountNonLocked'] ?? '',
      credentialsNonExpired: json['credentialsNonExpired'] ?? '',
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
      'email': email,
      'userType': userType,
      'registrationLevel': registrationLevel,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'time': time,
      'bailBond': bailBond,
      'enabled': enabled,
      'username': username,
      'authorities': authorities,
      'accountNonExpired': accountNonExpired,
      'accountNonLocked': accountNonLocked,
      'credentialsNonExpired': credentialsNonExpired,
    };
  }
}
