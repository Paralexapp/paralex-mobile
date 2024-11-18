import 'package:flutter/material.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/service_provider/view/signup_screens/widgets/textfieldWidget.dart';
import 'package:get/get.dart';
import '../../../../../paralegal/lawyer_list.dart';
import '../../../../../paralegal/lawyer_model.dart';
import '../../../../../service_provider/view/widgets/custom_text_field.dart';

class LawyerHome extends StatefulWidget {
  const LawyerHome({super.key});

  @override
  State<LawyerHome> createState() => _LawyerHomeState();
}

class _LawyerHomeState extends State<LawyerHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = [
    'CORPORATE LAW',
    'LAND LAW',
    'FAMILY LAW',
    'CRIMINAL LAW',
    "INTELLECTUAL PROPERTY LAW",
    "ENVIRONMENTAL LAW",
    "CIVIL RIGHT LAW"
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
              fontSize: 16, letterSpacing: 0, fontWeight: FontWeight.bold,color: Color(0xFF35124E)),
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
              onChanged: (value){
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
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
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
                  return LawyerList(specialization: tab,searchQuery: searchQuery,);
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
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
      Divider(),
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
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lawyerName,
                  style: FontStyles.headingText
                      .copyWith(color: PaintColors.paralexpurple, fontSize: 20),
                ),
                Text(
                  specialization,
                  style: FontStyles.smallCapsIntro.copyWith(
                      letterSpacing: 0,
                      fontSize: 12,
                      color: PaintColors.generalTextsm),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.star,
                      size: 10,
                      color: Color(0xAAFFC403),
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${rating.toString()}   (${reviewCount.toString()} Reviews)",
                          style: FontStyles.smallCapsIntro.copyWith(
                              letterSpacing: 0,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: PaintColors.generalTextsm),
                        ),
                        SizedBox(width: size.width * 0.2),
                        Text(
                          "₦${hourlyRates.toString()} per hour",
                          style: FontStyles.smallCapsIntro.copyWith(
                              letterSpacing: 0,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: PaintColors.generalTextsm),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
       Divider()
      ],
    );
  }
}

List<Lawyer> lawyers = [
  Lawyer(
    imgPath: 'assets/images/law_catalogue.png',
    lawyerName: 'Jubril Onikoyi',
    specialization: 'LAND LAW',
    rating: 4.7,
    reviewCount: 122,
    hourlyRates: 500.0,
  ),
  Lawyer(
    lawyerName: 'Aisha Bello',
    specialization: 'CORPORATE LAW',
    rating: 4.5,
    reviewCount: 98,
    hourlyRates: 750.0,
  ),
  Lawyer(
    lawyerName: 'Ahmed Suleiman',
    specialization: 'FAMILY LAW',
    rating: 4.8,
    reviewCount: 76,
    hourlyRates: 450.0,
  ),
  Lawyer(
    imgPath: "assets/images/lady.jpeg",
    lawyerName: 'Ifeanyi Okeke',
    specialization: 'CORPORATE LAW',
    rating: 4.9,
    reviewCount: 134,
    hourlyRates: 600.0,
  ),
  Lawyer(
    lawyerName: 'Femi Falana (SAN)',
    specialization: 'CRIMINAL LAW',
    rating: 4.9,
    reviewCount: 134,
    hourlyRates: 600.0,
  ),
];


