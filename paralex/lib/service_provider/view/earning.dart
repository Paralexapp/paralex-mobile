import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';

class Earning extends StatefulWidget {
  const Earning({super.key});

  @override
  State<Earning> createState() => _EarningState();
}

class _EarningState extends State<Earning> {
  String _selected = "Day";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaintColors.paralexpurple,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Color(0xFFFAFCFE),
                child: Stack(
                  clipBehavior: Clip
                      .none, // Ensures cards can overflow the purple container
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: PaintColors.paralexpurple,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: Color(0x50ffffff),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.menu,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Earnings",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: Color(0x50ffffff),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.notifications_outlined,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Jun 19 - Jun 25",
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          Text(
                            "\$ 2,144.06",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top:
                          120, // Ensures the Row overlaps with the purple container
                      left: 12,
                      right: 12,
                      child: Row(
                        children: [
                          Expanded(
                            child: EarningsCard(title: "Orders", value: "123"),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child:
                                EarningsCard(title: "Online", value: "23h 39m"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                color: Color(0xFFFAFCFE),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Toggle Buttons
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 48.0),
                                child: Container(
                                  //height: 33,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFE2E7F1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children:
                                        ['Day', 'Week', 'Month'].map((option) {
                                      final isSelected = _selected == option;
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selected = option;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Colors.white
                                                : Color(0xFFE2E7F1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: Text(
                                            option,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),

                              // Bar Chart
                              SizedBox(
                                height: 200,
                                child: BarChart(
                                  BarChartData(
                                    alignment: BarChartAlignment.spaceAround,
                                    maxY: 2000,
                                    barTouchData: BarTouchData(enabled: false),
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize:
                                              40, // Space for the titles on the left axis
                                          getTitlesWidget: (value, meta) {
                                            return Text(
                                              value
                                                  .toInt()
                                                  .toString(), // Y-axis values
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            );
                                          },
                                        ),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, meta) {
                                            switch (value.toInt()) {
                                              case 0:
                                                return Text("Mo",
                                                    style: TextStyle(
                                                        color: Colors.black));
                                              case 1:
                                                return Text("Tu",
                                                    style: TextStyle(
                                                        color: Colors.black));
                                              case 2:
                                                return Text("We",
                                                    style: TextStyle(
                                                        color: Colors.black));
                                              case 3:
                                                return Text("Th",
                                                    style: TextStyle(
                                                        color: Colors.black));
                                              case 4:
                                                return Text("Fr",
                                                    style: TextStyle(
                                                        color: Colors.black));
                                              case 5:
                                                return Text("Sa",
                                                    style: TextStyle(
                                                        color: Colors.black));
                                              case 6:
                                                return Text("Su",
                                                    style: TextStyle(
                                                        color: Colors.black));
                                              default:
                                                return Text("");
                                            }
                                          },
                                        ),
                                      ),
                                      topTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                      rightTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                    ),
                                    gridData: FlGridData(
                                      show: true, // Enable grid lines
                                      drawHorizontalLine:
                                          true, // Enable horizontal grid lines
                                      drawVerticalLine:
                                          false, // Disable vertical grid lines
                                      getDrawingHorizontalLine: (value) {
                                        // Customize the appearance of each horizontal line
                                        return FlLine(
                                          color: Colors.grey.withOpacity(
                                              0.5), // Line color and transparency
                                          strokeWidth: 1.0, // Line thickness
                                          //dashArray: [5, 5], // Dashed line pattern [gap, length]
                                        );
                                      },
                                    ),
                                    borderData: FlBorderData(show: false),
                                    barGroups: [
                                      BarChartGroupData(x: 0, barRods: [
                                        BarChartRodData(
                                            toY: 1000,
                                            color: PaintColors.paralexpurple)
                                      ]),
                                      BarChartGroupData(x: 1, barRods: [
                                        BarChartRodData(
                                            toY: 2000,
                                            color: PaintColors.paralexpurple)
                                      ]),
                                      BarChartGroupData(x: 2, barRods: [
                                        BarChartRodData(
                                            toY: 500,
                                            color: PaintColors.paralexpurple)
                                      ]),
                                      BarChartGroupData(x: 3, barRods: [
                                        BarChartRodData(
                                            toY: 1500,
                                            color: PaintColors.paralexpurple)
                                      ]),
                                      BarChartGroupData(x: 4, barRods: [
                                        BarChartRodData(
                                            toY: 2000,
                                            color: PaintColors.paralexpurple)
                                      ]),
                                      BarChartGroupData(x: 5, barRods: [
                                        BarChartRodData(
                                            toY: 500,
                                            color: PaintColors.paralexpurple)
                                      ]),
                                      BarChartGroupData(x: 6, barRods: [
                                        BarChartRodData(
                                            toY: 1000,
                                            color: PaintColors.paralexpurple)
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              CustomButton(
                                  desiredWidth: 0.9,
                                  buttonText: "Detail",
                                  buttonColor: PaintColors.paralexpurple)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recent orders",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(
                                color: PaintColors.paralexpurple,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding:const EdgeInsets.symmetric(horizontal: 12.0),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFDBE8FF),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Saturday",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              "17/06/2023",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    OrderWidget(orderNo: "123", orderAmount: "31.23"),
                    OrderWidget(orderNo: "567", orderAmount: "61.23"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EarningsCard extends StatelessWidget {
  final String title;
  final String value;

  const EarningsCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: PaintColors.paralexpurple,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderWidget extends StatelessWidget {
  const OrderWidget(
      {super.key, required this.orderNo, required this.orderAmount});

  final String orderNo;
  final String orderAmount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0,right: 24.0,top: 8.0,bottom: 8.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: PaintColors.paralexpurple,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              Icons.menu,
              size: 13,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 15),
          Text(
            "Order #$orderNo",
            style: TextStyle(
              color: Colors.black,
              fontSize: 11,
            ),
          ),
          Spacer(),
          Text(
            "+ \$$orderAmount",
            style: TextStyle(
                color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
