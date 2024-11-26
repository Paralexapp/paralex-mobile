import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../enums/points.dart';
import '../../../routes/navs.dart';

class PickUpDropOffWidget extends StatelessWidget {
  const PickUpDropOffWidget(
      {super.key,
        required this.points,
        required this.tag,
        required this.address,
        required this.addressContd});

  final Points points;
  final String tag;
  final String address;
  final String addressContd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(Nav.pickUp,arguments: points);
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: points.name == "pickUpPoint"
                  ? Color(0xFF27FF8A)
                  : Color(0xFFFE0F00)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: points.name == "pickUpPoint"
                              ? Color(0xFF4C1044)
                              : Color(0xFFFE0F00)),
                      color: Colors.white),
                  child: Center(
                    child: Text(
                      tag,
                      style: TextStyle(
                          fontSize: 15,
                          color: points.name == "pickUpPoint"
                              ? Color(0xFF4C1044)
                              : Color(0xFFFE0F00)),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: points.name == "pickUpPoint"
                        ? Color(0x3027FF8A)
                        : Color(0x30FE0F00),
                  ),
                  child: Text(
                    points.name == "pickUpPoint"
                        ? "Pick-up point"
                        : "Drop-off Point",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: points.name == "pickUpPoint"
                          ? Color(0xFF27FF8A)
                          : Color(0xFFFE0F00),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  address,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Icon(Icons.phone_outlined, size: 18,),
                ),
              ],
            ),
            Container(
              child: Text(
                addressContd,
                maxLines: 2,
                softWrap: true,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}