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
  final User? user;  // Made nullable
  final String lawyerName;
  final String photoUrl;
  final String aboutMe;
  final bool status;
  final DateTime time;

  Lawyer({
    required this.id,
    required this.state,
    required this.location,
    required this.supremeCourtNumber,
    required this.practiceAreas,
    this.user,  // Now nullable
    required this.lawyerName,
    required this.photoUrl,
    required this.status,
    required this.time,
    required this.aboutMe
  });

  factory Lawyer.fromJson(Map<String, dynamic> json) {
    return Lawyer(
      id: json['id'] as String? ?? '', // Handle null case
      state: json['state'] as String? ?? '',
      location: Location.fromJson(json['location'] as Map<String, dynamic>? ?? {}),
      supremeCourtNumber: json['supremeCourtNumber'] as String? ?? '',
      practiceAreas: (json['practiceAreas'] as List?)?.map((e) => e.toString()).toList() ?? [],
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
      lawyerName: json['lawyerName'] as String? ?? '',
      aboutMe: json['aboutMe'] as String? ?? '',
      photoUrl: json['photoUrl'] as String? ?? '',
      status: json['status'] as bool? ?? false,
      time: _parseDateTime(json['time'] as List? ?? []),
    );
  }

  static DateTime _parseDateTime(List<dynamic>? timeList) {
    final list = timeList ?? [];
    return DateTime(
      list.length > 0 ? list[0] as int : 1970,
      list.length > 1 ? list[1] as int : 1,
      list.length > 2 ? list[2] as int : 1,
      list.length > 3 ? list[3] as int : 0,
      list.length > 4 ? list[4] as int : 0,
      list.length > 5 ? list[5] as int : 0,
      list.length > 6 ? (list[6] as int) ~/ 1000000 : 0,
    );
  }
}
class Location {
  final double x;
  final double y;

  Location({required this.x, required this.y});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
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
  final String? name;  // Made nullable
  final String firstName;
  final String lastName;
  final String? dateOfBirth;  // Made nullable
  final String customerCode;
  final String walletId;
  final String businessId;
  final String email;
  final String userType;
  final String registrationLevel;
  final String? phoneNumber;  // Made nullable
  final String? photoUrl;  // Made nullable
  final DateTime time;
  final dynamic bailBond;
  final bool enabled;
  final String username;
  final List<dynamic>? authorities;
  final bool accountNonExpired;
  final bool accountNonLocked;
  final bool credentialsNonExpired;
  final bool accountBlocked;

  User({
    required this.id,
    this.name,  // Now nullable
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,  // Now nullable
    required this.customerCode,
    required this.walletId,
    required this.businessId,
    required this.email,
    required this.userType,
    required this.registrationLevel,
    this.phoneNumber,  // Now nullable
    this.photoUrl,  // Now nullable
    required this.time,
    this.bailBond,
    required this.enabled,
    required this.username,
    this.authorities,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
    required this.accountBlocked,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return User(
        id: '',
        firstName: '',
        lastName: '',
        customerCode: '',
        walletId: '',
        businessId: '',
        email: '',
        userType: '',
        photoUrl: '',
        registrationLevel: '',
        enabled: false,
        username: '',
        accountNonExpired: true,
        accountNonLocked: true,
        credentialsNonExpired: true,
        accountBlocked: false,
        time: DateTime.now(),
      );
    }

    return User(
      id: json['id'] as String? ?? '',
      name: json['name'] as String?,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      dateOfBirth: json['dateOfBirth']?.toString(),
      customerCode: json['customerCode'] as String? ?? '',
      walletId: json['walletId'] as String? ?? '',
      businessId: json['businessId'] as String? ?? '',
      email: json['email'] as String? ?? '',
      userType: json['userType'] as String? ?? '',
      registrationLevel: json['registrationLevel'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String?,
      photoUrl: json['photoUrl'] as String?,
      time: Lawyer._parseDateTime(json['time'] as List?),
      bailBond: json['bailBond'],
      enabled: json['enabled'] as bool? ?? false,
      username: json['username'] as String? ?? '',
      authorities: json['authorities'] as List<dynamic>?,
      accountNonExpired: json['accountNonExpired'] as bool? ?? true,
      accountNonLocked: json['accountNonLocked'] as bool? ?? true,
      credentialsNonExpired: json['credentialsNonExpired'] as bool? ?? true,
      accountBlocked: json['accountBlocked'] as bool? ?? false,
    );
  }
}