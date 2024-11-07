import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:paralax/reusables/paints.dart';
import 'package:paralax/routes/navs.dart';
import 'package:paralax/screens/users/account/pages/Paralegal/bond/bond_step_1.dart';

class ParalegalDashboard extends StatelessWidget {
  const ParalegalDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Services"),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MenuWithImages(
                        image: "assets/images/book.png",
                        text: "Legal Assistance\n Service"),
                    const MenuWithImages(
                        image: "assets/images/litigation.png",
                        text: "Litigation\n Support"),
                    MenuWithImages(
                        navTo: () => Get.toNamed(Nav.bondStepA),
                        image: "assets/images/bond.png",
                        text: "Bail Bond\n Service"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(220),
        child: Container(
            decoration: _boxDecoration(),
            child: Column(
              children: [
                _topBar(context),
                const SizedBox(
                  height: 5,
                ),
                _searchBox(),
              ],
            )

            // _tabBar(),
            ));
  }

  BoxDecoration _boxDecoration() {
    return const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        gradient: LinearGradient(
            colors: [Colors.green, Color(0xAA006138)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter));
  }

  Widget _topBar(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            // padding: EdgeInsets.all(25),
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
                color: PaintColors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Center(
              child: InkWell(
                onTap: () => Get.toNamed(Nav.home),
                child: const Icon(
                  Iconsax.arrow_left_3,
                  color: Color(0xAA006138),
                ),
              ),
            ),
          ),
          SizedBox(width: size.width * 0.19),
          Center(
            child: Text(
              "Paralagal",
              style: FontStyles.headingText.copyWith(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  Widget _searchBox() {
    return Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF2F2F2),
            prefixIcon: Icon(Icons.search), // Search icon
            labelText: 'Search',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ));
  }
}

class MenuWithImages extends StatelessWidget {
  const MenuWithImages(
      {super.key, this.navTo, required this.text, required this.image});
  final String text;
  final String image;
  final VoidCallback? navTo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: navTo,
            child: Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: PaintColors.paralaxpurple),
              child: Center(
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            textAlign: TextAlign.center,
            text,
            style: FontStyles.smallCapsIntro.copyWith(
                letterSpacing: 0,
                color: PaintColors.generalTextsm,
                fontWeight: FontWeight.bold),
          ))
        ],
      ),
    );
  }
}
