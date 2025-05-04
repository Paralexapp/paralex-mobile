import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/paralegal/lawyer_controller.dart';
import '../screens/users/account/pages/lawyer/lawyer_home.dart';
import 'lawyer_model.dart';
import 'lawyer_profile.dart';

class LawyerList extends StatelessWidget {
  final LawyerController _controller = Get.put(LawyerController());
  final String specialization;
  final String searchQuery;

  LawyerList({
    super.key,
    required this.specialization,
    this.searchQuery = "",
  });

  @override
  Widget build(BuildContext context) {
    List<Lawyer> getLawyersBySpecialization(String specialization) {
      final filtered = _controller.lawyersList
          .where((lawyer) =>
              lawyer.practiceAreas
                  .any((test) => test.toLowerCase() == specialization.toLowerCase()) &&
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
                  imgPath: lawyer.user?.photoUrl,
                  lawyerName: lawyer.lawyerName,
                  specialization: lawyer.practiceAreas.toString(),
                  rating: 4.5,
                  reviewCount: 2,
                  hourlyRates: 1500,
                  lawyer: lawyer,
                ));
          },
          child: Lawyers(
            imgPath: lawyer.user?.photoUrl,
            lawyerName: lawyer.lawyerName,
            specialization: lawyer.practiceAreas.join(','),
            rating: 4.5,
            reviewCount: 2,
            hourlyRates: 1500,
          ),
        );
      },
    );
  }
}
