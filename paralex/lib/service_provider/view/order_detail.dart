import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paralex/service_provider/view/widgets/package_detail_widget.dart';
import '../../reusables/fonts.dart';
import '../../reusables/paints.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: PaintColors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF222B45),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Order Detail",
          style: FontStyles.smallCapsIntro.copyWith(
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFFE4E9F2)),
                  child: SvgPicture.asset(
                    "assets/images/blue_blank_human_image.svg",
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  "Anna Nguyen",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  "+\$ 32.23",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Stack(
              children: [
                // Vertical Line
                Positioned(
                  left: 20,
                  top: 45,
                  bottom: 45,
                  child: Container(
                    width: 2,
                    color: Colors.grey,
                  ),
                ),
                // ListTiles
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.circle, color: Colors.blue,size: 10,), // Replace with PaintColors.paralexpurple
                      title: Text("8 Country Road 11/6"),
                      subtitle: Text("Mannington, WV, 26582 United States"),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_on, color: Color(0xFF4B545A),size: 10,), // Replace with PaintColors.paralexpurple
                      title: Text("1124 Cave Road"),
                      subtitle: Text("Gillette, WV, 26582 United States"),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "Package Information",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Number Of Package: 2",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,),
            ),
            SizedBox(height: 10),
            PackageDetailWidget()
          ],
        ),
      ),
    );
  }
}

