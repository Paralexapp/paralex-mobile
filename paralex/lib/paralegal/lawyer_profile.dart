import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/paralegal/lawyer_model.dart';
import 'package:paralex/paralegal/request_lawyer_form.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import '../reusables/back_button.dart';
import '../reusables/fonts.dart';
import '../reusables/paints.dart';
import 'lawyer_controller.dart';

class LawyerProfile extends StatelessWidget {
  final String? imgPath;
  final String? lawyerName;
  final String? specialization;
  final double? rating;
  final int? reviewCount;
  final double? hourlyRates;
  final Lawyer? lawyer;

  const LawyerProfile({
    super.key,
    this.imgPath,
    this.lawyerName,
    this.specialization,
    this.rating,
    this.reviewCount,
    this.hourlyRates,
    this.lawyer,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LawyerController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: Get.back, icon: PinkButton.backButton),
        centerTitle: true,
        title: Text(
          'Get a Lawyer',
          style: FontStyles.smallCapsIntro
              .copyWith(fontSize: 16, letterSpacing: 0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgPath ?? "assets/images/law_catalogue.png"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lawyerName!,
                              style: FontStyles.headingText.copyWith(
                                  color: Color(0xFF35124E),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Text(
                            //   "Lawyer based in Lagos",
                            //   style: FontStyles.smallCapsIntro.copyWith(
                            //       color: Color(0xFF4A4A68),
                            //       fontSize: 12,
                            //       letterSpacing: 0),
                            // ),
                          ],
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.3, // adjust as needed
                            ),
                            child: Text(
                              specialization!,
                              style: FontStyles.smallCapsIntro.copyWith(
                                color: Color(0xFF4A4A68),
                                fontSize: 15,
                                letterSpacing: 0,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(top: 15.0),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.end,
                        //     children: [
                        //       Text(
                        //         specialization!,
                        //         style: FontStyles.smallCapsIntro.copyWith(
                        //             color: Color(0xFF4A4A68),
                        //             fontSize: 15,
                        //             letterSpacing: 0),
                        //       ),
                        //       // Row(
                        //       //   children: [
                        //       //     Icon(
                        //       //       Icons.star,
                        //       //       color: Color(0xFFFFC403),
                        //       //       size: 12,
                        //       //     ),
                        //       //     Text(
                        //       //       rating.toString(),
                        //       //       style: FontStyles.smallCapsIntro.copyWith(
                        //       //           color: Color(0xFF4A4A68),
                        //       //           fontSize: 11,
                        //       //           letterSpacing: 0,
                        //       //           fontWeight: FontWeight.bold),
                        //       //     ),
                        //       //     SizedBox(width: 5),
                        //       //     // Text(
                        //       //     //   "(${reviewCount.toString()} Reviews)",
                        //       //     //   style: FontStyles.smallCapsIntro.copyWith(
                        //       //     //       color: Color(0xFF4A4A68),
                        //       //     //       fontSize: 11,
                        //       //     //       letterSpacing: 0),
                        //       //     // ),
                        //       //   ],
                        //       // ),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 1,
                      color: Color(0xFFE4E4E4),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "About Lawyer",
                      style: FontStyles.smallCapsIntro.copyWith(
                          color: Color(0xFF4A4A68),
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "",
                      style: FontStyles.smallCapsIntro.copyWith(
                          color: Color(0xFF4A4A68), fontSize: 12, letterSpacing: 0),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 1,
                      color: Color(0xFFE4E4E4),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: CustomButton(
                        desiredWidth: 0.90,
                        buttonText: "CONTACT  LAWYER",
                        buttonColor: PaintColors.paralexpurple,
                        ontap: () {
                          Get.to(() => RequestLawyerForm(
                                imgPath: imgPath,
                                lawyerName: lawyerName,
                                specialization: specialization,
                                rating: rating,
                                reviewCount: reviewCount,
                                hourlyRates: hourlyRates,
                              ));
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 1,
                      color: Color(0xFFE4E4E4),
                    ),
                    SizedBox(height: 15),
                    // Text(
                    //   "Reviews",
                    //   style: FontStyles.smallCapsIntro.copyWith(
                    //       color: Color(0xFF4A4A68),
                    //       fontSize: 12,
                    //       letterSpacing: 0,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(height: 15),
                    // Expanded(
                    //   child: Obx(() {
                    //     if (controller.reviews.isEmpty) {
                    //       return Center(child: CircularProgressIndicator());
                    //     }
                    //     return ListView.builder(
                    //       itemCount: controller.reviews.length,
                    //       itemBuilder: (context, index) {
                    //         final review = controller.reviews[index];
                    //         return ReviewWidget(
                    //           reviewerName: review['name'],
                    //           reviewerText: review['text'],
                    //           reviewerRating: review['rating'],
                    //           imgPath: review['imagePath'],
                    //         );
                    //       },
                    //     );
                    //   }),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  const ReviewWidget(
      {super.key,
      required this.reviewerName,
      this.reviewerText,
      this.imgPath,
      this.reviewerRating});

  final String? imgPath;
  final String reviewerName;
  final String? reviewerText;
  final String? reviewerRating;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: 1,
          color: Color(0xFFE4E4E4),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: AssetImage(imgPath ?? "assets/images/law_catalogue.png"),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      reviewerName,
                      style: FontStyles.smallCapsIntro.copyWith(
                          color: Color(0xFF646464),
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.star,
                      color: Color(0xFFFFC403),
                      size: 12,
                    ),
                    Text(
                      reviewerRating ?? "4.75",
                      style: FontStyles.smallCapsIntro.copyWith(
                          color: Color(0xFF4A4A68),
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // SizedBox(height: 8),
                // SizedBox(
                //   width: size.width * 0.6,
                //   child: Text(
                //     reviewerText ??
                //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum sit amet sem nec erat finibus tempus non a neque. Etiam arcu dolor, iaculis ut bibendum nec, tempor nec dui.",
                //     style: FontStyles.smallCapsIntro.copyWith(
                //       color: Color(0xFF8C8C8C),
                //       fontSize: 10,
                //       letterSpacing: 0,
                //     ),
                //     maxLines: 4,
                //     softWrap: true,
                //     overflow: TextOverflow.ellipsis,
                //   ),
                // ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 1,
          color: Color(0xFFE4E4E4),
        ),
      ],
    );
  }
}
