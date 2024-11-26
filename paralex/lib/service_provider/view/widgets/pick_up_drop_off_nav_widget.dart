import 'package:flutter/material.dart';
import '../../../enums/points.dart';
import '../../../reusables/paints.dart';

class PickUpDropOffNavWidget extends StatelessWidget {
  const PickUpDropOffNavWidget(
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
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
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
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: PaintColors.paralexpurple),
              ),
              child: Icon(
                Icons.near_me,
                size: 18,
                color: PaintColors.paralexpurple,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.translate(
                offset: Offset(0, -20),
                child: Text(
                  address,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                "Navigate",
                style:
                TextStyle(fontSize: 10, color: PaintColors.paralexpurple),
              ),
            ],
          ),
          Transform.translate(
            offset: Offset(0, -20),
            child: Container(
              child: Text(
                addressContd,
                maxLines: 2,
                softWrap: true,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}