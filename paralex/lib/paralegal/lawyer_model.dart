class Lawyer {
  final String? imgPath;
  final String lawyerName;
  final String specialization;
  final double rating;
  final int reviewCount;
  final double hourlyRates;

  Lawyer({
    this.imgPath,
    required this.lawyerName,
    required this.specialization,
    required this.rating,
    required this.reviewCount,
    required this.hourlyRates,
  });
  factory Lawyer.fromJson(Map<String, dynamic> json) {
    return Lawyer(
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
