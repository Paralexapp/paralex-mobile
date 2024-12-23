
class PlaceModel {
  final String name;
  final String displayName;
  final String latitude;
  final String longitude;

  PlaceModel(
      {required this.name,
      required this.displayName,
      required this.latitude,
      required this.longitude});

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      name: json['name'] ?? '',
      displayName: json['display_name'] ?? '',
      latitude: json['lat'] ?? '',
      longitude: json['lat'] ?? '',
    );
  }
}
