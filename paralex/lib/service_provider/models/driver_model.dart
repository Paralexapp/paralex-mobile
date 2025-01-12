class DeliveryResponse {
  final String id;
  final String trackingId;
  final String? deliveryStage;
  final List<DriverModel> nearbyDrivers;

  DeliveryResponse({
    required this.id,
    required this.trackingId,
    this.deliveryStage,
    required this.nearbyDrivers,
  });

  factory DeliveryResponse.fromJson(Map<String, dynamic> json) {
    return DeliveryResponse(
      id: json['id'] as String,
      trackingId: json['trackingId'] as String,
      deliveryStage: json['deliveryStage'] as String?,
      nearbyDrivers: (json['nearbyDrivers'] as List<dynamic>)
          .map((e) => DriverModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DriverModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String riderPhotoUrl;
  final String distance;

  DriverModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.riderPhotoUrl,
    required this.distance,
  });

  // Factory constructor to create Rider from JSON
  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      riderPhotoUrl: json['riderPhotoUrl'] as String,
      distance: json['distance'] as String,
    );
  }
}
