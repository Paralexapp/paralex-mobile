import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/users/account/pages/lawyer/lawyer_home.dart';
import 'lawyer_model.dart';
import 'lawyer_profile.dart';
class LawyerList extends StatelessWidget {
  final String specialization;
  final String searchQuery;

  const LawyerList({Key? key, required this.specialization,this.searchQuery = "",}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Lawyer> getLawyersBySpecialization(String specialization) {
      final filtered = lawyers
          .where((lawyer) =>
      lawyer.specialization == specialization &&
          lawyer.lawyerName.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      return filtered;
    }
    // Get the filtered list of lawyers based on specialization
    final filteredLawyers = getLawyersBySpecialization(specialization);

    if (filteredLawyers.isEmpty) {
      // Display a message if no lawyers are found
      return Center(
        child: Text('No lawyers found for $specialization'),
      );
    }

    // Return a ListView of Lawyers
    return ListView.builder(
      itemCount: filteredLawyers.length,
      itemBuilder: (context, index) {
        final lawyer = filteredLawyers[index];
        return InkWell(
          onTap: () {
            Get.to(() => LawyerProfile(
              imgPath: lawyer.imgPath,
              lawyerName: lawyer.lawyerName,
              specialization: lawyer.specialization,
              rating: lawyer.rating,
              reviewCount: lawyer.reviewCount,
              hourlyRates: lawyer.hourlyRates,
            ));
          },
          child: Lawyers(
            imgPath: lawyer.imgPath,
            lawyerName: lawyer.lawyerName,
            specialization: lawyer.specialization,
            rating: lawyer.rating,
            reviewCount: lawyer.reviewCount,
            hourlyRates: lawyer.hourlyRates,
          ),
        );
      },
    );
  }
}
