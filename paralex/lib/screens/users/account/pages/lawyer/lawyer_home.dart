import 'package:flutter/material.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:get/get.dart';
import '../../../../../paralegal/lawyer_list.dart';
import '../../../../../paralegal/lawyer_model.dart';
import '../../../../../service_provider/view/widgets/custom_text_field.dart';

class LawyerHome extends StatefulWidget {
  const LawyerHome({super.key});

  @override
  State<LawyerHome> createState() => _LawyerHomeState();
}

class _LawyerHomeState extends State<LawyerHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = [
    // 'CORPORATE LAW',
    // 'LAND LAW',
    // 'FAMILY LAW',
    // 'CRIMINAL LAW',
    // "INTELLECTUAL PROPERTY LAW",
    // "ENVIRONMENTAL LAW",
    // "CIVIL RIGHT LAW"
    "CRIMINAL LAW",
    "LAND LAW",
    "INTELLECTUAL PROPERTY",
    "ALTERNATIVE DISPUTE RESOLUTION PRACTICES.",
    "AVIATION",
    "BANKING AND FINANCE",
    "BUSINESS ESTABLISHMENT AND CORPORATE IMMIGRATION",
    "CAPITAL MARKETS",
    "COMPANY SECRETARIAL SERVICES",
    "COMPLIANCE AND INVESTIGATION",
    "CORPORATE ADVISORY",
    "CORPORATE GOVERNANCE",
    "EMPLOYMENT",
    "ENERGY AND NATURAL RESOURCES",
    "ENTERTAINMENTS",
    "HUMAN RIGHTS",
    "INTERNATIONAL LAW",
    "INTERNATIONAL TRADE",
    "LITIGATION",
    "CIVIL AND CRIMINAL",
    "MERGERS, ACQUISITIONS AND RESTRUCTURING",
    "TELECOMMUNICATIONS, MEDIA AND TECHNOLOGY",
    "INFORMATION TECHNOLOGY",
    "OIL AND GAS",
    "POWER",
    "PROBONO",
    "PUBLIC POLICY AND REGULATIONS",
    "REAL ESTATE AND PROPERTY MANAGEMENT",
    "SHIPPING, MARITIME LEGAL ADVISORY",
    "TAX",
    "STARTUP FUNDING",
    "FAMILY LAW",
    "CORPORATE LAW",
    "INTELLECTUAL PROPERTY",
    "REAL ESTATE",
    "EMPLOYMENT LAW",
    "PERSONAL INJURY",
    "IMMIGRATION LAW"

  ];

  String searchQuery = ""; // Add search query state
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Trigger a rebuild on tab change
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaintColors.white,
      appBar: AppBar(
        backgroundColor: PaintColors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF35124E),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Get a Lawyer",
          style: FontStyles.smallCapsIntro.copyWith(
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF35124E)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Find a lawyer",
              style: FontStyles.headingText
                  .copyWith(color: PaintColors.paralexpurple, fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hintText: "Search Lawyer",
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            TabBar(
              controller: _tabController,
              tabs: tabs
                  .map(
                    (tab) => Transform.translate(
                      offset: Offset(-60, 0),
                      child: Tab(
                        child: Container(
                          decoration: BoxDecoration(
                            color: _tabController.index == tabs.indexOf(tab)
                                ? PaintColors.paralexpurple
                                : PaintColors.fadedPinkBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          //alignment: Alignment.centerLeft,
                          padding:
                              const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                          child: Text(
                            tab,
                            style: TextStyle(
                              color: _tabController.index == tabs.indexOf(tab)
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              isScrollable: true,
              labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              indicator: BoxDecoration(color: Colors.transparent),
              dividerColor: Colors.transparent,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabs.map((tab) {
                  return LawyerList(
                    specialization: tab,
                    searchQuery: searchQuery,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Lawyers extends StatelessWidget {
  const Lawyers(
      {super.key,
      this.imgPath,
      required this.lawyerName,
      required this.specialization,
      required this.rating,
      required this.reviewCount,
      required this.hourlyRates});

  final String? imgPath;
  final String lawyerName;
  final String specialization;
  final double rating;
  final int reviewCount;
  final double hourlyRates;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  // image: AssetImage(imgPath ?? "assets/images/law_catalogue.png"),
                  image: _getImageProvider(imgPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 10),
            Expanded(
              // This ensures the column takes remaining space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lawyerName,
                    style: FontStyles.headingText.copyWith(
                      color: PaintColors.paralexpurple,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    specialization,
                    style: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      fontSize: 12,
                      color: PaintColors.generalTextsm,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    width: double.infinity, // Constrains the inner Row
                    child: Row(
                      children: [
                        // const Icon(
                        //   Icons.star,
                        //   size: 10,
                        //   color: Color(0xAAFFC403),
                        // ),
                        // Expanded(
                        //   // Takes remaining space for rating text
                        //   child: Text(
                        //     "${rating.toString()}   (${reviewCount.toString()} Reviews)",
                        //     style: FontStyles.smallCapsIntro.copyWith(
                        //       letterSpacing: 0,
                        //       fontSize: 10,
                        //       fontWeight: FontWeight.bold,
                        //       color: PaintColors.generalTextsm,
                        //     ),
                        //   ),
                        // ),
                        // Text(
                        //   "₦${hourlyRates.toString()} per hour",
                        //   style: FontStyles.smallCapsIntro.copyWith(
                        //     letterSpacing: 0,
                        //     fontSize: 10,
                        //     fontWeight: FontWeight.bold,
                        //     color: PaintColors.generalTextsm,
                        //   ),
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
  // Helper method (add inside the Lawyers widget class)
  ImageProvider _getImageProvider(String? path) {
    if (path != null && path.isNotEmpty && path.startsWith('http')) {
      return NetworkImage(path);
    } else {
      return AssetImage('assets/images/dummy-dp.png') as ImageProvider;    }
  }
}

List<Lawyer2> lawyers = [
  Lawyer2(
    imgPath: 'assets/images/law_catalogue.png',
    lawyerName: 'Jubril Onikoyi',
    specialization: 'LAND LAW',
    rating: 4.7,
    reviewCount: 122,
    hourlyRates: 500.0,
  ),
  Lawyer2(
    lawyerName: 'Aisha Bello',
    specialization: 'CORPORATE LAW',
    rating: 4.5,
    reviewCount: 98,
    hourlyRates: 750.0,
  ),
  Lawyer2(
    lawyerName: 'Ahmed Suleiman',
    specialization: 'FAMILY LAW',
    rating: 4.8,
    reviewCount: 76,
    hourlyRates: 450.0,
  ),
  Lawyer2(
    imgPath: "assets/images/lady.jpeg",
    lawyerName: 'Ifeanyi Okeke',
    specialization: 'CORPORATE LAW',
    rating: 4.9,
    reviewCount: 134,
    hourlyRates: 600.0,
  ),
  Lawyer2(
    lawyerName: 'Femi Falana (SAN)',
    specialization: 'CRIMINAL LAW',
    rating: 4.9,
    reviewCount: 134,
    hourlyRates: 600.0,
  ),
];
