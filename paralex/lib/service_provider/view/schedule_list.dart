import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../reusables/fonts.dart';
import '../../reusables/paints.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFAFCFE),
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
            "My Schedule",
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
              Text(
                "Upcoming",
                style: FontStyles.headingText.copyWith(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 20),
              DeliveryScheduleWidget(
                  date: "15/07/2023",
                  place: "San Jose",
                  status: Status.Approved),
              SizedBox(height: 20),
              Text(
                "Futures",
                style: FontStyles.headingText.copyWith(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 20),
              DeliveryScheduleWidget(
                  date: "23/07/2023",
                  place: "San Fransisco",
                  status: Status.Pending),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0x30979797))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/images/package.png"),
                        SizedBox(width: 8),
                        Container(
                          width: 150,
                          child: Text(
                            "15/08/2023 | San Jose",
                            softWrap: true,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF21252C),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.search,size: 28,color: Colors.black,),
                    Text("Looking for orders\n...",style: TextStyle(fontSize: 14,color: Colors.black),)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

enum Status {
  Approved,
  Pending,
}

class DeliveryScheduleWidget extends StatelessWidget {
  const DeliveryScheduleWidget(
      {super.key,
      required this.date,
      required this.place,
      required this.status});

  final String date;
  final String place;
  final Status status;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0x30979797))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row with date and location
          Row(
            children: [
              Image.asset("assets/images/package.png"),
              SizedBox(width: 8),
              Container(
                width: 150,
                child: Text(
                  "$date | $place",
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF21252C),
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: 73,
                height: 22,
                decoration: BoxDecoration(
                    color: status.name == "Approved"
                        ? Color(0x3027FF8A)
                        : Color(0x304C1044),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    status.name,
                    style: TextStyle(
                        fontSize: 12,
                        color: status.name == "Approved"
                            ? Color(0xFF27FF8A)
                            : Color(0xFF4C1044)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.arrow_drop_down_circle_sharp,
                    color: PaintColors.paralexpurple,
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        6,
                        (index) => Container(
                          width: 2,
                          height: 2,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ), // Custom dashed line
                ],
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "8 County Road 11/6",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF21252C)),
                  ),
                  Text(
                    "Mannington, WV, 26582, United States",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Icon(Icons.location_on, color: Colors.red),
                  SizedBox(height: 4),
                ],
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1124 Cave Road",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF21252C)),
                  ),
                  Text(
                    "Gillette, WV, 26582, United States",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
